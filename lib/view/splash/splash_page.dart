import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:marathon/data/server/api/api_const.dart';
import 'package:marathon/data/storage/app/app_holder.dart';
import 'package:marathon/data/tools/constants/app_assets.dart';
import 'package:marathon/data/tools/decoration/res_colors.dart';
import 'package:marathon/data/tools/toast/custom_snackbar.dart';
import 'package:marathon/view/main_page/main_page.dart';
import 'package:marathon/view/welcome_page.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  AnimationController? _controller;
  AnimationController? _controller2;
  Animation<double>? _animation;
  Animation<double>? _animation2;

  late String currentVersion;
  late String latestVersion;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _checkVersionAndNavigate();
  }

  void _initializeAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = Tween<double>(begin: 0.3, end: -0.0).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.fastOutSlowIn,
      ),
    );
    _controller?.forward();
    _controller2 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation2 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller2!,
        curve: Curves.easeInOut,
      ),
    );
    _controller2?.forward();

    // _navigateToNextPage(); //Todo : have to remove
  }

  Future<void> _checkVersionAndNavigate() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    currentVersion = packageInfo.version;

    //~ Call API to get the latest version
    latestVersion = await _getLatestVersionFromApi();

    //~ Compare versions and show dialog if needed
    if (currentVersion != latestVersion) {
      if (_isMajorUpdate(currentVersion, latestVersion)) {
        _showForceUpdateDialog();
      } else {
        _showOptionalUpdateDialog();
      }
    } else {
      _navigateToNextPage();
    }
  }

  Future<String> _getLatestVersionFromApi() async {
    try {
      Dio dio = Dio();
      var response = await dio.post(Api.getAppVersion);
      if (kDebugMode) {
        print('Api.getAppVersion=======> ${Api.getAppVersion}');
        print('current app version =======>>>: $currentVersion');
        print('version response from database=======>>>: ${response.data}');
      }
      var data = response.data["data"];
            
      return data['latest_version'];
      // return "1.0.1";
    } catch (e) {
      if (kDebugMode) {
        print('Failed to get latest version: $e');
      }

      return "";
    }
  }

  bool _isMajorUpdate(String currentVersion, String latestVersion) {
    List<String> current = currentVersion.split('.');
    List<String> latest = latestVersion.split('.');
    return current[0] != latest[0];
  }

  void _showForceUpdateDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          title: const Text('Update Required'),
          content: Text('A new version($latestVersion) of the app is available. Please update to continue.'),
          backgroundColor: ColorRes.listItemColors,
          actions: [
            TextButton(
              onPressed:_launchStore,
              child: const Text('Update Now'),
            ),
          ],
        ),
      ),
    );
  }

  void _showOptionalUpdateDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          title: const Text('Update Available'),
          content: Text('A new version($latestVersion) of the app is available. Would you like to update?'),
          backgroundColor: ColorRes.listItemColors,
          actions: [
            TextButton(
              onPressed: () {
                Get.offAll(() => Get.find<AppHolder>().custId != 0
                    ? const MainPage()
                    : const WelcomePage()
                );
              },
              child: const Text('Skip'),
            ),
            TextButton(
              onPressed: _launchStore,
              child: const Text('Update Now'),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToNextPage() {
    Future.delayed(const Duration(milliseconds: 2000)).then((_) {
      if(!Get.find<AppHolder>().isOpenFromNotification){
        Get.offAll(
        () => Get.find<AppHolder>().custId != 0
            ? const MainPage(isSignIn: true,)
            : const WelcomePage());
      }
    });
  }

  void _launchStore() async {
    const String playStoreUrl = 'https://play.google.com/store/apps/details?id=com.crm.marathonportal';  
    const String appStoreUrl = 'https://apps.apple.com/in/app/my-marathon/id6502095972';   
    if (Platform.isAndroid) {
      final Uri playStoreUri = Uri.parse(playStoreUrl);
      if (await canLaunchUrl(playStoreUri)) {
        await launchUrl(playStoreUri, mode: LaunchMode.externalApplication);
      } else {
        customSnackBar("Something went wrong !");
      }
    } else if (Platform.isIOS) {
      final Uri appStoreUri = Uri.parse(appStoreUrl);
      if (await canLaunchUrl(appStoreUri)) {
        await launchUrl(appStoreUri, mode: LaunchMode.externalApplication);
      } else {
        customSnackBar("Something went wrong !");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _animation!,
                builder: (BuildContext context, Widget? child) {
                  return Transform.translate(
                    offset: Offset(
                        MediaQuery.of(context).size.width * _animation!.value,
                        0.0),
                    child: SvgPicture.asset(
                      AppAssets.icon.splashIcon,
                      alignment: Alignment.bottomCenter,
                      height: 35,
                    ),
                  );
                },
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.025),
              AnimatedBuilder(
                animation: _animation2!,
                builder: (BuildContext context, Widget? child) {
                  return Opacity(
                    opacity: _animation2!.value,
                    child: Image(
                      image: AssetImage(AppAssets.images.marathonTextLogo),
                      alignment: Alignment.bottomCenter,
                      height: 35,
                      width: MediaQuery.of(context).size.width * 0.55,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
