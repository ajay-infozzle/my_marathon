import 'package:flutter/material.dart';

import '../../data/tools/decoration/dimens.dart';
import '../../data/tools/decoration/res_colors.dart';
import '../../data/tools/decoration/style_res.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final Function(String v) onChanged;
  final Function tapToHide;
  final bool needHide;
  final bool visible;
  final double height;
  final double? borderRadius;
  const CustomTextField(
      {super.key,
      required this.textEditingController,
      required this.onChanged,
      this.needHide = false,
      this.visible = false,
      required this.tapToHide,  this.height = 50,  this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: ColorRes.greyD3,
              spreadRadius: 1,
              blurRadius: 0,
              offset: Offset(0.5, 1.5), // changes position of shadow
            ),
          ],
          color: ColorRes.textFieldColor,
          borderRadius: BorderRadius.circular(borderRadius!= null?borderRadius??0:Dimens.buttonRadius)),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(Dimens.buttonRadius),
          child: Padding(
            padding: const EdgeInsets.only(right: 15, left: 15),
            child: Row(
              children: [
                Flexible(
                  child: TextFormField(
                    controller: textEditingController,
                    obscureText: visible,
                    onChanged: onChanged,
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
                Visibility(
                  visible: needHide,
                  child: InkWell(
                    onTap: () {
                      tapToHide();
                    },
                    child: Row(
                      children: [
                        visible
                            ? const Icon(Icons.remove_red_eye)
                            : const Icon(Icons.visibility_off)
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
