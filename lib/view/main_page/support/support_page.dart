import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:marathon/controllers/support_controller/support_controller.dart';
import 'package:marathon/data/tools/extensions/num_ext.dart';
import 'package:marathon/view/main_page/support/support_detail/support_detail.dart';
import 'package:marathon/view/widgets/custom_general_button.dart';
import '../../../data/tools/constants/app_assets.dart';
import '../../../data/tools/decoration/dimens.dart';
import '../../../data/tools/decoration/res_colors.dart';
import '../../../data/tools/decoration/style_res.dart';
import '../../widgets/common_beta_version_email.dart';

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
                        20.ph,
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: Dimens.padding),
                          child: const Text(
                              textAlign: TextAlign.start,
                              "For any service request, please use the below form",
                              style: kRegularThemeTextStyle),
                        ),
                        10.ph,
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
                                offset: Offset(
                                    0.5, 1.5), // changes position of shadow
                              ),
                            ],
                            color: ColorRes.textFieldColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(Dimens.buttonRadius),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 15, left: 15),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: TextFormField(
                                        onTap: () {
                                          FocusScope.of(context).unfocus();
                                        },
                                        style: kRegularThemeTextStyle,
                                        controller:
                                            controller.subjectController,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Subject*",
                                            hintStyle:
                                                kRegularTextStyle.copyWith(
                                                    fontSize: 16,
                                                    color: ColorRes.hintColor,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
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
                              borderRadius:
                                  BorderRadius.circular(Dimens.buttonRadius),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 15, left: 15),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: TextFormField(
                                        onTap: () {
                                          FocusScope.of(context).unfocus();
                                        },
                                        style: kRegularThemeTextStyle,
                                        maxLines: 100,
                                        controller:
                                            controller.messageController,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Type your message here*",
                                            hintStyle:
                                                kRegularTextStyle.copyWith(
                                                    fontSize: 16,
                                                    color: ColorRes.hintColor,
                                                    fontWeight:
                                                        FontWeight.w400)),
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
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            height: 40,
                            width: 170,
                            decoration: BoxDecoration(
                                color: ColorRes.greyF1,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Icon(Icons.attach_file),
                                Flexible(
                                  child: Text(
                                      overflow: TextOverflow.ellipsis,
                                      controller.attached
                                          ? controller.bookName
                                          : "Add attachment",
                                      style: kRegularTextStyle.copyWith(
                                          color: ColorRes.grey)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        10.ph,
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: Dimens.padding),
                          child: CustomGeneralButton(
                            onTab: () {
                              controller.sentMessage();
                            },
                            title: "Submit",
                            //verticalPadding: 5,
                            // width: 158
                          ),
                        ),
                        SizedBox(height: h * 0.01),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: Dimens.padding),
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

                        // ListView.builder(
                        //   shrinkWrap: true,
                        //   physics: const NeverScrollableScrollPhysics(),
                        //   itemCount: controller.isSearch
                        //       ? controller.searchFaq.length
                        //       : controller.faqCategory.length ?? 0,
                        //   itemBuilder: (context, index) {
                        //     return Padding(
                        //       padding: const EdgeInsets.symmetric(vertical: 2),
                        //       child: TopicTitle(
                        //         title: controller.isSearch
                        //             ? "${controller.searchFaq[index].category}"
                        //             : controller.faqCategory[index],
                        //         onTap: () {
                        //           controller.questionList(
                        //               controller.faqCategory[index]);
                        //           // Get.to(() => SupportDetailPage(), arguments: {
                        //           //   "name": controller.faqCategory[index],
                        //           // });
                        //         },
                        //       ),
                        //     );
                        //   },
                        // ),

                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.faqData.length ?? 0,
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
                                      title: controller.faqData[index].question
                                              .toString() ??
                                          "",
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
                                      content: controller.faqData[index].answer
                                              .toString() ??
                                          "",
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
