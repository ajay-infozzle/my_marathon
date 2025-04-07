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