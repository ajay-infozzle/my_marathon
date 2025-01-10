import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/tools/decoration/dimens.dart';
import '../../../../data/tools/decoration/res_colors.dart';
import '../../../../data/tools/decoration/style_res.dart';

class DropdownTileWidget extends StatelessWidget {
  final Function onTap;
  final String title;
  final bool isTitle;
  final String detail;
  final Widget child;
  final bool showBottomLine;

  const DropdownTileWidget({
    super.key,
    required this.onTap,
    required this.title,
    required this.child,
    this.detail = "",
    this.isTitle = false,
    this.showBottomLine = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.symmetric(
          horizontal: Dimens.padding,
        ),
        height: 50,
        width: Get.width,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
             color: showBottomLine ? ColorRes.greyColor : Colors.transparent, 
            width: showBottomLine ? 2.0 : 0, 
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: isTitle
                      ? kRegularTextStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          color: ColorRes.mainButtonColor)
                      : kRegularTextStyle.copyWith(fontWeight: FontWeight.w600),
                ),
                detail.isNotEmpty
                    ? SizedBox(
                        width: Get.width - 100,
                        child: Text(
                          detail,
                          overflow: TextOverflow.ellipsis,
                          style: kRegularTextStyle.copyWith(
                              fontWeight: FontWeight.w400, fontSize: 12),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
            child
          ],
        ),
      ),
    );
  }
}
