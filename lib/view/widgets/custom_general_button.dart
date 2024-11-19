import 'package:flutter/cupertino.dart';

import '../../data/tools/decoration/dimens.dart';
import '../../data/tools/decoration/res_colors.dart';
import '../../data/tools/decoration/style_res.dart';

class CustomGeneralButton extends StatelessWidget {
  final Function onTab;
  final String title;
  final double? width;
  final double? height;
  final double fontSize;
  final Color titleColor;
  final Color buttonColor;
  final FontWeight fontWeight;
  final double? verticalPadding;
  final double? horizontalPadding;
  const CustomGeneralButton({
    super.key,
    required this.onTab,
    required this.title,
    this.width,
    this.titleColor = ColorRes.white,
    this.buttonColor = ColorRes.mainButtonColor,
    this.fontSize = 16,
    this.height,
    this.fontWeight = FontWeight.w600,
    this.verticalPadding,
    this.horizontalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTab();
      },
      child: IntrinsicWidth(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal:
                  horizontalPadding ?? MediaQuery.of(context).size.width * 0.05,
              vertical:
                  verticalPadding ?? MediaQuery.of(context).size.height * 0.01),
          height: height,
          width: width,
          decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(Dimens.buttonRadius)),
          child: Center(
            child: Text(
              title,
              style: kRegularWhiteTextStyle.copyWith(
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  color: titleColor),
            ),
          ),
        ),
      ),
    );
  }
}
