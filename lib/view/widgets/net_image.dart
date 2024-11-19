import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/tools/decoration/dimens.dart';
import '../../data/tools/decoration/res_colors.dart';


class NetImageView extends StatelessWidget {
  final bool isUserProfileImg;
  final String imageUrl;
  final double height;
  final double width;
  final double? borderRadius;
  final String name;

  const NetImageView(
      {Key? key,
        required this.imageUrl,
        this.height = 80,
        this.isUserProfileImg = false,
        this.width = 80,
        this.borderRadius,
        required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        height: height,
        width: width,
        imageUrl: imageUrl,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
              image:
              DecorationImage(image: imageProvider, fit: BoxFit.cover),
              border: Border.all(color: ColorRes.greyColor, width: 0.3),
              borderRadius: BorderRadius.circular(
                  borderRadius ?? Dimens.borderRadius)),
        ),
        placeholder: (context, url) => const CupertinoActivityIndicator(),
        errorWidget: (context, url, error) => Container(
            height: height,
            width: width,
            decoration: const BoxDecoration(
                color: ColorRes.grey,
                shape: BoxShape.circle,),
                // image: DecorationImage(
                //     image: AssetImage(AppAssets.images.accountPng),
                //     fit: BoxFit.cover),

           ));
  }
}
