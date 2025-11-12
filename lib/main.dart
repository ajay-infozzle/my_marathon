import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:app_links/app_links.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:marathon/data/services/analytics_service.dart';
import 'package:marathon/data/tools/decoration/res_colors.dart';
import 'package:marathon/data/tools/toast/custom_snackbar.dart';
import 'package:marathon/root_blocked_screen.dart';
import 'package:marathon/view/splash/splash_page.dart';
import 'package:root_checker_plus/root_checker_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'config/injection.dart';
import 'data/services/notification_service.dart';
import 'data/storage/app/app_prefs.dart';
import 'firebase_options.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
bool blockRootedDevice = false;
BlockReason blockReason = BlockReason.other;

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   if (kDebugMode) {
//     print('A bg message just showed up :  ${message.messageId}');
//   }
// }

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_channel', // id
  'High Importance Notifications', // title
  importance: Importance.max,
  playSound: true,
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then(
      (value) {
        log('value==========>>>>>${value.options.appId}');
        log('value==========>>>>>$value');
      },
    );
    log('FirebaseAnalytics==========>>>>>${FirebaseAnalytics.instance.isSupported()}');
    FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);

    //~
    AnalyticsService.instance.onAppOpen();
    //~
  } catch (e) {
    debugPrint("Failed to initialize Firebase: $e");
  }

  await checkSecurity(); 
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  await DIService.init();
  await Hive.initFlutter();
  await Hive.openBox(AppPrefs.appBoxId);
  await Hive.openBox(AppPrefs.naviationBoxId);
  NotificationService().getFCMToken();
  FirebaseMessaging.onBackgroundMessage(NotificationService.firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
  );

  NotificationService.getInitialMsg();
  NotificationService.showMsgHandler();
  NotificationService.onMsgOpen();
  
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async{
      log('onDidReceiveNotificationResponse-----${notificationResponse.payload}');
      if (notificationResponse.payload != null) {
        if (notificationResponse.payload != '') {
          final String targetLinkUrl = notificationResponse.payload! ;
          final Uri websitePageUri = Uri.parse(targetLinkUrl);
          if (await canLaunchUrl(websitePageUri)) {
            await launchUrl(websitePageUri, mode: LaunchMode.externalApplication);
          } else {
            customSnackBar("Something went wrong !");
          } 
        }
      }
    },
  );


  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) {
    runApp(blockRootedDevice ? MaterialApp(debugShowCheckedModeBanner: false,home: RootBlockedScreen(reason: blockReason,),) : MyApp());
  });
}

Future<void> checkSecurity() async {
  if (Platform.isAndroid) {
    final isRooted = await RootCheckerPlus.isRootChecker() ?? false;
    final isDevMode = await RootCheckerPlus.isDeveloperMode() ?? false;
    if (isRooted ) {
      log('⚠️ Rooted Android device detected!');
      blockReason = BlockReason.rooted;
      blockRootedDevice = true;
    } else if (isDevMode) {
      blockRootedDevice = true;
      blockReason = BlockReason.developerMode;
    }
  } else if (Platform.isIOS) {
    final isJailbroken = await RootCheckerPlus.isJailbreak() ?? false;
    // final isRooted = await RootCheckerPlus.isRootChecker() ?? false;
    // if (isJailbroken || isRooted) {
    if (isJailbroken) {
      log('⚠️ Jailbroken iOS device detected!');
      blockRootedDevice = true;
      blockReason = BlockReason.rooted;
    }
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _analytics = FirebaseAnalytics.instance;
  late final AppLinks _appLinks;

  @override
  void initState() {
    super.initState();
    _initDeepLinks();
  }

  Future<void> _initDeepLinks() async {
    _appLinks = AppLinks();

    // Handle link when app is opened from a deep link (terminated state)
    final uri = await _appLinks.getInitialLink();
    _handleUri(uri);

    // Handle link when app is already running (background / foreground)
    _appLinks.uriLinkStream.listen((uri) {
      _handleUri(uri);
    });
  }

  void _handleUri(Uri? uri) {
    if (uri == null) return;

    log('🔗 Deep link opened: $uri');

    if (uri.path.contains('/apartments')) {
      
    } else if (uri.path.contains('/receipt')) {
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0), boldText: false),
      child: GetMaterialApp(
        //navigatorObservers: <NavigatorObserver>[observer],
        debugShowCheckedModeBanner: false,
        title: 'My Marathon',
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: ColorRes.mainButtonColor),
          useMaterial3: true,
        ),
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: _analytics),
        ],

        home: const SplashPage(),
      ),
    );
  }
}
