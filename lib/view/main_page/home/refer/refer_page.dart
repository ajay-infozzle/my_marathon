import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marathon/controllers/home/refer_controller/refer_controller.dart';
import 'package:marathon/data/tools/decoration/dimens.dart';
import 'package:marathon/data/tools/extensions/num_ext.dart';
import 'package:marathon/view/main_page/home/refer/invite/invite_page.dart';
import 'package:marathon/view/widgets/custom_general_button.dart';
import '../../../../data/tools/constants/app_assets.dart';
import '../../../../data/tools/decoration/res_colors.dart';
import '../../../../data/tools/decoration/style_res.dart';

class ReferPage extends StatelessWidget {
  const ReferPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return GetBuilder<ReferController>(
        init: ReferController(Get.find(),Get.find()),
        builder: (controller) {
          return Scaffold(
            // backgroundColor: ColorRes.white,
            body: ListView(
              shrinkWrap: true,
              children: [
                Column(
                  children: [
                    20.ph,
                    Image.asset(AppAssets.images.referImage),
                    20.ph,
                    Text(
                      textAlign: TextAlign.center,
                      "Get your friends \n to be your neighbours",
                      style: kRegularThemeTextStyle.copyWith(
                          fontSize: 20,
                          height: 1.2,
                          fontWeight: FontWeight.w600,
                          color: ColorRes.unPaidColor),
                    ),
                    10.ph,
                  Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                        children:[
                        TextSpan(
                        text:"Refer a friend to any of Marathon's \n properties and get rewards worth up to ",
                        style: kRegularThemeTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: '1%\n',
                        style: kRegularThemeTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text:"of the new purchase. Your friend will get a \n  discount on his new apartment too -\n it's a win-win!",
                        style: kRegularThemeTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          ),
                        ),
                      ]
                    ),
                  ),
                    20.ph,
                    CustomGeneralButton(
                      onTab: () {
                        Get.to(() => const InvitePage());
                      },
                      title: "Refer Now",
                    ),
                    20.ph,
                  ],
                ),
                20.ph,
                Padding(
                  padding:EdgeInsets.symmetric(horizontal: w*0.04),
                  child: const Divider(color:Colors.grey),
                ),
                Padding(
                  padding:EdgeInsets.symmetric(horizontal: Dimens.padding),
                  child:GestureDetector(
                    onTap: () {
                      controller.openTab(1);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          textAlign: TextAlign.center,
                          "Terms & Conditions",
                          style: kRegularThemeTextStyle.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        controller.openIndex.contains(1)
                            ? const RotatedBox(
                          quarterTurns: 1,
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: ColorRes.black,
                          ),
                        )
                            : const Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:EdgeInsets.symmetric(horizontal: w*0.04),
                  child: const Divider(color: Colors.grey),
                ),
                TermsAndConditionData(
                  index: 1,
                  openedIndex: controller.openIndex,
                ),
                20.ph,
                // commonBetaVersionEmail(),
                // 20.ph,
              ],
            ),
          );
        });
  }
}

class TermsAndConditionData extends StatelessWidget {
  final List openedIndex;
  final int index;
  const TermsAndConditionData({
    super.key,
    required this.openedIndex,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    bool needOpen(List list, int index) {
      return list.contains(index);
    }

    return Visibility(
      visible: needOpen(openedIndex, index),
      child: Column(
        children:[
          Padding(
            padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width*0.04),
            child: Text(
              "Referee: Any customer who books a new flat with us through referral/loyalty Referrer: Anyone who refers a new prospect to us Vendor: Any registered contractor, Sub-contractor, vendor, supplier or any current employee of a contractor, sub-contractor, supplier or vendor associated with Marathon Group A successful referral means that the referred customer has booked an apartment with Marathon Group and completed the registration of his new property. The following clauses also need to be applicable for the referral to be valid.Referee Checks If the referee has visited the property with a broker in the past 90 days, he/she will not be eligible for the scheme Referral scheme is not applicable in case referee is a blood relative – (sibling, spouse, parent or child i.e. any one is referrer and another is referee and vice versa). Loyalty scheme would be applicable for such cases. The referee should not be an existing Marathon customer or engaged in a purchase discussion with a Marathon executive in the last 90 days. The referee must either mention the unique referral code or the name, address and contact number of the referrer on both the site visit form and the booking form In case the referee has stayed/ is staying/working in any Marathon property (residential & commercial), referral scheme is not applicable, loyalty is applicable in that case If the referee is a current employee of any marathon vendor, referral program will not be applicable. Loyalty will be applicable in that case. Referrer Checks In case of referrer staying/working in a rented Marathon property (residential & commercial) or a past resident of a Marathon property, address proof (residential/office whichever applicable) is to be provided by referrer prior to payout. In case the referrer is a Marathon customer, he also needs to have completed his registration. The referral rewards payout for both referee & referee will be processed within 45 working days after the referred customer & the referrer (if customer himself) registers his/her agreement for sale, whichever is latest. In case of cancellation of the residence by referred customer, Marathon Group will not be liable for any distribution of any rewards to bother referrer & referee. In case of any conflict by either parties, the decision of Marathon Group will be final Marathon referral & loyalty scheme is not applicable for any Marathon employees Marathon Group reserves the rights to include, modify and/or remove projects in the referral program and the referral program itself without any prior notice",
              style: kRegularThemeTextStyle.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: ColorRes.black
              ),
            ),
          ),
        ],
      ),
    );
  }
}
