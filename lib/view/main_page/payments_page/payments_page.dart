import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marathon/controllers/home/payments/payments_controller.dart';
import 'package:marathon/data/tools/extensions/num_ext.dart';
import 'package:marathon/domain/entities/ledge/receipt.dart';
import 'package:marathon/view/main_page/payments_page/milestone_page/milestone_page.dart';
import 'package:marathon/view/widgets/custom_general_button.dart';
import '../../../data/tools/decoration/dimens.dart';
import '../../../data/tools/decoration/res_colors.dart';
import '../../../data/tools/decoration/style_res.dart';


class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return GetBuilder<PaymentsController>(
        init: PaymentsController(Get.find(), Get.find()),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              body: controller.isLoading
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        controller.loadingText != "" ? Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: Text(
                            controller.loadingText,
                            textAlign: TextAlign.center,
                          ),
                        ) : SizedBox()
                      ],
                    )
                  : SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          10.ph,
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: Dimens.padding),
                            child: Text(
                              textAlign: TextAlign.start,
                              "Overview",
                              style: kRegularThemeTextStyle.copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: ColorRes.unPaidColor),
                            ),
                          ),
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: w * 0.05, vertical: h * 0.03),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  OverViewDetail(
                                    title: "Flat :",
                                    description: controller.ledgerDetailsResponse
                                            ?.data?.details?.flatNo ??
                                        "",
                                  ),
                                  10.ph,
                                  OverViewDetail(
                                    title: "Property Owners :",
                                    description:
                                        "${controller.ledgerDetailsResponse?.data?.details?.custFirstName ?? ""} ${controller.ledgerDetailsResponse?.data?.details?.custLastName ?? ""}",
                                  ),
                                  10.ph,
                                  OverViewDetail(
                                    title: "Purchase Date :",
                                    description: controller.ledgerDetailsResponse
                                            ?.data?.details?.bookingDate ??
                                        "",
                                  ),
                                  10.ph,
                                  OverViewDetail(
                                    title: "Agreement Date :",
                                    description: controller
                                                .ledgerDetailsResponse
                                                ?.data
                                                ?.details
                                                ?.aggrementDate
                                                ?.isNotEmpty ??
                                            true
                                        ? controller.ledgerDetailsResponse!.data!
                                                .details!.aggrementDate!
                                                .contains("1900")
                                            ? "Not registered"
                                            : controller
                                                    .ledgerDetailsResponse
                                                    ?.data
                                                    ?.details
                                                    ?.aggrementDate ??
                                                ""
                                        : "",
                                  ),
                                  10.ph,
                                  OverViewDetail(
                                    title: "Carpet Area :",
                                    description:
                                        "${double.parse(controller.ledgerDetailsResponse?.data?.details?.carpetAreaRera ?? "0").toStringAsFixed(2)} sq.ft. ",
                                  ),
                                ],
                              ),
                            ),
                          ),
                          10.ph,
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: Dimens.padding),
                            child: Text(
                              textAlign: TextAlign.start,
                              "Account Summary",
                              style: kRegularThemeTextStyle.copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: ColorRes.unPaidColor),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: Dimens.padding),
                            child: Text(
                              textAlign: TextAlign.start,
                              "Click on any milestone to view detailed breakup of cost, demand letter and receipt",
                              style: kRegularThemeTextStyle.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: ColorRes.mainTextColor),
                            ),
                          ),
                          10.ph,
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: Dimens.padding),
                            child: Text(
                              textAlign: TextAlign.start,
                              "For a more detailed summary download the account statement for your apartment.",
                              style: kRegularThemeTextStyle.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: ColorRes.mainTextColor),
                            ),
                          ),
                          10.ph,
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: Dimens.padding),
                            child: CustomGeneralButton(
                              onTab: () {
                                controller.getDocuments();
                              },
                              title: "Download Statement",
                              // fontSize: 14,
                              // horizontalPadding: 30,
                              //fontSize: MediaQuery.of(context).size.width * 0.033,
                            ),
                          ),
                          10.ph,
            
                          10.ph,
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: Dimens.padding),
                            child: CustomGeneralButton(
                              onTab: () {
                                controller.sendEmailStatement();
                              },
                              title: "Email Statement",
                              // fontSize: 14,
                              // horizontalPadding: 30,
                              //fontSize: MediaQuery.of(context).size.width * 0.033,
                            ),
                          ),
                          10.ph,
            
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            width: Get.width,
                            child: const Text(
                              "Please note that payment details will reflect on the web portal or mobile app within 24 to 48 hours after the amount is realized in our account.",
                              style: TextStyle(
                                color: ColorRes.greyTextColor,
                                fontSize: 12
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          10.ph,
            
                          Column(
                            children: [
                              16.ph,
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 130,
                                      child: Text(
                                        "Milestone*",
                                        style: kRegularThemeTextStyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: ColorRes.unPaidColor),
                                      ),
                                    ),
                                    10.pw,
                                    Expanded(
                                      child: Text(
                                       // "Amount(incl Taxes)",
                                        "Amount",
                                        style: kRegularThemeTextStyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: ColorRes.unPaidColor),
                                      ),
                                    ),
                                    10.pw,
                                    SizedBox(
                                      width: 80,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Status",
                                            style:
                                                kRegularThemeTextStyle.copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: ColorRes.unPaidColor),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              for (int i = 0;
                                  i <
                                      (controller.ledgerDetailsResponse?.data
                                              ?.milestones?.length ??
                                          0);
                                  i++)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: PaymentStatus(
                                      receiptId: takeIds(controller
                                          .ledgerDetailsResponse
                                          ?.data
                                          ?.milestones?[i]
                                          .receipts),
                                      amount:
                                          "₹ ${controller.ledgerDetailsResponse?.data?.milestones?[i].amount}",
                                      status: controller.ledgerDetailsResponse?.data?.milestones?[i].status ??
                                          "",
                                      open: () {
                                        controller.openTab(i);
                                      },
                                      date:
                                          "${controller.ledgerDetailsResponse?.data?.milestones?[i].dueDate}",
                                      taxes:
                                          " ${controller.ledgerDetailsResponse?.data?.milestones?[i].taxes}",
                                      towardsCost:
                                          " ${controller.ledgerDetailsResponse?.data?.milestones?[i].apartmentCost ?? 0}",
                                      totalAmount:
                                          "${controller.ledgerDetailsResponse?.data?.milestones?[i].amount ?? 0}",
                                      paidAmount:
                                          '${controller.ledgerDetailsResponse?.data?.milestones?[i].status ?? 0}',
                                      pendingAmount:
                                          '${controller.ledgerDetailsResponse?.data?.milestones?[i].outstandingAmt ?? 0}',
                                      receviedAmount:'${controller.ledgerDetailsResponse?.data?.milestones?[i].recvAmt ?? 0}',
                                      receiptNumber: controller
                                                      .ledgerDetailsResponse
                                                      ?.data
                                                      ?.milestones?[i]
                                                      .receipts !=
                                                  null &&
                                              controller
                                                  .ledgerDetailsResponse!
                                                  .data!
                                                  .milestones![i]
                                                  .receipts!
                                                  .isNotEmpty
                                          ? '${controller.ledgerDetailsResponse?.data?.milestones?[i].receipts?.first.receiptId}'
                                          : "",
                                      titleStatus: controller.ledgerDetailsResponse?.data?.milestones?[i].receipts != null &&
                                              controller
                                                  .ledgerDetailsResponse!
                                                  .data!
                                                  .milestones![i]
                                                  .receipts!
                                                  .isNotEmpty
                                          ? "${controller.ledgerDetailsResponse?.data?.milestones?[i].receipts?.first.eventName}"
                                          : "${controller.ledgerDetailsResponse?.data?.milestones?[i].eventName}",
                                      openedIndex: controller.openIndex,
                                      index: i,
                                      id: controller.ledgerDetailsResponse?.data?.milestones?[i].milestoneId ?? "0"),
                                ),
                              20.ph,
                              // commonBetaVersionEmail(),
                              // 20.ph,
                            ],
                          ),
                          /*   Container(
                            margin: EdgeInsets.all(Dimens.padding),
                            // height: 390,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: ColorRes.greyD3,
                                    spreadRadius: 1,
                                    blurRadius: 0,
                                    offset: Offset(
                                        0, 1.5), // changes position of shadow
                                  ),
                                ],
                                color: ColorRes.listItemColors,
                                borderRadius: BorderRadius.circular(30)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    textAlign: TextAlign.start,
                                    "Milestone*",
                                    style: kRegularThemeTextStyle.copyWith(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: ColorRes.mainTextColor),
                                  ),
                                  for (int i = 0; i < controller.l; i++)
                                    MilestoneDetails(
                                      title: controller.ledgerDetailsResponse
                                              ?.data?.milestones?[i].eventName ??
                                          "",
                                      onTab: () {
                                        Get.to(() => const MileStonePage(),
                                            arguments: controller
                                                .ledgerDetailsResponse
                                                ?.data
                                                ?.milestones);
                                      },
                                    ),
            
                                  // MilestoneDetails(
                                  //   title: 'Booking Amount',
                                  //   onTab: () {},
                                  // ),
                                  // MilestoneDetails(
                                  //   title: 'On Completion of Plinth',
                                  //   onTab: () {},
                                  // ),
                                  // MilestoneDetails(
                                  //   title: 'On Completion of 3rd Slab',
                                  //   onTab: () {},
                                  // ),
                                  10.ph,
                                  Visibility(
                                    visible: controller.loadMore,
                                    child: GestureDetector(
                                      onTap: () {
                                        controller.tabToMore();
                                      },
                                      child: Text(
                                        "Load More",
                                        style: kRegularTextStyle.copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            color: ColorRes.black),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),*/
            
                        ],
                      ),
                    ),
            ),
          );
        });
  }

  List takeIds(List<Receipt>? list) {
    List<String> ids = [];
    int l = list?.length ?? 0;
    for (int i = 0; i < l; i++) {
      ids.add(list?[i].receiptId ?? "");
    }

    return ids;
  }
}

class MilestoneDetails extends StatelessWidget {
  final String title;
  final Function onTab;

  const MilestoneDetails({
    super.key,
    required this.title,
    required this.onTab,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
          color: ColorRes.white,
          borderRadius: BorderRadius.circular(Dimens.buttonRadius)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                maxLines: 2,
                textAlign: TextAlign.start,
                title,
                style: kRegularThemeTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: ColorRes.mainTextColor),
              ),
            ),
            CustomGeneralButton(
              onTab: () {
                onTab();
              },
              title: "View",
              //fontSize: 16,
            ),
          ],
        ),
      ),
    );
  }
}

class OverViewDetail extends StatelessWidget {
  final String title;
  final String description;

  const OverViewDetail({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          "$title  ",
          style: kRegularThemeTextStyle.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: ColorRes.mainTextColor),
        ),
        Flexible(
          child: Text(
            textAlign: TextAlign.end,
            // overflow: TextOverflow.ellipsis,
            description,
            style: kRegularThemeTextStyle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: ColorRes.mainTextColor),
          ),
        ),
      ],
    );
  }
}
