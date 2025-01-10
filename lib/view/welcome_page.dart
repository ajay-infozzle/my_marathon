import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marathon/data/tools/constants/app_assets.dart';
import 'package:marathon/data/tools/decoration/res_colors.dart';
import 'package:marathon/data/tools/decoration/style_res.dart';
import 'package:marathon/data/tools/extensions/num_ext.dart';
import 'package:marathon/view/widgets/custom_general_button.dart';
import 'auth_pages/login_page.dart';
import 'auth_pages/register_page/register_page.dart';


class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    // final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorRes.white,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Stack(
            children: [
              Image(
                width: Get.width,
                height: h * 0.58,
                image: AssetImage(AppAssets.images.mobileHome),
                fit: BoxFit.cover,
              ),
              // Column(
              //   children: [
              //     // const Spacer(
              //     //   flex: 4,
              //     // ),
              //     SizedBox(height: h * 0.47),
              //     Image(
              //       width: Get.width,
              //       image: AssetImage(AppAssets.images.loginWhite),
              //       fit: BoxFit.cover,
              //     ),
              //     SizedBox(height: h * 0.085),
              //   ],
              // ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Get.width.pw,
                  SizedBox(height: h * 0.64),
                  Text(
                    textAlign: TextAlign.center,
                    'WELCOME TO THE MARATHON \n CUSTOMER PORTAL',
                    style: kRegularThemeTextStyle.copyWith(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: h * 0.04),
                  CustomGeneralButton(
                    onTab: () {
                      Get.bottomSheet(
                          barrierColor: Colors.transparent,
                          isScrollControlled: true,
                          const LoginScreen());
                    },
                    title: "Sign In",
                  ),
                  SizedBox(height: h * 0.01),
                  CustomGeneralButton(
                    onTab: () {
                      Get.bottomSheet(
                          barrierColor: Colors.transparent,
                          isScrollControlled: true,
                          const RegisterScreen());
                    },
                    title: "Register",
                  ),
                  SizedBox(height: h * 0.04),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                  //   child:
                  //   Text.rich(
                  //     textAlign: TextAlign.center,
                  //     TextSpan(children: [
                  //       TextSpan(
                  //         text:
                  //             'This is a beta version. If you encounter any issues or bugs please email us at',
                  //         style: kSemiBoldTextStyle.copyWith(fontSize: 11),
                  //       ),
                  //       TextSpan(
                  //         text: ' customercare@marathonrealty.com',
                  //         recognizer: TapGestureRecognizer()
                  //           ..onTap = () async {
                  //             final email =
                  //                 'mailto:customercare@marathonrealty.com';
                  //             if (await canLaunch(email)) {
                  //               await launch(email);
                  //             } else {
                  //               print('Could not launch $email');
                  //             }
                  //           },
                  //         style: kSemiBoldTextStyle.copyWith(
                  //             fontSize: 12, color: ColorRes.mainButtonColor),
                  //       ),
                  //     ]),
                  //   ),
                  // ),

                  // Padding(
                  //   padding:  EdgeInsets.symmetric(horizontal: w*0.05),
                  //   child: commonBetaVersionEmail(),
                  // ),
                  const Spacer()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
