import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:marathon/data/tools/extensions/num_ext.dart';
import 'package:marathon/view/main_page/home/drawer/drawer.dart';
import 'package:marathon/view/widgets/custom_general_button.dart';
import 'package:marathon/view/widgets/custom_textfield.dart';
import 'package:steps_indicator/steps_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../controllers/home/payments/milestone/make_payment_controller/make_payment_controller.dart';
import '../../../../../controllers/mainController/main_controller.dart';
import '../../../../../data/server/api/api_const.dart';
import '../../../../../data/tools/constants/app_assets.dart';
import '../../../../../data/tools/decoration/res_colors.dart';
import '../../../../../data/tools/decoration/style_res.dart';
import '../../../../widgets/common_beta_version_email.dart';
import '../../../../widgets/common_whtasapp_button.dart';

class MakePaymentPage extends StatefulWidget {
  final List receiptId;

  const MakePaymentPage({super.key, required this.receiptId});

  @override
  State<MakePaymentPage> createState() => _MakePaymentPageState();
}

class _MakePaymentPageState extends State<MakePaymentPage> {
  var key = GlobalKey();
  var key1 = GlobalKey();
  var key2 = GlobalKey();

  Size? redBox;
  Size? redBox1;
  Size? redBox2;

  MakePaymentController makePaymentController = Get.find();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      redBox = (key.currentContext?.findRenderObject() as RenderBox).size;
      redBox2 = (key2.currentContext?.findRenderObject() as RenderBox).size;
      redBox1 = (key1.currentContext?.findRenderObject() as RenderBox).size;
      setState(() {});


      print('redBox==========INIT=>>>>${redBox?.height}');
      print('redBox=======11111===INIT=>>>>${redBox1?.height}');
      print('redBox======22222====INIT=>>>>${redBox2?.height}');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return GetBuilder<MakePaymentController>(
        init: MakePaymentController(Get.find(), Get.find()),
        builder: (controller) {
          // log('Loading1==========>>>>>${controller.isLoading1}');
          return Scaffold(
            key: controller.mainController.scaffoldKey,
            floatingActionButton:commonFloatingActionButton(),
            endDrawer: const Drawer(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0),
                bottomLeft: Radius.circular(0),
              )),
              child: HomeDrawer(),
            ),
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: ColorRes.mainButtonColor,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: ColorRes.white,
                ),
                onPressed: () {
                  Get.back();
                },
              ),
              title:SvgPicture.asset(AppAssets.icon.marathonLogo,color: Colors.white,width: 171,height: 22),
              actions: [
                IconButton(
                    onPressed: () {
                      controller.mainController.scaffoldKey.currentState
                          ?.openEndDrawer();
                    },
                    icon: const Icon(
                      Icons.account_circle_outlined,
                      color: ColorRes.white,
                    ))
              ],
            ),
            body: controller.isLoading ==
                    true /*|| controller.isLoading1 == true*/
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        50.ph,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: w * 0.08),
                          child: Text(
                            textAlign: TextAlign.start,
                            "Make payments in 3 simple steps",
                            style: kRegularThemeTextStyle.copyWith(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: ColorRes.mainTextColor),
                          ),
                        ),
                        20.ph,

                        ///STEP 1
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    height: redBox?.height ?? 0,
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                  const Positioned(
                                    right: -10,
                                    child: Center(
                                      child: CircleAvatar(
                                        radius: 10,
                                        backgroundColor: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 35,),
                              Container(
                                width: Get.width - 100,
                                // color: ColorRes.grey,
                                key: key,
                                padding: EdgeInsets.only(bottom: h * 0.06),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      textAlign: TextAlign.start,
                                      "Step 1: Check the details",
                                      style: kRegularThemeTextStyle.copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: ColorRes.black),
                                    ),
                                    Text(
                                      "Your current outstanding amount is Rs. ${Get.arguments['due_amount'].toString()}",
                                      maxLines: 200,
                                      overflow: TextOverflow.ellipsis,
                                      style: kRegularThemeTextStyle.copyWith(
                                          fontSize: 14, color: ColorRes.black),
                                    ),
                                    SizedBox(height: h * 0.005),
                                    CustomGeneralButton(
                                      onTab: () {
                                        Get.find<MainController>().changePage(1);
                                        Get.back();
                                        // controller.getReceipt(
                                        //     widget.receiptId.toString());
                                      },
                                      title: "View Details",
                                      // verticalPadding: 6,
                                      // horizontalPadding: 20,
                                     // fontSize: 13,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        ///STEP 2
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    height: redBox1?.height ?? 0,
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                  const Positioned(
                                    right: -10,
                                    child: Center(
                                      child: CircleAvatar(
                                        radius: 10,
                                        backgroundColor:
                                            ColorRes.mainButtonColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 35,),
                              Container(
                                width: Get.width - 100,

                                key: key1,
                                padding: EdgeInsets.only(bottom: h * 0.05),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      textAlign: TextAlign.center,
                                      "Step 2: RTGS transfer",
                                      style: kRegularThemeTextStyle.copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: ColorRes.mainTextColor),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.005,
                                    ),
                                    Text(
                                      "Once you have checked the details, please login to your preferred banks’ netbanking account. You may do so in a new browser tab. Now transfer the amount to the below mentioned account. You may need to add the account as a payee if you have not already done so before. You will get a RTGS reference number if the payment is successful.",
                                      style: kRegularThemeTextStyle.copyWith(
                                          fontSize: 14, color: ColorRes.black),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01,
                                    ),
                                    Container(
                                      height: 100,
                                      child: Text(
                                        "Bank Name: ${controller.paymentResponse?.data?.rera?.bankDetails?.name}"
                                            "Account Number: ${controller.paymentResponse?.data?.rera?.bankDetails?.acNo}"
                                            "Type: ${controller.paymentResponse?.data?.rera?.bankDetails?.accName}"
                                            "Branch: ${controller.paymentResponse?.data?.rera?.bankDetails?.branch}"
                                            "IFSC Code : ${controller.paymentResponse?.data?.rera?.bankDetails?.ifscCode}",
                                        style: kRegularThemeTextStyle.copyWith(
                                            fontSize: 14, color: ColorRes.black),maxLines: 5,overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        ///STEP 3
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    height: redBox2?.height ?? 0,
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                  const Positioned(
                                    right: -10,
                                    child: Center(
                                      child: CircleAvatar(
                                        radius: 10,
                                        backgroundColor: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 35,),
                              Container(
                                width: Get.width - 100,
                                // color: ColorRes.grey,
                                key: key2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      textAlign: TextAlign.start,
                                      "Step 3: Send us your transaction details ",
                                      style: kRegularThemeTextStyle.copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: ColorRes.black),
                                    ),
                                    Text(
                                      "Send us the transaction details below. We will verify the transaction and generate the receipt for the payment. The receipt will be available after 3 working days",
                                      maxLines: 200,
                                      overflow: TextOverflow.ellipsis,
                                      style: kRegularThemeTextStyle.copyWith(
                                          fontSize: 14, color: ColorRes.black),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.005,
                                    ),
                                    SizedBox(
                                      width: Get.width - 100,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            width: Get.width,
                                            child: Text(
                                              'Bank Name*',
                                              style: kRegularWhiteTextStyle
                                                  .copyWith(
                                                      fontSize: 18,
                                                      color: ColorRes.black,
                                                      fontWeight:
                                                          FontWeight.w600),
                                            ),
                                          ),
                                          CustomTextField(
                                              textEditingController:
                                                  controller.bankNameController,
                                              onChanged: (v) {},
                                              tapToHide: () {
                                                // controller.hidePassword();
                                              }),
                                          10.ph,
                                          SizedBox(
                                            width: Get.width,
                                            child: Text(
                                              'Amount*',
                                              style: kRegularWhiteTextStyle
                                                  .copyWith(
                                                      fontSize: 18,
                                                      color: ColorRes.black,
                                                      fontWeight:
                                                          FontWeight.w600),
                                            ),
                                          ),
                                          CustomTextField(
                                              borderRadius: 10,
                                              height: 45,
                                              textEditingController:
                                                  controller.amountController,
                                              onChanged: (v) {},
                                              tapToHide: () {
                                                // controller.hidePassword();
                                              }),
                                          10.ph,
                                          SizedBox(
                                            width: Get.width,
                                            child: Text(
                                              'Transaction Number*',
                                              style: kRegularWhiteTextStyle
                                                  .copyWith(
                                                      fontSize: 18,
                                                      color: ColorRes.black,
                                                      fontWeight:
                                                          FontWeight.w600),
                                            ),
                                          ),
                                          CustomTextField(
                                              borderRadius: 10,
                                              height: 45,
                                              textEditingController: controller
                                                  .transationController,
                                              onChanged: (v) {},
                                              tapToHide: () {
                                                // controller.hidePassword();
                                              }),
                                          10.ph,
                                          SizedBox(
                                            width: Get.width,
                                            child: Text(
                                              'Remarks',
                                              style: kRegularWhiteTextStyle
                                                  .copyWith(
                                                      fontSize: 18,
                                                      color: ColorRes.black,
                                                      fontWeight:
                                                          FontWeight.w600),
                                            ),
                                          ),
                                          CustomTextField(
                                              borderRadius: 10,
                                              height: 45,
                                              textEditingController:
                                                  controller.remarkController,
                                              onChanged: (v) {},
                                              visible: false,
                                              tapToHide: () {
                                                // controller.hidePassword();
                                              }),
                                          30.ph,
                                        ],
                                      ),
                                    ),
                                    CustomGeneralButton(
                                      onTab: () {
                                        controller.makePayment();
                                      },
                                      title: "Submit",
                                      //fontSize: 13,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        20.ph,
                        // commonBetaVersionEmail(),
                        // 20.ph
                      ],
                    ),
                  ),
          );
        });
  }
}
