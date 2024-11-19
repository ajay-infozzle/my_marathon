import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../data/tools/decoration/res_colors.dart';

class SvgView extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final Color? color;

  final BoxFit fit;
  const SvgView(
      {Key? key,
      this.color,
      required this.height,
      required this.width,
      this.fit = BoxFit.fill,
      required this.imageUrl,

      })
      : super(key: key);

  ColorFilter get colorFilter => color == null
      ? const ColorFilter.mode(Colors.transparent, BlendMode.color)
      : ColorFilter.mode(color ?? ColorRes.mainButtonColor, BlendMode.srcIn);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return SvgPicture.asset(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
      colorFilter: colorFilter,
      // color: color,
    );
  }
}
