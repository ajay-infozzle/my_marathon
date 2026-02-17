
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:marathon/config/helpers.dart';
import 'package:marathon/controllers/support_controller/support_controller.dart';
import 'package:marathon/data/server/api/api_const.dart';
import 'package:marathon/data/storage/app/app_holder.dart';
import 'package:marathon/data/tools/extensions/num_ext.dart';
import 'package:marathon/view/widgets/custom_general_button.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/tools/constants/app_assets.dart';
import '../../../data/tools/decoration/dimens.dart';
import '../../../data/tools/decoration/res_colors.dart';
import '../../../data/tools/decoration/style_res.dart';


class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return GetBuilder<SupportController>(
        init: SupportController(Get.find(), Get.find()),
        builder: (controller) {
          return Scaffold(
            body: controller.isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: ColorRes.mainButtonColor,
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        10.ph,
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: Dimens.padding),
                          child: Text(
                            textAlign: TextAlign.start,
                            "Help Center",
                            style: kRegularThemeTextStyle.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: ColorRes.mainButtonColor),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: Dimens.padding),
                          child: Text(
                            textAlign: TextAlign.start,
                            "Get in touch, we’re happy to help.",
                            style: kRegularThemeTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: ColorRes.mainTextColor),
                          ),
                        ),
                        // 20.ph,

                        servicesDropdownSection(context, controller),
                        10.ph,

                        // DropdownTileWidget(
                        //   onTap: () {
                        //     controller.openTab(1);
                        //   },
                        //   title: 'General Service Request',
                        //   showBottomLine: !controller.openIndex.contains(1),
                        //   child: controller.openIndex.contains(1)
                        //       ? const RotatedBox(
                        //           quarterTurns: 1,
                        //           child: Icon(
                        //             Icons.arrow_forward_ios,
                        //             color: ColorRes.black,
                        //           ),
                        //         )
                        //       : const Icon(Icons.arrow_forward_ios),
                        // ),
                        controller.openIndex.contains(1) ? generalServiceForm(context, controller, showBottomLine: false) : const SizedBox(),

                        controller.openIndex.contains(2) ? complaintForm(context, controller, showBottomLine: false) : const SizedBox(),

                        controller.openIndex.contains(3) ? flatVisitServiceForm(context, controller, showBottomLine: false) : const SizedBox(),

                        controller.openIndex.contains(4) ? nameChangeServiceForm(context, controller, showBottomLine: false) : const SizedBox(),

                        if(!controller.showOtpField)
                        controller.openIndex.contains(5) ? emailChangeServiceForm(context, controller, showBottomLine: false) : const SizedBox(),

                        if(!controller.showOtpField)
                        controller.openIndex.contains(6) ? mobileChangeServiceForm(context, controller, showBottomLine: false) : const SizedBox(),

                        if(controller.showOtpField && (controller.openIndex.contains(5) || controller.openIndex.contains(6)))
                        otpForm(context, controller, showBottomLine: false),

                        /*Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: Dimens.padding),
                          child: const Text(
                              textAlign: TextAlign.start,
                              "For any service request, please use the below form",
                              style: kRegularThemeTextStyle),
                        ),
                        10.ph,
                        generalServiceForm(context, controller), **/
                        

                        SizedBox(height: h * 0.01),

                        SizedBox(
                          width: double.maxFinite,
                          child: rmContainer(),
                        ),

                        SizedBox(height: h * 0.05),
                        Divider(),
                        Padding(padding:EdgeInsets.symmetric(horizontal: Dimens.padding),
                          child: Text(
                            textAlign: TextAlign.start,
                            "Frequently Asked Questions.",
                            style: kRegularThemeTextStyle.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: ColorRes.mainButtonColor),
                          ),
                        ),
                        SizedBox(height: h * 0.01),
                        Padding(
                          padding:EdgeInsets.symmetric(horizontal: Dimens.padding),
                          child: const Text(
                              textAlign: TextAlign.start,
                              "Get the answers to the most frequently asked questions – on your journey with Marathon,payments, demands, stamp duty and lots more.",
                              style: kRegularThemeTextStyle),
                        ),
                        10.ph,
                        Container(
                          margin: const EdgeInsets.all(15),
                          alignment: Alignment.center,
                          //height: 35,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: ColorRes.greyD3,
                                  spreadRadius: 1,
                                  blurRadius: 0,
                                  offset: Offset(0.5, 1.5),
                                ),
                              ],
                              color: ColorRes.textFieldColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(Dimens.buttonRadius),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 15, left: 15),
                                child: Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.055,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5)),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      isExpanded: true,
                                      value: controller.selectCategory!.isEmpty
                                          ? null
                                          : controller.selectCategory,
                                      style: kRegularThemeTextStyle.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      icon: const Icon(Icons.arrow_drop_down_sharp),
                                      items: controller.faqCategory
                                          .map((String value) {
                                        return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black),
                                            ));
                                      }).toList(),
                                      hint: Text(
                                        'Select Topic',
                                        style: kRegularThemeTextStyle.copyWith(
                                            color: ColorRes.hintColor,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      onChanged: (value) {
                                        controller.selectCategory = value!;
                                        controller.update();
                                        controller.questionList(controller.selectCategory.toString());
                                      },
                                    ),
                                  ),
                                ),
                              )),
                        ),

                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.faqData.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: Dimens.padding,
                                      vertical: 5,
                                    ),
                                    width: Get.width,
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: ColorRes.greyColor,
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                    child: IssueTitle(
                                      onTap: () {
                                        controller.openTab(index);
                                      },
                                      title: controller.faqData[index].question.toString(),
                                      child:
                                          controller.openIndex.contains(index)
                                              ? const RotatedBox(
                                                  quarterTurns: 1,
                                                  child: Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: ColorRes.black,
                                                  ),
                                                )
                                              : const Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: ColorRes.black,
                                                ),
                                    ),
                                  ),
                                  if (controller.openIndex.contains(index))
                                    ContentData(
                                      index: index,
                                      openedIndex: controller.openIndex,
                                      open: () {
                                        controller.openTab(index);
                                      },
                                      content: controller.faqData[index].answer.toString(),
                                    ),
                                ],
                              );
                            }),
                        20.ph,
                        // commonBetaVersionEmail(),
                        // 20.ph,
                      ],
                    ),
                  ),
          );
        });
  }

  Widget servicesDropdownSection(BuildContext context, SupportController controller){
    return Container(
      margin: const EdgeInsets.all(15),
      alignment: Alignment.center,
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: ColorRes.greyD3,
            spreadRadius: 1,
            blurRadius: 0,
            offset: Offset(0.5, 1.5),
          ),
        ],
        color: ColorRes.textFieldColor,
        borderRadius: BorderRadius.circular(10)
      ),
      child: ClipRRect(
          borderRadius:BorderRadius.circular(Dimens.buttonRadius),
          child: Padding(padding:const EdgeInsets.only(right: 15, left: 15),
            child: Container(
              // height: MediaQuery.of(context).size.height * 0.055,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  isExpanded: true,
                  value: controller.selectService!.isEmpty
                      ? null
                      : controller.selectService,
                  style: kRegularThemeTextStyle.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  icon: const Icon(Icons.arrow_drop_down_sharp),
                  items: controller.services.map((String value) {
                    return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                        ));
                  }).toList(),
                  hint: Text(
                    'Select Service',
                    style: kRegularThemeTextStyle.copyWith(
                        color: ColorRes.hintColor,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                  onChanged: (value) {
                    controller.selectService = value!;
                    int selectedServices = controller.services.indexOf(value);
                    controller.openTab(selectedServices+1);
                    controller.update();
                  },
                ),
              ),
            ),
          )),
    );
  }
  
  Widget generalServiceForm(BuildContext context, SupportController controller, {bool showBottomLine = true}) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: showBottomLine ? ColorRes.greyColor : Colors.transparent, 
            width: showBottomLine ? 2.0 : 0, 
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.center,
            height: 35,
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: ColorRes.greyD3,
                  spreadRadius: 1,
                  blurRadius: 0,
                  offset: Offset(0.5, 1.5), 
                ),
              ],
              color: ColorRes.textFieldColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius:BorderRadius.circular(Dimens.buttonRadius),
              child: Padding(padding:const EdgeInsets.only(right: 15, left: 15),
                child: Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        onTap: () {
                          // FocusScope.of(context).unfocus();
                        },
                        style: kRegularThemeTextStyle,
                        controller:controller.subjectController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Subject*",
                            hintStyle:kRegularTextStyle.copyWith(
                              fontSize: 16,
                              color: ColorRes.hintColor,
                              fontWeight:FontWeight.w400
                            )
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                  ],
                ),
              )
            ),
          ),

          10.ph,
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.topLeft,
            height: 115,
            width: double.infinity,
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: ColorRes.greyD3,
                    spreadRadius: 1,
                    blurRadius: 0,
                    offset: Offset(0.5, 1.5),
                  ),
                ],
                color: ColorRes.textFieldColor,
                borderRadius: BorderRadius.circular(10)),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(Dimens.buttonRadius),
                child: Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15),
                  child: Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          onTap: () {
                            // FocusScope.of(context).unfocus();
                          },
                          style: kRegularThemeTextStyle,
                          maxLines: 100,
                          controller: controller.messageController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Type your message here*",
                            hintStyle: kRegularTextStyle.copyWith(
                              fontSize: 16,
                              color: ColorRes.hintColor,
                              fontWeight: FontWeight.w400
                            )
                          ),
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                    ],
                  ),
                )),
          ),

          GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              controller.takeBook();
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              height: 40,
              width: 170,
              decoration: BoxDecoration(
                  color: ColorRes.greyF1,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(Icons.attach_file),
                  Flexible(
                    child: Text(
                        overflow: TextOverflow.ellipsis,
                        controller.attached ? controller.bookName : "Add attachment",
                        style: kRegularTextStyle.copyWith(color: ColorRes.grey)
                    ),
                  ),
                ],
              ),
            ),
          ),

          10.ph,
          Padding(
            padding:EdgeInsets.symmetric(horizontal: Dimens.padding),
            child: CustomGeneralButton(
              onTab: () {
                controller.sentMessage();
              },
              title: "Submit",
              //verticalPadding: 5,
              // width: 158
            ),
          ),
      
          20.ph,
        ],
      ),
    );
  }
  
  Widget complaintForm(BuildContext context, SupportController controller, {bool showBottomLine = true}) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: showBottomLine ? ColorRes.greyColor : Colors.transparent, 
            width: showBottomLine ? 2.0 : 0, 
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.center,
            height: 35,
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: ColorRes.greyD3,
                  spreadRadius: 1,
                  blurRadius: 0,
                  offset: Offset(0.5, 1.5), 
                ),
              ],
              color: ColorRes.textFieldColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius:BorderRadius.circular(Dimens.buttonRadius),
              child: Padding(padding:const EdgeInsets.only(right: 15, left: 15),
                child: Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        onTap: () {
                          // FocusScope.of(context).unfocus();
                        },
                        style: kRegularThemeTextStyle,
                        controller:controller.complainSubjectController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Subject*",
                          hintStyle:kRegularTextStyle.copyWith(
                            fontSize: 16,
                            color: ColorRes.hintColor,
                            fontWeight:FontWeight.w400
                          )
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                  ],
                ),
              )
            ),
          ),

          10.ph,
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.topLeft,
            height: 115,
            width: double.infinity,
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: ColorRes.greyD3,
                    spreadRadius: 1,
                    blurRadius: 0,
                    offset: Offset(0.5, 1.5),
                  ),
                ],
                color: ColorRes.textFieldColor,
                borderRadius: BorderRadius.circular(10)),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(Dimens.buttonRadius),
                child: Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15),
                  child: Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          onTap: () {
                            // FocusScope.of(context).unfocus();
                          },
                          style: kRegularThemeTextStyle,
                          maxLines: 100,
                          controller: controller.complainMessageController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Please share details of your complaint*",
                            hintStyle: kRegularTextStyle.copyWith(
                              fontSize: 16,
                              color: ColorRes.hintColor,
                              fontWeight: FontWeight.w400
                            )
                          ),
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                    ],
                  ),
                )),
          ),

          GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              controller.takeComplainAttachment();
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              height: 40,
              width: 170,
              decoration: BoxDecoration(
                  color: ColorRes.greyF1,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(Icons.attach_file),
                  Flexible(
                    child: Text(
                        overflow: TextOverflow.ellipsis,
                        controller.complainAttached ? controller.complainName : "Add attachment",
                        style: kRegularTextStyle.copyWith(color: ColorRes.grey)
                    ),
                  ),
                ],
              ),
            ),
          ),

          10.ph,
          Padding(
            padding:EdgeInsets.symmetric(horizontal: Dimens.padding),
            child: CustomGeneralButton(
              onTab: () {
                controller.sendComplainForm();
              },
              title: "Submit",
            ),
          ),
      
          20.ph,
        ],
      ),
    );
  }

  Widget flatVisitServiceForm(BuildContext context, SupportController controller, {bool showBottomLine = true}) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: showBottomLine ? ColorRes.greyColor : Colors.transparent, 
            width: showBottomLine ? 2.0 : 0, 
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.055,
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: ColorRes.greyD3,
                  spreadRadius: 1,
                  blurRadius: 0,
                  offset: Offset(0.5, 1.5), 
                ),
              ],
              color: ColorRes.textFieldColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius:BorderRadius.circular(Dimens.buttonRadius),
              child: Padding(padding:const EdgeInsets.only(right: 15, left: 15),
                child: Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        onTap: () {
                          controller.getDateFromUser(context);
                        },
                        style: kRegularThemeTextStyle,
                        controller:controller.visitDateCont,
                        canRequestFocus: false,
                        showCursor: false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Date of visit*",
                          hintStyle:kRegularTextStyle.copyWith(
                            fontSize: 16,
                            color: ColorRes.hintColor,
                            fontWeight:FontWeight.w400
                          ),
                          suffixIcon: const Icon(
                            Icons.calendar_today_outlined,
                            color: ColorRes.grey,
                          )
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ),
          ),
          10.ph,

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.055,
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: ColorRes.greyD3,
                  spreadRadius: 1,
                  blurRadius: 0,
                  offset: Offset(0.5, 1.5), 
                ),
              ],
              color: ColorRes.textFieldColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius:BorderRadius.circular(Dimens.buttonRadius),
              child: Padding(padding:const EdgeInsets.only(right: 15, left: 15),
                child: Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        onTap: () {
                          controller.getTimeFromUser(context);
                        },
                        style: kRegularThemeTextStyle,
                        controller:controller.visitTimeCont,
                        canRequestFocus: false,
                        showCursor: false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Time of visit*",
                          hintStyle:kRegularTextStyle.copyWith(
                            fontSize: 16,
                            color: ColorRes.hintColor,
                            fontWeight:FontWeight.w400
                          ),
                          suffixIcon: const Icon(
                            Icons.watch_later_outlined,
                            color: ColorRes.grey,
                          )
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ),
          ),
          10.ph,

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.topLeft,
            height: 115,
            width: double.infinity,
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: ColorRes.greyD3,
                    spreadRadius: 1,
                    blurRadius: 0,
                    offset: Offset(0.5, 1.5),
                  ),
                ],
                color: ColorRes.textFieldColor,
                borderRadius: BorderRadius.circular(10)),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(Dimens.buttonRadius),
                child: Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15),
                  child: Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          onTap: () {
                            // FocusScope.of(context).unfocus();
                          },
                          style: kRegularThemeTextStyle,
                          maxLines: 100,
                          controller: controller.visitPurposeCont,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Purpose of visit*",
                            hintStyle: kRegularTextStyle.copyWith(
                              fontSize: 16,
                              color: ColorRes.hintColor,
                              fontWeight: FontWeight.w400
                            )
                          ),
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          10.ph,

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            width: Get.width,
            // decoration: BoxDecoration(
            //     color: ColorRes.mainButtonColor.withOpacity(.025),
            //     borderRadius: BorderRadius.circular(10)
            // ),
            child: const Text(
              "Please note that visits are subject to prior authorisation and are permitted at the builder's discretion. Please give us at least 72 hours prior notice. Visits may not be allowed in case there are safety concerns in visiting the under-construction property site.",
              style: TextStyle(
                color: ColorRes.greyTextColor,
                fontSize: 12
              ),
              textAlign: TextAlign.start,
            ),
          ),

          10.ph,
          Padding(
            padding:EdgeInsets.symmetric(horizontal: Dimens.padding),
            child: CustomGeneralButton(
              onTab: () {
                controller.sendFlatVisitRequestForm();
              },
              title: "Submit",
            ),
          ),
      
          20.ph,
        ],
      ),
    );
  }
  
  Widget nameChangeServiceForm(BuildContext context, SupportController controller, {bool showBottomLine = true}) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: showBottomLine ? ColorRes.greyColor : Colors.transparent, 
            width: showBottomLine ? 2.0 : 0, 
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            width: Get.width,
            child: const Text(
              "Please download the required form(s) below, fill them up, and upload them to the field mentioned below or share them with your Relationship Manager:",
              style: TextStyle(
                color: ColorRes.mainTextColor,
                fontSize: 14,
              ),
            ),
          ),
          10.ph,

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            width: Get.width,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Name Deletion Letter",
                    style: const TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        launchUrl(Uri.parse(Api.nameDeletionFormDownloadUrl));
                      },
                  ),

                  const TextSpan(text: "\n\n"),

                  TextSpan(
                    text: "Revised Name Addition Letter",
                    style: const TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        launchUrl(Uri.parse(Api.nameAdditionFormDownloadUrl));
                      },
                  ),

                  const TextSpan(text: "\n\n"),

                  TextSpan(
                    text: "Revised Name Interchange Letter",
                    style: const TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        launchUrl(Uri.parse(Api.nameInterchangeFormDownloadUrl));
                      },
                  ),
                ]
              ),
            ),
          ),
          
          20.ph,
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.055,
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: ColorRes.greyD3,
                  spreadRadius: 1,
                  blurRadius: 0,
                  offset: Offset(0.5, 1.5), 
                ),
              ],
              color: ColorRes.textFieldColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius:BorderRadius.circular(Dimens.buttonRadius),
              child: Padding(padding:const EdgeInsets.only(right: 15, left: 15),
                child: Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        onTap: () {
                          controller.takeNameChangeFormAttachment();
                        },
                        style: kRegularThemeTextStyle,
                        controller:controller.nameChangeCont,
                        canRequestFocus: false,
                        showCursor: false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Upload Request Form",
                          hintStyle:kRegularTextStyle.copyWith(
                            fontSize: 16,
                            color: ColorRes.hintColor,
                            fontWeight:FontWeight.w400
                          ),
                          suffixIcon: const Icon(
                            Icons.attachment_rounded,
                            color: ColorRes.grey,
                          )
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ),
          ),
          20.ph,

          Padding(
            padding:EdgeInsets.symmetric(horizontal: Dimens.padding),
            child: CustomGeneralButton(
              onTab: () {
                controller.sendNameChangeForm();
              },
              title: "Submit",
            ),
          ),
      
          20.ph,
        ],
      ),
    );
  }

  Widget emailChangeServiceForm(BuildContext context, SupportController controller, {required bool showBottomLine}) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: showBottomLine ? ColorRes.greyColor : Colors.transparent, 
            width: showBottomLine ? 2.0 : 0, 
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.055,
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: ColorRes.greyD3,
                  spreadRadius: 1,
                  blurRadius: 0,
                  offset: Offset(0.5, 1.5), 
                ),
              ],
              color: ColorRes.textFieldColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius:BorderRadius.circular(Dimens.buttonRadius),
              child: Padding(padding:const EdgeInsets.only(right: 15, left: 15),
                child: Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        onTap: () {
                          // FocusScope.of(context).unfocus();
                        },
                        style: kRegularThemeTextStyle,
                        controller:controller.emailChangeController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "New Email ID",
                          hintStyle:kRegularTextStyle.copyWith(
                            fontSize: 16,
                            color: ColorRes.hintColor,
                            fontWeight:FontWeight.w400
                          )
                        ),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ],
                ),
              )
            ),
          ),
        
          30.ph,
          Padding(
            padding:EdgeInsets.symmetric(horizontal: Dimens.padding),
            child: CustomGeneralButton(
              onTab: () {
                controller.sendOtp(isEmail: true); 
              },
              title: "Submit",
            ),
          ),
      
          20.ph,
        ],
      ),
    );
  }
  
  Widget mobileChangeServiceForm(BuildContext context, SupportController controller, {required bool showBottomLine}) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: showBottomLine ? ColorRes.greyColor : Colors.transparent, 
            width: showBottomLine ? 2.0 : 0, 
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.055,
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: ColorRes.greyD3,
                  spreadRadius: 1,
                  blurRadius: 0,
                  offset: Offset(0.5, 1.5), 
                ),
              ],
              color: ColorRes.textFieldColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius:BorderRadius.circular(Dimens.buttonRadius),
              child: Padding(padding:const EdgeInsets.only(right: 15, left: 15),
                child: Row(
                  children: [
                    Flexible(
                      child: PhoneFormField(
                        controller: controller.mobileChangeController,
                        isCountryButtonPersistent: true,
                        isCountrySelectionEnabled: true,
                        autofillHints: const [AutofillHints.telephoneNumber],
                        style: kRegularThemeTextStyle,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "New Mobile Number",
                          hintStyle:kRegularTextStyle.copyWith(
                            fontSize: 16,
                            color: ColorRes.hintColor,
                            fontWeight:FontWeight.w400
                          )
                        ),
                        keyboardType: TextInputType.numberWithOptions(),
                        textInputAction: TextInputAction.done,
                        countryButtonStyle: CountryButtonStyle(
                          showFlag: false,
                          showIsoCode: false,
                          showDialCode: true,
                          showDropdownIcon: false,
                          padding: const EdgeInsets.only(right: 10, left: 10),
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                          ),
                        ),
                        textAlignVertical: TextAlignVertical.center,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        cursorColor: Theme.of(context).colorScheme.primary,
                        cursorWidth: 1,
                        onChanged: (value) {
                          // controller.newMobileNumber = value.countryCode + value.nsn ;
                        },
                      ),
                    ),
                  ],
                ),
              )
            ),
          ),
        
          30.ph,
          Padding(
            padding:EdgeInsets.symmetric(horizontal: Dimens.padding),
            child: CustomGeneralButton(
              onTab: () {
                controller.sendOtp(isMobile: true); 
              },
              title: "Submit",
            ),
          ),
      
          20.ph,
        ],
      ),
    );
  }

  Widget otpForm(BuildContext context, SupportController controller, {required bool showBottomLine}) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: showBottomLine ? ColorRes.greyColor : Colors.transparent, 
            width: showBottomLine ? 2.0 : 0, 
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimens.padding),
            child: Text(
              textAlign: TextAlign.start,
              controller.openIndex.contains(6) ? "Enter the OTP sent to your mobile number" : "Enter the OTP sent to your Email Address",
              style: kRegularThemeTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: ColorRes.mainButtonColor),
            ),
          ),
          10.ph,

          Padding(padding:EdgeInsets.symmetric(horizontal: Dimens.padding),
            child: Row(
              children: [
                Flexible(
                  child: PinCodeTextField(
                    appContext: context,
                    // controller: controller.otpController,
                    pastedTextStyle: const TextStyle(
                      color: ColorRes.white,
                    ),
                    mainAxisAlignment: MainAxisAlignment.start,
                    separatorBuilder: (context, index) => SizedBox(width: 12,),
                    length: 4,
                    obscureText: false,
                    obscuringCharacter: '*',
                    blinkWhenObscuring: true,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      activeColor: ColorRes.greyD9,
                      disabledColor: Colors.black,
                      selectedColor: Colors.black,
                      shape: PinCodeFieldShape.box,
                      borderWidth: 0.1,
                      selectedFillColor: ColorRes.white,
                      disabledBorderWidth: 0.1,
                      errorBorderColor: ColorRes.black,
                      borderRadius: BorderRadius.circular(10.12),
                      fieldHeight: 45,
                      fieldWidth: 45,
                      activeFillColor: ColorRes.white,
                      inactiveColor: ColorRes.greyD9,
                      inactiveFillColor: ColorRes.white
                    ),
                    cursorColor: ColorRes.black,
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    keyboardType: TextInputType.number,
                    boxShadows: const [
                      BoxShadow(
                        offset: Offset(3, 3),
                        color: Colors.black12,
                        blurRadius: 1,
                      )
                    ],
                    onCompleted: (v) {
                      controller.otp = v ;
                    },
                    onChanged: (value) {
                      controller.otp = value ;
                    },
                    beforeTextPaste: (text) {
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                  ),
                ),
              ],
            ),
          ),
        
          10.ph,
          Padding(
            padding:EdgeInsets.symmetric(horizontal: Dimens.padding),
            child: CustomGeneralButton(
              onTab: () {
                controller.verifyOtp(
                  isEmail: controller.openIndex.contains(5),
                  isMobile: controller.openIndex.contains(6)
                );
              },
              title: "Submit",
            ),
          ),
      
          20.ph,
        ],
      ),
    );
  }
  
  Widget rmContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          color: ColorRes.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimens.padding),
                child: Text(
                  textAlign: TextAlign.start,
                  "Contact your Relationship Manager",
                  style: kRegularThemeTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: ColorRes.mainButtonColor),
                ),
              ),
              10.ph,
              Padding(
                padding:EdgeInsets.symmetric(horizontal: Dimens.padding),
                child: Text(
                  textAlign: TextAlign.start,
                  Get.find<AppHolder>().rmManagerName,
                  style: kRegularThemeTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: ColorRes.mainTextColor),
                ),
              ),
              10.ph,
              GestureDetector(
                onTap: () => launchPhone(Get.find<AppHolder>().rmManagerNumber),
                child: Padding(
                  padding:EdgeInsets.symmetric(horizontal: Dimens.padding),
                  child: Row(
                    children: [
                      Icon(
                        Icons.call,
                        color: ColorRes.mainButtonColor,
                        size: 20,
                      ),
                      10.pw,
                      Text(
                        textAlign: TextAlign.start,
                        Get.find<AppHolder>().rmManagerNumber,
                        style: kRegularThemeTextStyle.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: ColorRes.mainTextColor),
                      )
                    ],
                  ),
                ),
              ),

              10.ph,

              GestureDetector(
                onTap: () => launchEmail(Get.find<AppHolder>().rmManagerEmail.toLowerCase()),
                child: Padding(
                  padding:EdgeInsets.symmetric(horizontal: Dimens.padding),
                  child: Row(
                    children: [
                      Icon(
                        Icons.email,
                        color: ColorRes.mainButtonColor,
                        size: 20,
                      ),
                      10.pw,
                      Text(
                        textAlign: TextAlign.start,
                        Get.find<AppHolder>().rmManagerEmail.toLowerCase(),
                        style: kRegularThemeTextStyle.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: ColorRes.mainTextColor),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        20.ph,
        Padding(
          padding:EdgeInsets.symmetric(horizontal: Dimens.padding),
          child: Text(
            textAlign: TextAlign.start,
            "For any escalations or feedback please write to",
            style: kRegularThemeTextStyle.copyWith(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
                color: ColorRes.mainTextColor),
          ),
        ),
        // 5.ph,
        Padding(
          padding:EdgeInsets.symmetric(horizontal: Dimens.padding),
          child: SelectableText(
            textAlign: TextAlign.start,
            "customercare@marathonreality.com",
            style: kRegularThemeTextStyle.copyWith(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
                color: ColorRes.mainButtonColor),
          ),
        ),
      ],
    );
  }

}

class TopicTitle extends StatelessWidget {
  final String title;
  final Function onTap;
  const TopicTitle({
    super.key,
    required this.title,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                textAlign: TextAlign.start,
                // overflow: TextOverflow.ellipsis,
                title,
                maxLines: 5,
                style: kRegularThemeTextStyle,
              ),
            ),
            GestureDetector(
                onTap: () {
                  onTap();
                },
                child: const Icon(
                  Icons.add,
                  color: ColorRes.mainButtonColor,
                ))
          ],
        ),
      ),
    );
  }
}

class IssueTitle extends StatelessWidget {
  final String title;
  final Function onTap;
  final Widget child;
  const IssueTitle({
    super.key,
    required this.title,
    required this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5, top: 5),
      padding: EdgeInsets.symmetric(horizontal: Dimens.padding),
      //height: 50,
      width: Get.width,
      // decoration: const BoxDecoration(
      //   border: Border(
      //     bottom: BorderSide(
      //       color: ColorRes.greyColor,
      //       width: 2.0,
      //     ),
      //   ),
      // ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: GestureDetector(
          onTap: () {
            onTap();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  title,
                  maxLines: 5,
                  style: kRegularThemeTextStyle.copyWith(color: ColorRes.black),
                ),
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

class ContentData extends StatelessWidget {
  final String content;
  final List? openedIndex;
  final int? index;
  final Function open;
  const ContentData({
    super.key,
    required this.content,
    this.openedIndex,
    this.index,
    required this.open,
  });

  String _cleanHtmlContent(String htmlContent) {
    final customTagRegExp = RegExp(r'\[\/?vc_[^\]]+\]');
    String cleanedContent = htmlContent.replaceAll(customTagRegExp, '');
    return cleanedContent;
  }

  @override
  Widget build(BuildContext context) {
    bool needOpen(List list, int index) {
      return list.contains(index);
    }

    String cleanedContent = _cleanHtmlContent(content);

    return Visibility(
      visible: needOpen(openedIndex!, index!),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.all(10),
          width: Get.width,
          decoration: const BoxDecoration(
            color: ColorRes.greyF1,
          ),
          child: Html(
            data: cleanedContent,
            style: {
              "body": Style(
                color: ColorRes.black,
                fontFamily: AppFonts.fnproximanovaRegular,
                fontSize: FontSize(14),
              ),
            },
          ),
        ),
      ),
    );
  }
}
