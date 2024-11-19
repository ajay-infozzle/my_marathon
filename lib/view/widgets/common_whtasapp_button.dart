import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/server/api/api_const.dart';
import '../../data/tools/constants/app_assets.dart';

Widget commonFloatingActionButton() {
  return FloatingActionButton(
    backgroundColor: Colors.transparent,
    elevation: 0,
    onPressed: () async {
      launchUrl(Api.whatsApp);
    },
    child: Image.asset(AppAssets.images.whatsAppIcon),
  );
}
