import 'package:flutter/material.dart';
import 'package:marathon/data/tools/decoration/res_colors.dart';

import '../constants/app_assets.dart';

const kSemiBoldWhiteTextStyle = TextStyle(
  color: ColorRes.white,
  fontFamily: AppFonts.fnproximanovaMedium,
  fontSize: 23,
);

const kSemiBoldTextStyle = TextStyle(
  color: ColorRes.mainTextColor,
  fontFamily: AppFonts.fnproximanovaMedium,
  fontSize: 20,
);

const kSemiBoldThemeTextStyle = TextStyle(
  color: ColorRes.mainTextColor,
  fontFamily: AppFonts.fnproximanovaMedium,
  fontSize: 18,
);
const kMediumWhiteTextStyle = TextStyle(
  color: ColorRes.white,
  fontFamily: AppFonts.fnproximanovaMedium,
  fontSize: 20,
);

const kMediumTextStyle = TextStyle(
  color: ColorRes.mainTextColor,
  fontFamily: AppFonts.fnproximanovaMedium,
  fontSize: 20,
);

const kMediumThemeTextStyle = TextStyle(
  color: ColorRes.mainTextColor,
  fontFamily: AppFonts.fnproximanovaMedium,
  fontSize: 20,
);

const kBoldWhiteTextStyle = TextStyle(
  color: ColorRes.white,
  fontFamily: AppFonts.fnproximanovaBold,
  fontSize: 23,
);

const kBoldThemeTextStyle = TextStyle(
  color: ColorRes.mainTextColor,
  fontFamily: AppFonts.fnproximanovaBold,
  fontSize: 23,
);

const kBlackWhiteTextStyle = TextStyle(
  color: ColorRes.white,
  fontFamily: AppFonts.fnproximanovaBlack,
  fontSize: 22,
);

const kRegularWhiteTextStyle = TextStyle(
  color: ColorRes.white,
  fontFamily: AppFonts.fnproximanovaRegular,
  fontSize: 16,
);

const kRegularTextStyle = TextStyle(
  color: ColorRes.black,
  fontFamily: AppFonts.fnproximanovaRegular,
  fontSize: 16,
);

const kRegularEmpressTextStyle = TextStyle(
  color: ColorRes.mainTextColor,
  fontFamily: AppFonts.fnproximanovaRegular,
  fontSize: 16,
);
const kRegularThemeTextStyle = TextStyle(
  color: ColorRes.mainTextColor,
  fontFamily: AppFonts.fnproximanovaRegular,
  fontSize: 16,
);

const kLightWhiteTextStyle = TextStyle(
  color: ColorRes.white,
  fontFamily: AppFonts.fnproximanovaLight,
  fontSize: 14,
);
const kLightTextStyle = TextStyle(
  color: ColorRes.mainTextColor,
  fontFamily: AppFonts.fnproximanovaLight,
  fontSize: 16,
);

const kThinWhiteTextStyle = TextStyle(
  color: ColorRes.white,
  fontFamily: AppFonts.fnproximanovaThin,
  fontSize: 14,
);

const kBlackButtonTextStyle = TextStyle(
  color: ColorRes.black,
  fontFamily: AppFonts.fnproximanovaRegular,
  fontSize: 14,
);

const kThemeButtonTextStyle = TextStyle(
  color: ColorRes.mainTextColor,
  fontFamily: AppFonts.fnproximanovaRegular,
  fontSize: 18,
);

ButtonStyle kButtonWhiteStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all(ColorRes.white),
  shape: MaterialStateProperty.all(
    const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
  ),
  overlayColor: MaterialStateProperty.all(Colors.transparent),
);

ButtonStyle kButtonThemeStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all(ColorRes.black),
  shape: MaterialStateProperty.all(
    const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
  ),
  overlayColor: MaterialStateProperty.all(ColorRes.black),
);
