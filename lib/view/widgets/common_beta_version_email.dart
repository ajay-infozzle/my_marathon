import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/tools/decoration/res_colors.dart';
import '../../data/tools/decoration/style_res.dart';

Widget commonBetaVersionEmail() {
  return Text.rich(
    textAlign: TextAlign.center,
    TextSpan(
    children:[
      TextSpan(
        text:'This is a beta version. If you encounter any issues or bugs please email us at',
        style:kSemiBoldTextStyle.copyWith(fontSize: 11),
      ),
      TextSpan(
        text: 'customercare@marathonrealty.com',
        recognizer: TapGestureRecognizer()
          ..onTap = () async {
            const email = 'mailto:customercare@marathonrealty.com';
            if (await canLaunchUrl(Uri.parse(email))) {
              await launchUrl(Uri.parse(email));
            } else {
              log('Could not launch $email');
            }
          },
        style: kSemiBoldTextStyle.copyWith(
            fontSize: 12, color: ColorRes.mainButtonColor),
      ),
    ]),
  );
}