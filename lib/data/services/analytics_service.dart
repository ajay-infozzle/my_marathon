import 'dart:io';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:marathon/data/storage/app/app_holder.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AnalyticsService {
  AnalyticsService._();

  static final _instance = AnalyticsService._();

  static AnalyticsService get instance => _instance;

  final _analytics = FirebaseAnalytics.instance;

  void onAppOpen() {
    try {
      _analytics.logAppOpen();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  //~
  void onLogin({
    required String loginType,
    required int userId,
  }) async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      _analytics.logLogin(loginMethod: loginType);
      _analytics.setUserId(id: '$userId');
      _analytics.setUserProperty(name: 'UserId', value: '$userId');
      _analytics.logEvent(
        name: 'user_logged_in',
        parameters: {
          'UserId': userId,
          'app_version': packageInfo.version,
          'platform': Platform.isAndroid ? 'Android' : 'iOS',
          'timestamp': DateTime.now().toIso8601String(),
        },
      ).onError((error, stack) {
        if (kDebugMode) {
          print('TAG:: onLogin: onError >>>>>>>>');
        }
      }).catchError((error) {
        if (kDebugMode) {
          print('TAG:: onLogin: catchError >>>>>>>>');
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  //~
  void onProjectName({required String projectName}) async {
    try {
      final userId = Get.find<AppHolder>().custId;
      _analytics.setUserId(id: '$userId');
      _analytics.setUserProperty(name: 'UserId', value: '$userId');
      _analytics.setUserProperty(name: 'ProjectName', value: projectName);
      _analytics.logEvent(
        name: 'user_logged_in',
        // name: 'on_appartment_detail',
        parameters: {
          'UserId': userId,
          'ProjectName': projectName,
        },
      ).onError((error, stack) {
        if (kDebugMode) {
          print('TAG:: onLogin: onError >>>>>>>> ');
        }
      }).catchError((error) {
        if (kDebugMode) {
          print('TAG:: onLogin: catchError >>>>>>>> ');
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void onRegister({
    required String registerType,
    required String registeredId
  }) async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      _analytics.logSignUp(signUpMethod: registerType);
      _analytics.setUserId(id: registeredId);
      _analytics.setUserProperty(name: 'registeredId', value: registeredId);
      
      _analytics.logEvent(
        name: 'register',
        parameters: {
          'registeredId': registeredId,
          'registerType': registerType,
          'app_version': packageInfo.version,
          'platform': Platform.isAndroid ? 'Android' : 'iOS',
          'timestamp': DateTime.now().toIso8601String(),
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  //~
  void onHomeScreenView() async {
    try {
      _analytics.logScreenView(
        screenName: 'HomeScreen',
        screenClass: 'MainPage',
      );
      final userId = Get.find<AppHolder>().custId;
      _analytics.setUserId(id: '$userId');
      _analytics.setUserProperty(name: 'UserId', value: '$userId');
      _analytics.logEvent(
        // name: 'screen_view',
        name: 'home_screen_view',
        parameters: {
          'screen_name': 'HomeScreen',
          'UserId': userId,
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void onContactFormSubmission() async {
    try {
      final userId = Get.find<AppHolder>().custId;
      _analytics.setUserId(id: '$userId');
      _analytics.setUserProperty(name: 'UserId', value: '$userId');
      _analytics.logEvent(
        name: 'support_screen',
        parameters: {
          'UserId': userId,
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void onDocumentUpload() async {
    try {
      final userId = Get.find<AppHolder>().custId;
      _analytics.setUserId(id: '$userId');
      _analytics.setUserProperty(name: 'UserId', value: '$userId');
      _analytics.logEvent(
        name: 'document_screen',
        parameters: {
          'UserId': userId,
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void onReferred() async {
    try {
      final userId = Get.find<AppHolder>().custId;
      _analytics.setUserId(id: '$userId');
      _analytics.setUserProperty(name: 'UserId', value: '$userId');
      _analytics.logEvent(
        name: 'referred_screen',
        parameters: {
          'UserId': userId,
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void onPayment() async {
    try {
      final userId = Get.find<AppHolder>().custId;
      _analytics.setUserId(id: '$userId');
      _analytics.setUserProperty(name: 'UserId', value: '$userId');
      _analytics.logEvent(
        name: 'payment_screen',
        parameters: {
          'UserId': userId,
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
