import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:marathon/data/storage/app/app_holder.dart';
import 'package:marathon/data/tools/toast/custom_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../firebase_options.dart';

class NotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_channel', // id
    'High Importance Notifications', // title
    // 'This channel is used for important notifications.', // description
    importance: Importance.max,
  );

  getFCMToken() async {
    log('hello...');
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    try {
      String? token = await messaging.getToken();
      log('FcmToken===>>> $token');
      Get.find<AppHolder>().fCMToken = token ?? "";
      log('Get.find<AppHolder>().fCMToken==========>>>>>${Get.find<AppHolder>().fCMToken}');
    } catch (e) {
      log('eeee>> $e');
    }
  }

  static void showMsgHandler() {
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      log("Foreground notification message=====>${message!.notification}");
      log("Foreground notification data=====>${message.data}");
      RemoteNotification? notification = message.notification;
      // AndroidNotification? android = message.notification?.android;
      log('NOtification Call :${notification?.apple}${notification!.body}${notification.title}${notification.bodyLocKey}${notification.bodyLocKey}');

      showMsg(notification, message);
    });
  }

  //~ Handle notification when the app is terminated. //closed app
  static void getInitialMsg() async{
    // RemoteMessage? message = await FirebaseMessaging.instance.getInitialMessage();
    // log('getInitialMessage received: $message');
    // if (message != null) {
    //   log('Terminated state message data: ${message.data}');
    //   if (message.data.containsKey('screen')) {
    //     String targetScreen = message.data['screen'];
    //     log("Navigating to screen from terminated state->$targetScreen");
    //     Future.delayed(const Duration(seconds: 1), () {
    //       if (targetScreen == 'screen') {
    //         Get.to(const KycScreen());
    //       }
    //       // if (targetScreen == 'kyc_screen') {
    //       //   Get.to(const KycScreen());
    //       // }
    //     });
    //   }
    // }

    log("getInitialMsg is called=====>");
    FirebaseMessaging.instance.getInitialMessage().then((message) {
        log('getInitialMessage received: $message');
        if (message != null) {
          log('Terminated state message data: ${message.data}');
          // if (message.data.containsKey('screen')) { //~
          //   String targetScreen = message.data['screen'];
          //   log("Navigating to screen from terminated state->$targetScreen");
            
          //   WidgetsBinding.instance.addPostFrameCallback((_) {

          //     Get.find<AppHolder>().isOpenFromNotification = true;
          //     Get.find<AppHolder>().screenOpenViaNotification = targetScreen;
              
          //     // if (targetScreen == 'kyc_screen') {
          //     //   Get.to(() => const KycScreen());
          //     // }
          //     if(Get.find<AppHolder>().custId != 0){
          //       Get.to(() => const KycScreen());
          //     }
          //   });
          // }
          if (message.data.containsKey('link')) { 
            String targetLinkUrl = message.data['link'];
            log("Navigating to website from terminated state->$targetLinkUrl");
            
            WidgetsBinding.instance.addPostFrameCallback((_) async{

              Get.find<AppHolder>().isOpenFromNotification = true;
              Get.find<AppHolder>().screenOpenViaNotification = "website page";
              
              final Uri websitePageUri = Uri.parse(targetLinkUrl);
              if (await canLaunchUrl(websitePageUri)) {
                await launchUrl(websitePageUri, mode: LaunchMode.externalApplication);
              } else {
                customSnackBar("Something went wrong !");
              }
            });
          }
        }
    },);
  }

  //~ show notification msg
  static void showMsg(RemoteNotification notification, [RemoteMessage? message] ) {
    String payload = (message != null && message.data.containsKey('link')) ? message.data['link'] : '';
    
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      '${notification.title}',
      '${notification.body}',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'high_channel',
          'High Importance Notifications',
          importance: Importance.max,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: DarwinNotificationDetails()
      ),
      payload: payload,
    );
   
    log("notificationResponse-----$payload");
    log('notification.title==========>>>>>${notification.title}');
    log('notification.body==========>>>>>${notification.body}');
  }

  ///background notification handler..
  static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    log('Handling a background notification ->${message.notification}');
    log('Handling a background notification data ->${message.data}');
    RemoteNotification? notification = message.notification;
    log('notification==========>>>>>$notification');

    // if (message != null && message.data.containsKey('screen')) {
    //   String targetScreen = message.data['screen'];
    //   print("listen screen->$targetScreen");
    //   Get.to(const KycScreen());
    // }
  }

  //~ Handle notification when the app is in the background (but not terminated)
  static void onMsgOpen() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async{
      log('A new onMessageOpenedApp event was published!');
      log('notification on open->${message.notification}');
      log('data on notification open->${message.data}');

      if (message.data.containsKey('link')) { 
        String targetLinkUrl = message.data['link'];
        log("listen link->$targetLinkUrl");
        
        final Uri websitePageUri = Uri.parse(targetLinkUrl);
        if (await canLaunchUrl(websitePageUri)) {
          await launchUrl(websitePageUri, mode: LaunchMode.externalApplication);
        } else {
          customSnackBar("Something went wrong !");
        }        
      }
    });
  }
}
