import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../data/tools/decoration/res_colors.dart';
import '../../data/tools/decoration/style_res.dart';
import 'custom_general_button.dart';

class StepperDetails extends StatelessWidget {
  final String details;
  final String amount;
  final String? tAmount;
  final String buttonTitle;
  final String title;
  final Function onTab;
  final bool isStep;
  final bool needButton;
  final bool isPaymentDue;
  const StepperDetails({
    super.key,
    required this.details,
    required this.amount,
    required this.title,
    required this.onTab,
    this.tAmount,
    this.isStep = false,
    this.buttonTitle = "View Receipt",
    this.needButton = true,
    this.isPaymentDue = false,
  });

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return SizedBox(
      width: Get.width - 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            textAlign: TextAlign.start,
            title,
            style: kRegularThemeTextStyle.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: ColorRes.black),
          ),
          SizedBox(height: h * 0.005),
          Text(
            details,
            maxLines: 200,
            overflow: TextOverflow.ellipsis,
            style: kRegularThemeTextStyle.copyWith(
                fontSize: 14, color: ColorRes.black),
          ),
          SizedBox(height: h * 0.005),
          Visibility(
            visible: amount.isNotEmpty,
            child: Text(
              textAlign: TextAlign.center,
              amount,
              style: kRegularThemeTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: ColorRes.mainTextColor),
            ),
          ),
          if (isPaymentDue)
            Visibility(
              visible: tAmount!.isNotEmpty,
              child: Text(
                textAlign: TextAlign.center,
                tAmount!,
                style: kRegularThemeTextStyle.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: ColorRes.mainTextColor),
              ),
            ),
          SizedBox(height: h * 0.005),
          Visibility(
            visible: needButton,
            child: CustomGeneralButton(
              onTab: () {
                onTab();
              },
              title: buttonTitle,
              // verticalPadding: 6,
              // horizontalPadding: 20,
              fontSize: 13,
            ),
          )
        ],
      ),
    );
  }
}
