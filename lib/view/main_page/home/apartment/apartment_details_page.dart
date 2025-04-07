import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marathon/controllers/home/apartment_details_controller/apartment_controller.dart';
import 'package:marathon/data/storage/app/app_holder.dart';
import 'package:marathon/data/tools/extensions/num_ext.dart';
import 'package:marathon/data/tools/toast/custom_snackbar.dart';
import 'package:marathon/view/widgets/custom_general_button.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../data/tools/decoration/dimens.dart';
import '../../../../data/tools/decoration/res_colors.dart';
import '../../../../data/tools/decoration/style_res.dart';
import '../../payments_page/milestone_page/make_payment/make_payment_page.dart';
import '../../payments_page/milestone_page/milestone_page.dart';

class ApartmentDetails extends StatefulWidget {
  final String id;

  const ApartmentDetails({
    super.key,
    required this.id,
  });

  @override
  State<ApartmentDetails> createState() => _ApartmentDetailsState();
}

class _ApartmentDetailsState extends State<ApartmentDetails> {
  var key = GlobalKey();
  var key1 = GlobalKey();
  var key2 = GlobalKey();

  Size? redBox;
  Size? redBox1;
  Size? redBox2;
  Timer? timer;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      log('widget.isSignIn ---------->>>>>>>> ${Get.find<ApartmentController>().isSignIn}');
      if (Get.find<ApartmentController>().isSignIn) {
        Future.delayed(
          const Duration(milliseconds: 1500),
          () {
            redBox = (key.currentContext?.findRenderObject() as RenderBox).size;
            redBox1 =
                (key1.currentContext?.findRenderObject() as RenderBox).size;
            redBox2 =
                (key2.currentContext?.findRenderObject() as RenderBox).size;
            setState(() {});
          },
        );
        setState(() {});
      } else {
        redBox = (key.currentContext?.findRenderObject() as RenderBox).size;
        redBox1 = (key1.currentContext?.findRenderObject() as RenderBox).size;
        redBox2 = (key2.currentContext?.findRenderObject() as RenderBox).size;
        setState(() {});
      }
    });
    super.initState();
  }

  double sliderValue = 0;

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    log('MediaQuery.of(context).size.height==========>>>>>${MediaQuery.of(context).size.width}');
    // final w = MediaQuery.of(context).size.width;
    return GetBuilder<ApartmentController>(
        init:
            ApartmentController(Get.find(), Get.find(), Get.find(), Get.find()),
        builder: (controller) {
          return Scaffold(
            body: controller.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        20.ph,
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: Dimens.padding),
                          child: Text(
                            textAlign: TextAlign.center,
                            "Your Apartment",
                            style: kRegularThemeTextStyle.copyWith(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: ColorRes.unPaidColor),
                          ),
                        ),

                        SizedBox(height: h * 0.01),
                         Padding(
                          padding:EdgeInsets.symmetric(horizontal: Dimens.padding),
                          child: Text(
                            textAlign: TextAlign.center,
                            "Welcome ${Get.find<AppHolder>().name}!",
                            style: kRegularThemeTextStyle.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: ColorRes.black),
                          ),
                        ),

                        SizedBox(height: h * 0.01),
                        Container(
                          margin: EdgeInsets.all(Dimens.padding),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: ColorRes.greyD3,
                                  spreadRadius: 1,
                                  blurRadius: 0,
                                  offset: Offset(0, 1.5),
                                ),
                              ],
                              color: ColorRes.drawerBackground,
                              borderRadius: BorderRadius.circular(30)),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Stack(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        textAlign: TextAlign.center,
                                        "Flat No: ${controller.apartmentDetailsResponse?.data?.apartmentDetails?.first.flatNo ?? ""}",
                                        style: kRegularThemeTextStyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: ColorRes.mainTextColor),
                                      ),
                                      SizedBox(height: h * 0.005),
                                      SizedBox(
                                        width: Get.width / 1.5,
                                        child: Text(
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                          controller
                                                  .apartmentDetailsResponse
                                                  ?.data
                                                  ?.apartmentDetails
                                                  ?.first
                                                  .projectAddress
                                                  ?.split(",")
                                                  .first ??
                                              "",
                                          style:
                                              kRegularThemeTextStyle.copyWith(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      ColorRes.greyTextColor),
                                        ),
                                      ),
                                      SizedBox(height: h * 0.004),
                                      SizedBox(
                                        width: Get.width / 1.5,
                                        child: Text(
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                          controller
                                                  .apartmentDetailsResponse
                                                  ?.data
                                                  ?.apartmentDetails
                                                  ?.first
                                                  .subProjectname
                                                  ?.split(",")
                                                  .first ??
                                              "",
                                          style:
                                              kRegularThemeTextStyle.copyWith(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      ColorRes.greyTextColor),
                                        ),
                                      ),
                                      SizedBox(height: h * 0.012),
                                      Text(
                                        textAlign: TextAlign.center,
                                        "Agreement Value - Rs ${double.parse(controller.apartmentDetailsResponse?.data?.apartmentDetails?.first.agreementValue ?? "0.0").toStringAsFixed(2)}",
                                        style: kRegularThemeTextStyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: ColorRes.unPaidColor),
                                      ),
                                      SizedBox(height: h * 0.005),
                                      controller
                                                  .apartmentDetailsResponse
                                                  ?.data
                                                  ?.apartmentDetails
                                                  ?.first
                                                  .receivedPercent ==
                                              null
                                          ? const SizedBox()
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  textAlign: TextAlign.center,
                                                  "Paid till date",
                                                  style: kRegularThemeTextStyle
                                                      .copyWith(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: ColorRes
                                                              .unPaidColor),
                                                ),
                                                Stack(
                                                  clipBehavior: Clip.none,
                                                  children: [
                                                    SliderTheme(
                                                      data: SliderThemeData(
                                                          trackHeight: h * 0.03,
                                                          valueIndicatorColor:
                                                              Colors
                                                                  .transparent,
                                                          trackShape:
                                                              const RectangularSliderTrackShape(),
                                                          overlayShape:
                                                              const RoundSliderOverlayShape(
                                                                  overlayRadius:
                                                                      0),
                                                          thumbShape:
                                                              SliderComponentShape
                                                                  .noThumb),
                                                      child: Slider(
                                                        onChanged: (value) {},
                                                        value: controller
                                                                    .apartmentDetailsResponse
                                                                    ?.data
                                                                    ?.apartmentDetails
                                                                    ?.first
                                                                    .receivedPercent ==
                                                                null
                                                            ? 0
                                                            : double.parse(controller
                                                                    .apartmentDetailsResponse
                                                                    ?.data
                                                                    ?.apartmentDetails
                                                                    ?.first
                                                                    .receivedPercent
                                                                    .toString() ??
                                                                "0"),
                                                        min: 0,
                                                        max: 100,
                                                        activeColor: ColorRes.mainButtonColor,
                                                        inactiveColor: Colors.grey.withValues(alpha: 0.6),
                                                        // inactiveColor: Colors.grey.withOpacity(0.6),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      left: 0,
                                                      right: 0,
                                                      top: 3,
                                                      bottom: 3,
                                                      child: Text(
                                                        "${controller.apartmentDetailsResponse?.data?.apartmentDetails?.first.receivedPercent ?? "0"}%",
                                                        style:
                                                            kRegularWhiteTextStyle
                                                                .copyWith(
                                                                    fontSize:
                                                                        14),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            )
                                    ],
                                  ),
                                ),
                                // Align(
                                //     alignment: Alignment.topRight,
                                //     child: Image(
                                //       image:
                                //           AssetImage(AppAssets.images.building),
                                //       height: 72,
                                //     )),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: h * 0.03),

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
                              35.pw,
                              Container(
                                width: Get.width - 100,
                                //color: ColorRes.grey,
                                key: key,
                                padding: EdgeInsets.only(bottom: h * 0.045),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      textAlign: TextAlign.start,
                                      "Last Payment",
                                      style: kRegularThemeTextStyle.copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: ColorRes.black),
                                    ),
                                    SizedBox(height: h * 0.002),
                                    Text(
                                      "Towards Milestone: ${controller.apartmentDetailsResponse?.data?.last?.eventName ?? ""}",
                                      maxLines: 200,
                                      overflow: TextOverflow.ellipsis,
                                      style: kRegularThemeTextStyle.copyWith(
                                          fontSize: 16, color: ColorRes.black),
                                    ),
                                    SizedBox(height: h * 0.002),
                                    Row(
                                      children: [
                                        Text(
                                          textAlign: TextAlign.start,
                                          "Amount:",
                                          style:
                                              kRegularThemeTextStyle.copyWith(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.normal,
                                                  color: ColorRes.black),
                                        ),
                                        Text(
                                          textAlign: TextAlign.start,
                                          " Rs.  ${double.parse(controller.apartmentDetailsResponse?.data?.last?.recvAmt.toString() ?? "0.0").toStringAsFixed(2)}",
                                          style:
                                              kRegularThemeTextStyle.copyWith(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: ColorRes.black),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: h * 0.005),
                                    CustomGeneralButton(
                                      onTab: () {
                                        controller.getReceipt(
                                            controller.apartmentDetailsResponse
                                                    ?.data?.last?.receiptId ??
                                                "",
                                            controller.apartmentDetailsResponse
                                                    ?.data?.last?.milestoneId ??
                                                "");
                                      },
                                      title: "View Receipt",
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
                              35.pw,
                              Container(
                                width: Get.width - 100,
                                //color: ColorRes.grey,
                                key: key1,
                                padding: EdgeInsets.only(bottom: h * 0.045),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      textAlign: TextAlign.center,
                                      "Payment Due",
                                      style: kRegularThemeTextStyle.copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: ColorRes.mainTextColor),
                                    ),
                                    SizedBox(height: h * 0.002),
                                    controller.apartmentDetailsResponse?.data
                                                ?.due?.eventName?.isEmpty ??
                                            true
                                        ? const SizedBox()
                                        : Text(
                                            //"Milestone:${controller.apartmentDetailsResponse?.data?.due.eventName ?? ""}",
                                            "Milestone:${controller.lastPendingEventName ?? ""}",
                                            style:
                                                kRegularThemeTextStyle.copyWith(
                                                    fontSize: 16,
                                                    color: ColorRes.black),
                                          ),
                                    SizedBox(height: h * 0.002),
                                    controller.apartmentDetailsResponse?.data
                                                ?.due?.amount?.isEmpty ??
                                            true
                                        ? Text(
                                            textAlign: TextAlign.center,
                                            "No dues currently",
                                            style:
                                                kRegularThemeTextStyle.copyWith(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color:
                                                        ColorRes.mainTextColor),
                                          )
                                        : Row(
                                            children: [
                                              Text(
                                                textAlign: TextAlign.center,
                                                "Amount:",
                                                style: kRegularThemeTextStyle
                                                    .copyWith(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: ColorRes
                                                            .mainTextColor),
                                              ),
                                              Text(
                                                textAlign: TextAlign.center,
                                                // " Rs. ${controller.apartmentDetailsResponse?.data?.due?.amount ?? ""}",
                                                " Rs. ${controller.lastPendingAmount}",
                                                style: kRegularThemeTextStyle
                                                    .copyWith(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: ColorRes
                                                            .mainTextColor),
                                              ),
                                            ],
                                          ),
                                    controller
                                                .apartmentDetailsResponse
                                                ?.data
                                                ?.due
                                                ?.outstandingAmt
                                                ?.isEmpty ??
                                            true
                                        ? const SizedBox()
                                        : Column(
                                            children: [
                                              SizedBox(height: h * 0.002),
                                              Row(
                                                children: [
                                                  Text(
                                                    textAlign: TextAlign.center,
                                                    "Total Outstanding:",
                                                    style: kRegularThemeTextStyle
                                                        .copyWith(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: ColorRes
                                                                .mainTextColor),
                                                  ),
                                                  Text(
                                                    textAlign: TextAlign.center,
                                                    //" Rs. ${controller.apartmentDetailsResponse?.data?.due?.outstandingAmt ?? ""}",
                                                    " Rs. ${controller.totalPendingAmount.toStringAsFixed(2)}",
                                                    style: kRegularThemeTextStyle
                                                        .copyWith(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: ColorRes
                                                                .mainTextColor),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                    controller.apartmentDetailsResponse?.data
                                                ?.due?.amount?.isEmpty ??
                                            true
                                        ? const SizedBox()
                                        : Column(
                                            children: [
                                              SizedBox(height: h * 0.005),
                                              CustomGeneralButton(
                                                onTab: () {
                                                  Get.to(
                                                      () =>
                                                          const MakePaymentPage(
                                                              receiptId: ["0"]),
                                                      arguments: {
                                                        "due_amount": controller
                                                                .apartmentDetailsResponse
                                                                ?.data
                                                                ?.due
                                                                ?.outstandingAmt ??
                                                            "",
                                                        "milestone_id": controller
                                                                .apartmentDetailsResponse
                                                                ?.data
                                                                ?.due
                                                                ?.milestoneId ??
                                                            "",
                                                        'receipt_ids': ""
                                                      });
                                                },
                                                title: "Pay Now",
                                              ),
                                            ],
                                          )
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
                              35.pw,
                              SizedBox(
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
                                      "Next Milestone",
                                      style: kRegularThemeTextStyle.copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: ColorRes.black),
                                    ),
                                    SizedBox(height: h * 0.002),
                                    controller.apartmentDetailsResponse?.data
                                                ?.next?.eventName?.isEmpty ??
                                            true
                                        ? const SizedBox()
                                        : Text(
                                            "Milestone:  ${controller.apartmentDetailsResponse?.data?.next?.eventName ?? ""}",
                                            maxLines: 200,
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                kRegularThemeTextStyle.copyWith(
                                                    fontSize: 16,
                                                    color: ColorRes.black),
                                          ),
                                    SizedBox(height: h * 0.002),
                                    controller.apartmentDetailsResponse?.data
                                                ?.next?.amount?.isEmpty ??
                                            true
                                        ? Text(
                                            textAlign: TextAlign.center,
                                            "No upcoming Milestone",
                                            style:
                                                kRegularThemeTextStyle.copyWith(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color:
                                                        ColorRes.mainTextColor),
                                          )
                                        : Row(
                                            children: [
                                              Text(
                                                textAlign: TextAlign.center,
                                                "Amount:",
                                                style: kRegularThemeTextStyle
                                                    .copyWith(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: ColorRes
                                                            .mainTextColor),
                                              ),
                                              Text(
                                                textAlign: TextAlign.center,
                                                "Rs. ${controller.apartmentDetailsResponse?.data?.next?.amount ?? ""}",
                                                style: kRegularThemeTextStyle
                                                    .copyWith(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: ColorRes
                                                            .mainTextColor),
                                              ),
                                            ],
                                          ),
                                    SizedBox(height: h * 0.005),
                                    CustomGeneralButton(
                                      onTab: () {
                                        Get.to(
                                          () => const MileStonePage(),
                                          arguments: controller
                                              .ledgerDetailsResponse
                                              ?.data
                                              ?.milestones,
                                        );
                                      },
                                      title: "View Schedule",
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),

                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          width: Get.width,
                          // decoration: BoxDecoration(
                          //     color: ColorRes.mainButtonColor.withOpacity(.025),
                          //     borderRadius: BorderRadius.circular(10)
                          // ),
                          child: const Text(
                            "Please note that payment details will reflect on the web portal or mobile app within 24 to 48 hours after the amount is realized in our account.",
                            style: TextStyle(
                              color: ColorRes.greyTextColor,
                              fontSize: 12
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        20.ph,

                        Row(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: 1,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 35),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            Uri url = Uri.parse(controller
                                                    .apartmentDetailsResponse
                                                    ?.data
                                                    ?.constructionLink ??
                                                "https://marathon.in/");
                                            if (await canLaunchUrl(url)) {
                                              launchUrl(url);
                                            } else {
                                              customSnackBar(
                                                  'Link not available');
                                            }
                                          },
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.25,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                      "${controller.apartmentDetailsResponse?.data?.constructionImage}",
                                                    ),
                                                    fit: BoxFit.fill)),
                                          ),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01,
                                        ),
                                        Text(
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          "Check the latest construction update",
                                          style:
                                              kRegularThemeTextStyle.copyWith(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01),
                                        CustomGeneralButton(
                                          onTab: () async {
                                            Uri url = Uri.parse(controller
                                                    .apartmentDetailsResponse
                                                    ?.data
                                                    ?.constructionLink ??
                                                "https://marathon.in/");
                                            if (await canLaunchUrl(url)) {
                                              launchUrl(url);
                                            } else {
                                              customSnackBar(
                                                  'Link not available');
                                            }
                                          },
                                          title: "View Now",
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: Dimens.padding),
                          child: Text(
                            "Explore our projects",
                            style: kSemiBoldTextStyle.copyWith(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.295,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: ListView.builder(
                                  controller: controller.scrollController,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller
                                      .allProjectResponse?.data?.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () async {
                                        Uri url = Uri.parse(controller
                                                .allProjectResponse
                                                ?.data?[index]
                                                .url ??
                                            "");
                                        if (await canLaunchUrl(url)) {
                                          launchUrl(url);
                                        } else {
                                          customSnackBar('Link not available');
                                        }
                                      },
                                      child: NewsList(
                                        images: controller.allProjectResponse
                                                ?.data?[index].picture ??
                                            "",
                                        text: controller.allProjectResponse
                                                ?.data?[index].name ??
                                            "",
                                        view: () {},
                                      ),
                                    );
                                  }),
                            )),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: Dimens.padding),
                          child: Text(
                            "Marathon News",
                            style: kSemiBoldTextStyle.copyWith(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.29,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: ListView.builder(
                                  controller: controller.scrollController1,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller.apartmentDetailsResponse
                                      ?.data?.mainSiteNews?.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () async {
                                        Uri url = Uri.parse(controller
                                                .apartmentDetailsResponse
                                                ?.data
                                                ?.mainSiteNews?[index]
                                                .link ??
                                            "");
                                        if (await canLaunchUrl(url)) {
                                          launchUrl(url);
                                        } else {
                                          customSnackBar('Link not available');
                                        }
                                      },
                                      child: NewsList(
                                        images: controller
                                                .apartmentDetailsResponse
                                                ?.data
                                                ?.mainSiteNews?[index]
                                                .image ??
                                            "",
                                        text: controller
                                                .apartmentDetailsResponse
                                                ?.data
                                                ?.mainSiteNews?[index]
                                                .title ??
                                            "",
                                        view: () {},
                                      ),
                                    );
                                  }),
                            )),
                        // 30.ph,
                        // commonBetaVersionEmail(),
                        20.ph
                      ],
                    ),
                  ),
          );
        });
  }
}

class NewsList extends StatelessWidget {
  final String images;
  final String text;

  final Function view;
  final String? description;

  const NewsList({
    super.key,
    required this.images,
    required this.text,
    required this.view,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width * 0.55,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage(
                    images,
                  ),
                  fit: BoxFit.cover)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.55,
            child: Text(
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              text,
              style: kRegularThemeTextStyle.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
