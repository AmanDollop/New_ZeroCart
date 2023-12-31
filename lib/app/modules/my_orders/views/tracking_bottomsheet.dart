import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:zerocart/app/constant/zconstant.dart';
import 'package:zerocart/my_responsive_sizer/src/extension.dart';
import 'package:zerocart/app/common_widgets/common_widgets.dart';
import 'package:zerocart/app/modules/my_orders/controllers/my_orders_controller.dart';
import 'package:zerocart/my_colors/my_colors.dart';

class TrackingBottomSheet extends GetView<MyOrdersController> {
  String orderPlaceDate;
  String orderNo;
  TrackingBottomSheet({super.key,required this.orderPlaceDate,required this.orderNo,});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      padding: EdgeInsets.only(right: 10.px,left: 10.px,bottom: 10.px),
      children: [
        // Padding(
        //   padding: EdgeInsets.symmetric(
        //     horizontal: 7.w,
        //   ),
        //   child: Column(
        //     children: [
        //       SizedBox(height: Zconstant.margin16 / 3),
        //       /* Center(
        //         child: FractionallySizedBox(
        //           widthFactor: 0.20.px,
        //           child: Container(
        //             margin: EdgeInsets.symmetric(
        //               vertical: 8.px,
        //             ),
        //             child: Container(
        //               height: 3.5.px,
        //               decoration: BoxDecoration(
        //                 color: MyColorsLight().dashMenuColor,
        //                 borderRadius: BorderRadius.all(Radius.circular(2.5.px)),
        //               ),
        //             ),
        //           ),
        //         ),
        //       )*/
        //       Center(
        //         child: FractionallySizedBox(
        //           widthFactor: 0.1.px,
        //           child: Container(
        //             margin: EdgeInsets.symmetric(
        //               vertical: 8.px,
        //             ),
        //             child: Container(
        //               height: 3.5.px,
        //               decoration: BoxDecoration(
        //                 color: MyColorsLight().onPrimary,
        //                 borderRadius: BorderRadius.all(Radius.circular(2.5.px)),
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //       /*SizedBox(height: 1.75.h),
        //       Container(
        //         width: 25.w,
        //         height: 4,
        //         decoration: BoxDecoration(
        //             color: Colors.grey,
        //             borderRadius: BorderRadius.circular(4.px)),
        //       ),*/
        //       SizedBox(height: 1.75.h),
        //       Row(
        //         children: [
        //           trackOrderTextView(),
        //         ],
        //       ),
        //       SizedBox(height: 1.h),
        //       Row(
        //         children: [
        //           Stack(
        //             alignment: Alignment.topCenter,
        //             children: [
        //               Padding(
        //                 padding: EdgeInsets.only(top: 4.h),
        //                 child: dottedLineTextView(),
        //               ),
        //               SizedBox(
        //                 height: controller.currentTrackStep.value > 2 ? 36.h : 34.h,
        //                 child: stepProgressIndicatorView(),
        //               ),
        //             ],
        //           ),
        //           SizedBox(width: 5.w),
        //           Expanded(
        //             child: Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 Row(
        //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                   children: [
        //                     Column(
        //                       crossAxisAlignment: CrossAxisAlignment.start,
        //                       children: [
        //                         orderHeadingTextVIew(
        //                             text: "Order Confirmed", id: 1),
        //                         if (controller.currentTrackStep.value >= 1)
        //                           orderDescriptionTextView(
        //                               text: "Your Order Has Been Confirmed")
        //                       ],
        //                     ),
        //                     if (controller.currentTrackStep.value >= 1)
        //                       Column(
        //                         crossAxisAlignment: CrossAxisAlignment.end,
        //                         children: [
        //                           orderTimeTextView(text: "1:45AM"),
        //                           SizedBox(height: 1.px),
        //                           orderDateTextView(text: "12-07-2022"),
        //                         ],
        //                       )
        //                   ],
        //                 ),
        //                 controller.currentTrackStep.value >= 2
        //                     ? SizedBox(height: 3.5.h)
        //                     : SizedBox(height: 3.h),
        //                 Row(
        //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                   children: [
        //                     Column(
        //                       crossAxisAlignment: CrossAxisAlignment.start,
        //                       children: [
        //                         orderHeadingTextVIew(
        //                             text: "Order Shipped", id: 2),
        //                         if (controller.currentTrackStep.value >= 2)
        //                           orderDescriptionTextView(
        //                               text: "Your Order Has Been Shipped")
        //                       ],
        //                     ),
        //                     if (controller.currentTrackStep.value >= 2)
        //                       Column(
        //                         crossAxisAlignment: CrossAxisAlignment.end,
        //                         children: [
        //                           orderTimeTextView(text: "1:45AM"),
        //                           SizedBox(height: 1.px),
        //                           orderDateTextView(text: "12-07-2022"),
        //                         ],
        //                       )
        //                   ],
        //                 ),
        //                 controller.currentTrackStep.value >= 3
        //                     ? SizedBox(height: 3.5.h)
        //                     : SizedBox(
        //                         height: controller.currentTrackStep.value >= 2
        //                             ? 3.5.h
        //                             : 5.3.h),
        //                 Row(
        //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                   children: [
        //                     Column(
        //                       crossAxisAlignment: CrossAxisAlignment.start,
        //                       children: [
        //                         orderHeadingTextVIew(
        //                             text: "Out For Delivery", id: 3),
        //                         if (controller.currentTrackStep.value >= 3)
        //                           orderDescriptionTextView(
        //                               text:
        //                                   "Your Order Has Been Out For Delivery")
        //                       ],
        //                     ),
        //                     if (controller.currentTrackStep.value >= 3)
        //                       Column(
        //                         crossAxisAlignment: CrossAxisAlignment.end,
        //                         children: [
        //                           orderTimeTextView(text: "1:45AM"),
        //                           SizedBox(height: 1.px),
        //                           orderDateTextView(text: "12-07-2022"),
        //                         ],
        //                       ),
        //                   ],
        //                 ),
        //                 controller.currentTrackStep.value >= 4
        //                     ? SizedBox(height: 3.5.h)
        //                     : SizedBox(height: 5.7.h),
        //                 Row(
        //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                   children: [
        //                     Column(
        //                       crossAxisAlignment: CrossAxisAlignment.start,
        //                       children: [
        //                         orderHeadingTextVIew(
        //                             text: "Order Delivered", id: 4),
        //                         if (controller.currentTrackStep.value >= 4)
        //                           orderDescriptionTextView(
        //                               text: "Your Order Has Been Delivered")
        //                       ],
        //                     ),
        //                     if (controller.currentTrackStep.value >= 4)
        //                       Column(
        //                         crossAxisAlignment: CrossAxisAlignment.start,
        //                         children: [
        //                           orderTimeTextView(text: "1:45AM"),
        //                           SizedBox(height: 1.px),
        //                           orderDateTextView(text: "12-07-2022"),
        //                         ],
        //                       ),
        //                   ],
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),
        // )
        SizedBox(height: Zconstant.margin16/3 ),
        Center(
          child: FractionallySizedBox(
            widthFactor: 0.1.px,
            child: Container(
              margin: EdgeInsets.symmetric(
                vertical: 8.px,
              ),
              child: Container(
                height: 3.5.px,
                decoration: BoxDecoration(
                  color: MyColorsLight().onPrimary,
                  borderRadius: BorderRadius.all(Radius.circular(2.5.px)),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 5.px),
        Text('Order Tracking',style: Theme.of(Get.context!).textTheme.subtitle1?.copyWith(fontSize: 18.px),textAlign: TextAlign.center),
        SizedBox(height: 10.px),
        Text('Order Placed On -: $orderPlaceDate',style: Theme.of(Get.context!).textTheme.subtitle1?.copyWith(fontSize: 12.px)),
        SizedBox(height: 5.px),
        Text('Order No.-: $orderNo',style: Theme.of(Get.context!).textTheme.subtitle1?.copyWith(fontSize: 12.px)),
        SizedBox(height: 10.px),
        ListView.builder(
          padding: EdgeInsets.all(8.px),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 2,
          shrinkWrap: true,
          itemBuilder: (context, firstIndex) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Date -: 22 Nov 2023',
                  style: Theme.of(Get.context!)
                      .textTheme
                      .subtitle1
                      ?.copyWith(fontSize: 14.px),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  padding: EdgeInsets.symmetric(vertical: 10.px,horizontal: 4.px),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 8.px),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              '9:20 AM',
                              style: Theme.of(Get.context!).textTheme.subtitle1?.copyWith(fontSize: 12.px),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                            height: 25.px,
                            child: VerticalDivider(color: Colors.grey, width: 2.px,thickness: 1.px),
                          ),
                          SizedBox(width: 10.px),
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Title',
                                  style: Theme.of(Get.context!)
                                      .textTheme
                                      .subtitle1
                                      ?.copyWith(fontSize: 10.px),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  'Sub Title',
                                  style: Theme.of(Get.context!)
                                      .textTheme
                                      .subtitle1
                                      ?.copyWith(fontSize: 8.px),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            );
          },
        )
      ],
    );
  }

  Widget trackOrderTextView() => Text("Track Order",
      style: Theme.of(Get.context!)
          .textTheme
          .bodyText1
          ?.copyWith(color: MyColorsDark().secondary));

  Widget dottedLineTextView() => DottedLine(
        direction: Axis.vertical,
        lineLength: controller.currentTrackStep.value > 2 ? 27.h : 25.h,
        lineThickness: 0.8,
        dashLength: 2.0,
        dashColor: MyColorsDark().textGrayColor,
        dashGapLength: 2.3,
        dashGapColor: Colors.transparent,
      );

  Widget stepProgressIndicatorView() => StepProgressIndicator(
        direction: Axis.vertical,
        totalSteps: controller.totalTrackStep.value,
        currentStep: controller.currentTrackStep.value,
        size: 18,
        selectedColor: Colors.transparent,
        customStep: (index, color, _) => color == Colors.transparent
            ? Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: CommonWidgets.commonLinearGradientView(),
                ),
              )
            : Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: /*Theme.of(Get.context!).brightness == Brightness.dark
                      ? MyColorsDark().secondary.withOpacity(0.7)
                      : MyColorsDark().secondary,*/
                      MyColorsLight().card,
                ),
              ),
      );

  Widget orderHeadingTextVIew({required String text, required int id}) => Text(
      text,
      style: id <= controller.currentTrackStep.value
          ? Theme.of(Get.context!)
              .textTheme
              .subtitle1
              ?.copyWith(color: MyColorsDark().secondary)
          : Theme.of(Get.context!)
              .textTheme
              .subtitle1
              ?.copyWith(color: const Color.fromRGBO(0, 0, 0, 0.6)));

  Widget orderDescriptionTextView({required String text}) => Text(text,
      style: Theme.of(Get.context!)
          .textTheme
          .headline3
          ?.copyWith(color: MyColorsDark().secondary));

  Widget orderTimeTextView({required String text}) => Text(text,
      style: Theme.of(Get.context!)
          .textTheme
          .headlineLarge
          ?.copyWith(color: MyColorsDark().secondary));

  Widget orderDateTextView({required String text}) => Text(text,
      style: Theme.of(Get.context!)
          .textTheme
          .headlineLarge
          ?.copyWith(color: MyColorsDark().secondary));
}
