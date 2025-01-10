import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:marathon/controllers/home/payments/milestone/milestone_controller.dart';
import 'package:marathon/controllers/home/payments/payments_controller.dart';
import 'package:marathon/data/tools/decoration/style_res.dart';
import 'package:marathon/data/tools/extensions/num_ext.dart';
import 'package:marathon/domain/entities/ledge/receipt.dart';
import 'package:marathon/view/main_page/payments_page/milestone_page/make_payment/make_payment_page.dart';
import 'package:marathon/view/widgets/custom_general_button.dart';
import 'package:marathon/view/widgets/svg_view.dart';
import '../../../../data/tools/constants/app_assets.dart';
import '../../../../data/tools/decoration/res_colors.dart';
import '../../../widgets/common_whtasapp_button.dart';
import '../../home/drawer/drawer.dart';

class MileStonePage extends StatelessWidget {
  const MileStonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MileStoneController>(
        init: MileStoneController(),
        builder: (controller) {
          return Scaffold(
            key: controller.mainController.scaffoldKey,
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
              title: SvgPicture.asset(AppAssets.icon.marathonLogo,
                  // ignore: deprecated_member_use
                  color: Colors.white, width: 171, height: 22),
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
            body: GetBuilder<PaymentsController>(
                init: PaymentsController(Get.find(), Get.find()),
                builder: (paymentController) {
                  return paymentController.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              16.ph,
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
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
                                        //  "Amount(incl Taxes)",
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
                                                    color:
                                                        ColorRes.unPaidColor),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              for (int i = 0;
                                  i < controller.milestone.length;
                                  i++)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                  ),
                                  child: PaymentStatus(
                                      receiptId: takeIds(
                                          controller.milestone[i].receipts!),
                                      amount:
                                          "₹ ${controller.milestone[i].amount}",
                                      // status: controller.milestone[i].status == "Paid",
                                      status: controller.milestone[i].status!,
                                      open: () {
                                        controller.openTab(i);
                                      },
                                      date:
                                          "${controller.milestone[i].dueDate}",
                                      taxes:
                                          " ${controller.milestone[i].taxes}",
                                      towardsCost:
                                          " ${controller.milestone[i].apartmentCost ?? 0}",
                                      totalAmount:
                                          "${controller.milestone[i].amount ?? 0}",
                                      paidAmount: '${controller.milestone[i].status ?? 0}',
                                      pendingAmount:
                                          '${controller.milestone[i].outstandingAmt ?? 0}',
                                      receviedAmount: '${controller.milestone[i].recvAmt ?? 0}',
                                      receiptNumber: controller
                                              .milestone[i].receipts!.isNotEmpty
                                          ? '${controller.milestone[i].receipts?.first.receiptNo}'
                                          : "",
                                      titleStatus: controller
                                              .milestone[i].receipts!.isNotEmpty
                                          ? "${controller.milestone[i].receipts?.first.eventName}"
                                          : "${controller.milestone[i].eventName}",
                                      openedIndex: controller.openIndex,
                                      index: i,
                                      id: controller.milestone[i].milestoneId ??
                                          "0"),
                                ),
                              20.ph,
                              // commonBetaVersionEmail(),
                              // 20.ph,
                            ],
                          ),
                        );
                }),
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

class PaymentStatus extends StatelessWidget {
  final List receiptId;
  final List openedIndex;
  final String status;
  final int index;
  final String amount;
  final String titleStatus;
  final String date;
  final String towardsCost;
  final String taxes;
  final String totalAmount;
  final String paidAmount;
  final String pendingAmount;
  final String receviedAmount;
  final String receiptNumber;
  final Function open;
  final String id;
  PaymentStatus({
    super.key,
    required this.status,
    required this.amount,
    required this.date,
    required this.towardsCost,
    required this.taxes,
    required this.totalAmount,
    required this.paidAmount,
    required this.pendingAmount,
    required this.receviedAmount,
    required this.receiptNumber,
    required this.open,
    required this.titleStatus,
    required this.openedIndex,
    required this.index,
    required this.id,
    required this.receiptId,
  });

  final PaymentsController paymentsController = Get.find();

  @override
  Widget build(BuildContext context) {
    bool needOpen(List list, int index) {
      if (list.contains(index)) {
        return true;
      } else {
        return false;
      }
    }

    return Column(
      children: [
        const Divider(),
        GestureDetector(
          onTap: () {
            open();
          },
          child: Row(
            children: [
              SizedBox(
                width: Get.width / 3,
                child: Text(
                  titleStatus,
                  style: kRegularThemeTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: status == "Not due yet"
                          ? ColorRes.greyTextColor
                          : ColorRes.mainTextColor),
                  //kRegularTextStyle.copyWith(color: ColorRes.black),
                ),
              ),
              10.pw,
              Expanded(
                child: Text(
                  amount,
                  style: kRegularThemeTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: status == "Not due yet"
                          ? ColorRes.greyTextColor
                          : ColorRes.mainTextColor),
                  //kRegularTextStyle,
                ),
              ),
              SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    7.pw,
                    Flexible(
                      child: Text(
                        maxLines: 1,
                        paidAmount,
                        style: kRegularWhiteTextStyle.copyWith(
                            fontSize: 12.5,
                            color: status == "Paid"
                                ? ColorRes.paidColor
                                : ColorRes.unPaidColor),
                      ),
                    ),
                    2.pw,
                    SvgView(
                        height: 16,
                        width: 16,
                        imageUrl: needOpen(openedIndex, index)
                            ? AppAssets.icon.sideDrop
                            : AppAssets.icon.bottomDrop),
                  ],
                ),
              )
            ],
          ),
        ),
        Visibility(
          visible: needOpen(openedIndex, index),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(vertical: 10),
            width: Get.width,
            decoration: const BoxDecoration(
              color: ColorRes.greyF1,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    "Due Date:$date",
                    style: kRegularTextStyle.copyWith(fontSize: 14),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.012),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    "Due Amount (in Rs.)",
                    style: kBoldThemeTextStyle.copyWith(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Towards Apartment cost",
                        style: kRegularTextStyle.copyWith(fontSize: 14),
                      ),
                      Text(
                        towardsCost,
                        style: kRegularTextStyle.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Taxes",
                        style: kRegularTextStyle.copyWith(fontSize: 14),
                      ),
                      Text(
                        taxes,
                        style: kRegularTextStyle.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "",
                        style: kRegularTextStyle.copyWith(fontSize: 14),
                      ),
                      Text(
                        totalAmount,
                        style: kRegularTextStyle.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    "Paid Amount (in Rs.)",
                    style: kBoldThemeTextStyle.copyWith(fontSize: 16),
                  ),
                ),
                ListView.builder(
                  itemCount: receiptId.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        paymentsController.getReceipt(
                            receiptId[index] ?? "", id);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "Receipt No. ${receiptId[index]}",
                          style: kRegularTextStyle.copyWith(
                              fontSize: 14,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    );
                  },
                ),
                status == "Partially Paid" ? const Divider() : const SizedBox(),
                status == "Partially Paid"
                    ? Padding(
                      padding:const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children:[
                            Text(
                              double.parse(receviedAmount.toString()).toStringAsFixed(2),
                              style: kRegularTextStyle.copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                    )
                    :const SizedBox(),
                status == "Partially Paid"? const SizedBox(height: 10): const SizedBox(),
                const Divider(),
                Padding(
                  padding:const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Flexible(
                        child: pendingAmount == ".00"
                            ? const SizedBox()
                            : Text(
                                "Pending Amount(in Rs): $pendingAmount",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: kRegularTextStyle.copyWith(fontSize: 14),
                              ),
                      ),
                      status == "Paid"
                          ? Text(
                              totalAmount,
                              style: kRegularTextStyle.copyWith(fontSize: 14),
                            )
                          : status == "Partially Paid"
                              ? CustomGeneralButton(
                                  onTab: () {
                                    Get.to(
                                        () => MakePaymentPage(
                                              receiptId: receiptId,
                                            ),
                                        arguments: {
                                          "due_amount": totalAmount,
                                          "milestone_id": id,
                                          'receipt_ids': receiptId
                                        });
                                  },
                                  title: "Pay Now",
                                  // verticalPadding: 5,
                                  //fontSize: 12,
                                  // horizontalPadding: 25,
                                )
                              : const SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
