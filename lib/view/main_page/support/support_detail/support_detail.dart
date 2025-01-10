import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:marathon/data/tools/extensions/num_ext.dart';
import 'package:marathon/view/main_page/home/drawer/drawer.dart';
import '../../../../controllers/support_controller/support_controller.dart';
import '../../../../data/tools/constants/app_assets.dart';
import '../../../../data/tools/decoration/dimens.dart';
import '../../../../data/tools/decoration/res_colors.dart';
import '../../../../data/tools/decoration/style_res.dart';
import '../../../widgets/common_whtasapp_button.dart';

class SupportDetailPage extends StatelessWidget {
  SupportDetailPage({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      floatingActionButton:commonFloatingActionButton(),
      endDrawer: const Drawer(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0),
          bottomLeft: Radius.circular(0),
        )),
        child: HomeDrawer(),
      ),
      onEndDrawerChanged: (isOpened) {
        if (!isOpened) {
          WidgetsBinding.instance.addPostFrameCallback(
            (timeStamp) => Get.back(),
          );
        }
      },
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
        actions: [
          IconButton(
              onPressed: () {
                scaffoldKey.currentState!.openEndDrawer();
              },
              icon: const Icon(
                Icons.account_circle_outlined,
                color: ColorRes.white,
              ))
        ],
      ),
      body: GetBuilder(
          init: SupportController(Get.find(), Get.find()),
          builder: (controller) {
            return controller.isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: ColorRes.mainButtonColor,
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      10.ph,
                      SizedBox(
                        height: 40,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  "${Get.arguments['name']}",
                                  maxLines: 2,
                                  style: kRegularThemeTextStyle.copyWith(
                                      color: ColorRes.mainButtonColor,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15.0),
                                child: GestureDetector(
                                    onTap: () {},
                                    child: const Icon(
                                      Icons.minimize,
                                      color: ColorRes.unPaidColor,
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                      const Divider(),
                      Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.faqData.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Dimens.padding,
                                        vertical: 10),
                                    //height: 50,
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
                      )
                    ],
                  );
          }),
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
    return Padding(
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
                //overflow: TextOverflow.ellipsis,
                title,
                maxLines: 5,
                style: kRegularThemeTextStyle.copyWith(color: ColorRes.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 0.0),
              child: GestureDetector(
                  onTap: () {
                    onTap();
                  },
                  child: child
                  // const Icon(
                  //   Icons.arrow_forward_ios,
                  //   color: ColorRes.black,
                  // )
                  ),
            )
          ],
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
      if (list.contains(index)) {
        return true;
      } else {
        return false;
      }
    }

    String cleanedContent = _cleanHtmlContent(content);

    return Visibility(
      visible: needOpen(openedIndex!, index!),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          // height: 256,
          padding: const EdgeInsets.only(bottom: 20),
          width: Get.width,
          decoration: const BoxDecoration(
            color: ColorRes.greyF1,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.ph,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Html(data: cleanedContent, style: {
                  "body": Style(
                    color: ColorRes.black,
                    fontFamily: AppFonts.fnproximanovaRegular,
                    fontSize: FontSize(14),
                  ),
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
