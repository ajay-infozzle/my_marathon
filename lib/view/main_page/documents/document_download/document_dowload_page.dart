import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:marathon/data/tools/toast/custom_snackbar.dart';
import 'package:marathon/domain/entities/documents/documents_receipts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../controllers/mainController/main_controller.dart';
import '../../../../data/tools/constants/app_assets.dart';
import '../../../../data/tools/decoration/res_colors.dart';
import '../../../../domain/entities/documents/documents.dart';
import '../../../widgets/common_whtasapp_button.dart';
import '../../home/drawer/drawer.dart';
import '../widgets/document_tile.dart';

class DocumentDownloadPage extends StatelessWidget {
  final MainController mainController = MainController();
  final bool isGeneral;
  final List<String> documentTitles = [
    "Account Statement",
    "Bank ROC",
    "Builder NOC",
    "Loan Sanction Letter",
    "Registeration Slip",
    "Sales Deed"
  ];
  final List<Documents>? documents;
  final List<String>? title;
  final Map? receipt;

  DocumentDownloadPage(
      {super.key,
      required this.isGeneral,
      this.documents,
      this.receipt,
      this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: mainController.scaffoldKey,
      floatingActionButton: commonFloatingActionButton(),
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
        // ignore: deprecated_member_use
        title: SvgPicture.asset(AppAssets.icon.marathonLogo,color: Colors.white,width: 171,height: 22),
        // Image(
        //   image: AssetImage(AppAssets.images.logoMarathon),
        //   width: 171,
        // ),
        actions:[
          IconButton(
              onPressed: () {
                mainController.scaffoldKey.currentState?.openEndDrawer();
              },
              icon: const Icon(
                Icons.account_circle_outlined,
                color: ColorRes.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DocumentTileWidget(
              onTap: () {},
              title: isGeneral ? 'General' : "Receipts",
              isTitle: true,
              child: const Icon(Icons.keyboard_arrow_down_rounded),
            ),
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
                })
          ],
        ),
      ),
    );
  }
}
