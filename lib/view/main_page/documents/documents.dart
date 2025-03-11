import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marathon/controllers/document/document_controller.dart';
import 'package:marathon/data/tools/extensions/num_ext.dart';
import 'package:marathon/view/main_page/documents/widgets/document_tile.dart';
import 'package:marathon/view/widgets/custom_general_button.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/tools/decoration/dimens.dart';
import '../../../data/tools/decoration/res_colors.dart';
import '../../../data/tools/decoration/style_res.dart';
import '../../../data/tools/toast/custom_snackbar.dart';
import '../../../domain/entities/documents/documents.dart';
import '../../../domain/entities/documents/documents_receipts.dart';


class DocumentsPage extends StatelessWidget {
  const DocumentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DocumentController>(
        init: DocumentController(Get.find(), Get.find(), Get.find()),
        builder: (controller) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: controller.isLoading
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      controller.loadingText != "" ? Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Column(
                          children: [
                            Text(
                              controller.loadingText.split("\n").first,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                              ),
                            ),
                            Text(
                              controller.loadingText.split("\n").last,
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ) : SizedBox()
                    ],
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        10.ph,
                        Padding(
                          padding:EdgeInsets.symmetric(horizontal: Dimens.padding),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              textAlign: TextAlign.start,
                              "Documents",
                              style: kRegularThemeTextStyle.copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: ColorRes.mainButtonColor),
                            ),
                          ),
                        ),

                        // 10.ph,
                        // Padding(
                        //   padding:EdgeInsets.symmetric(horizontal: Dimens.padding),
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       Get.to(const KycScreen());
                        //     },
                        //     child: Container(
                        //       alignment: Alignment.center,
                        //       child: Text(
                        //         textAlign: TextAlign.start,
                        //         "Update Kyc",
                        //         style: kRegularThemeTextStyle.copyWith(
                        //             fontSize: 20,
                        //             fontWeight: FontWeight.w600,
                        //             color: ColorRes.mainButtonColor),
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        DocumentTileWidget(
                          onTap: () {
                            controller.openTab(1);
                          },
                          title: 'General',
                          child: controller.openIndex.contains(1)
                              ? const RotatedBox(
                                  quarterTurns: 1,
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: ColorRes.black,
                                  ),
                                )
                              : const Icon(Icons.arrow_forward_ios),
                        ),
                        GeneralData(
                          index: 1,
                          isGeneral: true,
                          documents: controller.responses?.data?.documents,
                          openedIndex: controller.openIndex,
                          controller: controller,
                        ),
                        10.ph,
                        DocumentTileWidget(
                          onTap: () {
                            controller.openTab(2);
                          },
                          title: 'Receipts',
                          child: controller.openIndex.contains(2)
                              ? const RotatedBox(
                                  quarterTurns: 1,
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: ColorRes.black,
                                  ),
                                )
                              : const Icon(Icons.arrow_forward_ios),
                        ),
                        GeneralData(
                          index: 2,
                          isGeneral: false,
                          title: controller.list,
                          receipt: controller.responses?.data?.receipts,
                          openedIndex: controller.openIndex,
                          controller: controller,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: Dimens.padding),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              textAlign: TextAlign.start,
                              "Upload Documents",
                              style: kRegularThemeTextStyle.copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: ColorRes.mainButtonColor),
                            ),
                          ),
                        ),
                        7.ph,
                        Padding(
                          padding:EdgeInsets.symmetric(horizontal: Dimens.padding),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              textAlign: TextAlign.start,
                              "You can upload any documents that you need to share with your RM below",
                              style: kRegularThemeTextStyle.copyWith(
                                  fontSize: 16,
                                  color: ColorRes.hintColor,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(16),
                          alignment: Alignment.center,
                          height: 50,
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
                              borderRadius: BorderRadius.circular(Dimens.buttonRadius)),
                          child: ClipRRect(
                              borderRadius:BorderRadius.circular(Dimens.buttonRadius),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 15, left: 15),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: TextFormField(
                                        onTap: () {
                                          FocusScope.of(context).unfocus();
                                        },
                                        style: kRegularThemeTextStyle,
                                        controller: controller.documentName,
                                        decoration: InputDecoration(
                                            hintText: "Document name",
                                            border: InputBorder.none,
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
                        Container(
                          margin: const EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                            right: 16,
                            left: 16,
                          ),
                          alignment: Alignment.center,
                          height: 50,
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
                              borderRadius:
                                  BorderRadius.circular(Dimens.buttonRadius)),
                          child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(Dimens.buttonRadius),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 15, left: 15),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: TextFormField(
                                        onTap: () {
                                          FocusScope.of(context).unfocus();
                                        },
                                        style: kRegularThemeTextStyle,
                                        controller: controller.uploadDocument,
                                        decoration: InputDecoration(
                                            hintText: "Upload document",
                                            border: InputBorder.none,
                                            hintStyle:
                                                kRegularTextStyle.copyWith(
                                                    fontSize: 16,
                                                    color: ColorRes.hintColor,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        FocusScope.of(context).unfocus();
                                        controller.takeBook();
                                      },
                                      child: const Row(
                                        children: [Icon(Icons.attach_file)],
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        ),
                        25.ph,
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: Dimens.padding),
                          child: CustomGeneralButton(
                            onTab: () {
                              controller.postFile();
                            },
                            title: "Submit",
                          ),
                        ),
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

class GeneralData extends StatelessWidget {
  final List openedIndex;
  final int index;
  final bool isGeneral;
  final List<Documents>? documents;
  final List<String>? title;
  final Map? receipt;
  final DocumentController controller;

  const GeneralData({
    super.key,
    required this.openedIndex,
    required this.index,
    required this.isGeneral,
    required this.controller,
    this.documents,
    this.title,
    this.receipt,
  });

  @override
  Widget build(BuildContext context) {
    bool needOpen(List list, int index) {
      return list.contains(index);
    }

    return Visibility(
      visible: needOpen(openedIndex, index),
      child: Column(
        children: [
          isGeneral
              ? DocumentTileWidget(
                  onTap: () async {
                    controller.getDocuments();
                  },
                  title: "Account Statement",
                  detail: "",
                  child: const Icon(Icons.file_download_outlined,
                      color: ColorRes.mainButtonColor))
              : const SizedBox(),
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: isGeneral ? documents?.length : title?.length,
              itemBuilder: (context, index) {
                return DocumentTileWidget(
                    onTap: () async {
                      try {
                        Uri url = isGeneral
                            ? Uri.parse(documents![index].downloadLink ?? "")
                            : Uri.parse(DocumentsReceipts.fromJson(
                                        receipt?[title?[index]])
                                    .downloadLink ??
                                "");
                        if (await canLaunchUrl(url)) {
                          launchUrl(url);
                        } else {
                          customSnackBar('Download link not available');
                        }
                      } catch (e) {
                        customSnackBar('You cant download this file');
                      }
                    },
                    title: isGeneral
                        ? documents![index].checkListName ?? ""
                        : "Receipt No. ${title?[index]}",
                    detail: isGeneral
                        ? documents![index].date ?? ""
                        : DocumentsReceipts.fromJson(receipt?[title?[index]])
                                .eventName ??
                            "",
                    child: const Icon(Icons.file_download_outlined,
                        color: ColorRes.mainButtonColor));
              }),
        ],
      ),
    );
  }
}
