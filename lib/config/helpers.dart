import 'dart:developer';
import 'package:url_launcher/url_launcher.dart';

void launchPhone(String phoneNumber) async {
  final Uri url = Uri.parse('tel:$phoneNumber');
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    log("Could not launch $url");
  }
}

void launchEmail(String email) async {
  final Uri url = Uri(scheme: 'mailto', path: email);
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    log("Could not launch $url");
  }
}



// Future<void> androidRootChecker() async {
//   try {
//     final isRooted = (await RootCheckerPlus.isRootChecker()) ?? false;
//     if (isRooted) {
//       debugPrint('⚠️ Rooted Android device detected!');
      
//       FirebaseAnalytics.instance.logEvent(
//         name: "rooted_device_blocked",
//         parameters: {"platform": Platform.operatingSystem},
//       );
//       await Future.delayed(Duration(milliseconds: 300)); 
//       SystemNavigator.pop() ;
//     }
//   } catch (e) {
//     debugPrint('Error checking root status: $e');
//   }
// }

// Future<void> developerMode() async {
//   try {
//     final isDeveloperModeEnabled = (await RootCheckerPlus.isDeveloperMode()) ?? false;
//     if (isDeveloperModeEnabled) {
//       debugPrint('⚠️ Developer mode / ADB detected!');

//       await Future.delayed(Duration(milliseconds: 300)); 
//       SystemNavigator.pop() ;
//     }
//   } catch (e) {
//     debugPrint('Error checking developer mode status: $e');
//   }
// }

// Future<void> iosJailbreak() async {
//   try {
//     final isJailbroken = (await RootCheckerPlus.isJailbreak()) ?? false;
//     if (isJailbroken) {
//       debugPrint('⚠️ Jailbroken iOS device detected!');

//       FirebaseAnalytics.instance.logEvent(
//         name: "rooted_device_blocked",
//         parameters: {"platform": Platform.operatingSystem},
//       );
//       await Future.delayed(Duration(milliseconds: 300)); 
//       SystemNavigator.pop() ;
//     }
//   } on Exception catch (e) {
//     debugPrint('Error checking jailbreak status: $e');
//   }
// }
