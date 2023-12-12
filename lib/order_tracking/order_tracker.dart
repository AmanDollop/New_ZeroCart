library order_tracker;

import 'package:flutter/material.dart';
import 'package:zerocart/my_responsive_sizer/src/extension.dart';

class OrderTracker extends StatefulWidget {
  ///This variable is used to set status of order, this get only enum which is already in a package below example present.
  /// Status.order
  final Status? status;

  /// This variable is used to get list of firstList sub title and date to show present status of product.
  final List<TextDto>? firstList;

  /// This variable is used to get list of secondList sub title and date to show present status of product.
  final List<TextDto>? secondList;

  /// This variable is used to get list of thirdList sub title and date to show present status of product.
  final List<TextDto>? thirdList;

  /// This variable is used to get list of delivered sub title and date to show present status of product.
//  final List<TextDto>? deliveredTitleAndDateList;

  /// This variable is used to change color of active animation border.
  final Color? activeColor;

  /// This variable is used to change color of inactive animation border.
  final Color? inActiveColor;

  /// This variable is used to change style of heading title text.
  final TextStyle? headingTitleStyle;

  /// This variable is used to change style of heading date text.
  final TextStyle? headingDateTextStyle;

  /// This variable is used to change style of sub title text.
  final TextStyle? subTitleTextStyle;

  /// This variable is used to change style of sub date text.
  final TextStyle? subDateTextStyle;

  /// This variable is used to get name of first list name
  final String? firstListName;

  /// This variable is used to get name of second list name
  final String? secondListName;

  /// This variable is used to get name of third list name
  final String? thirdListName;

  const OrderTracker({
    Key? key,
    required this.status,
    this.firstList,
    this.secondList,
    this.thirdList,
//  this.deliveredTitleAndDateList,
    this.activeColor,
    this.inActiveColor,
    this.headingTitleStyle,
    this.headingDateTextStyle,
    this.subTitleTextStyle,
    this.subDateTextStyle,
    this.firstListName,
    this.secondListName,
    this.thirdListName,
  }) : super(key: key);

  @override
  State<OrderTracker> createState() => _OrderTrackerState();
}

class _OrderTrackerState extends State<OrderTracker>
    with TickerProviderStateMixin {
  ///This is first animation progress bar controller.
  AnimationController? controller;

  ///This is second animation progress bar controller.
  AnimationController? controller2;

  ///This is third animation progress bar controller.
  AnimationController? controller3;

  ///This is conditional variable.
  bool isFirst = false;
  bool isSecond = false;
  bool isThird = false;

  @override
  void initState() {
    if (widget.status?.name == Status.firstList.name) {
      ///initialize first controller
      controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2),
      )..addListener(() {
        if (controller?.value != null && controller!.value > 0.99) {
          controller?.stop();
        }
        setState(() {});
      });
    } else if (widget.status?.name == Status.secondList.name) {
      ///initialize first controller
      controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2),
      )..addListener(() {
        if (controller?.value != null && controller!.value > 0.99) {
          controller?.stop();
          controller2?.stop();
          isFirst = true;
          controller2?.forward(from: 0.0);
        }
        setState(() {});
      });

      ///initialize second controller
      controller2 = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2),
      )..addListener(() {
        if (controller2?.value != null && controller2!.value > 0.99) {
          controller2?.stop();
          controller3?.stop();
          isSecond = true;
          controller3?.forward(from: 0.0);
        }
        setState(() {});
      });
    } else if (widget.status?.name == Status.thirdList.name) {
      ///initialize first controller
      controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2),
      )..addListener(() {
        if (controller?.value != null && controller!.value > 0.99) {
          controller?.stop();
          controller2?.stop();
          controller3?.stop();
          isFirst = true;
          controller2?.forward(from: 0.0);
        }
        setState(() {});
      });

      ///initialize second controller
      controller2 = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2),
      )..addListener(() {
        if (controller2?.value != null && controller2!.value > 0.99) {
          controller2?.stop();
          controller3?.stop();
          isSecond = true;
          controller3?.forward(from: 0.0);
        }
        setState(() {});
      });

      ///initialize third controller
      /*  controller3 = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2),
      )..addListener(() {
          if (controller3?.value != null && controller3!.value > 0.99) {
            controller3?.stop();
            isThird = true;
          }
          setState(() {});
        });*/
    }

    controller?.repeat(reverse: false);
    controller2?.repeat(reverse: false);
    controller3?.repeat(reverse: false);
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    controller2?.dispose();
    controller3?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 3.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 15.px,
                    width: 15.px,
                    decoration: BoxDecoration(
                      color: widget.activeColor ?? Colors.green,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: widget.firstListName ?? "Order Placed ",
                              style:widget.headingTitleStyle ?? TextStyle(color: Colors.black,fontSize: 16.px,fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 1.8.w),
                    child: SizedBox(
                      width: 0.60.w,
                      height: widget.firstList != null &&
                          widget.firstList!.isNotEmpty
                          ? widget.firstList!.length * 44
                          : 40,
                      child: RotatedBox(
                        quarterTurns: 5,
                        child: LinearProgressIndicator(
                          value: controller?.value ?? 0.0,
                          backgroundColor: widget.inActiveColor ?? Colors.white,
                          color: widget.activeColor ?? Colors.green,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 4.4.w,
                  ),
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.firstList?[index].title ?? "",
                                style: widget.subTitleTextStyle ?? Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 14.px, fontWeight: FontWeight.w500),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              Text(
                                widget.firstList?[index].date ?? "",
                                style: widget.subDateTextStyle ?? const TextStyle(fontSize: 12, color: Colors.black),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1
                              )
                            ],
                          );
                        },
                        itemCount: widget.firstList != null &&
                            widget.firstList!.isNotEmpty
                            ? widget.firstList!.length
                            : 0),
                  )
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        height: 15.px,
                        width: 15.px,
                        decoration: BoxDecoration(
                            color: (widget.status?.name == Status.secondList.name ||
                                widget.status?.name ==
                                    Status.thirdList.name) &&
                                isFirst == true
                                ? widget.activeColor ??Colors.green
                                : widget.inActiveColor ?? Colors.grey[300],
                            borderRadius: BorderRadius.circular(50)),
                      ),
                    ],
                  ),
                  SizedBox(
                      width: 3.w
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: widget.secondListName ?? "Shipped ",
                            style: widget.headingTitleStyle ??
                                Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(fontSize: 13.px)),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 1.8.w),
                    child: SizedBox(
                      width: 0.60.w,
                      height: widget.secondList != null &&
                          widget.secondList!.isNotEmpty
                          ? widget.secondList!.length * 44
                          : 40,
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: LinearProgressIndicator(
                          value: controller2?.value ?? 0.0,
                          backgroundColor:
                          widget.inActiveColor ?? Colors.grey[300],
                          color: isFirst == true
                              ? widget.activeColor ?? Colors.green
                              : widget.inActiveColor ?? Colors.grey[300],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 4.4.w
                  ),
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.secondList?[index].title ?? "",
                                style: widget.subTitleTextStyle ?? Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 14.px, fontWeight: FontWeight.w500),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              Text(
                                widget.secondList?[index].date ?? "",
                                  style: widget.subDateTextStyle ?? const TextStyle(fontSize: 12, color: Colors.black),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1
                              )
                            ],
                          );
                        },
                        itemCount: widget.secondList != null &&
                            widget.secondList!.isNotEmpty
                            ? widget.secondList!.length
                            : 0),
                  )
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 15.px,
                    width: 15.px,
                    decoration: BoxDecoration(
                        color: (widget.status?.name ==
                            Status.thirdList.name) &&
                            isSecond == true
                            ? widget.activeColor ??Colors.green
                            : widget.inActiveColor ?? Colors.grey[300],
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  SizedBox(
                    width: 3.w
                  ),
                  Column(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: widget.thirdListName ?? "Out of delivery ",
                              style: widget.headingTitleStyle ??
                                  Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(fontSize: 13.px),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 6.w
                  ),
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.thirdList?[index].title ?? "",
                                style: widget.subTitleTextStyle ?? Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 14.px, fontWeight: FontWeight.w500),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              Text(
                                widget.thirdList?[index].date ?? "",
                                  style: widget.subDateTextStyle ?? const TextStyle(fontSize: 12, color: Colors.black),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1
                              )
                            ],
                          );
                        },
                        itemCount: widget.thirdList !=
                            null &&
                            widget.thirdList!.isNotEmpty
                            ? widget.thirdList!.length
                            : 0),
                  )
                ],
              ),
            ],
          ),
          /* Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 10.px,
                    width: 10.px,
                    decoration: BoxDecoration(
                        color: widget.status?.name == Status.delivered.name &&
                                isThird == true
                            ? widget.activeColor ?? Colors.green
                            : widget.inActiveColor ?? Colors.grey[300],
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: "Delivered ",
                            style: widget.headingTitleStyle ??
                                const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                        TextSpan(
                          text: "Fri, 31th Mar '22",
                          style: widget.headingDateTextStyle ??
                              const TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(left: 40, top: 6),
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.deliveredTitleAndDateList?[index].title ?? "",
                          style: widget.subTitleTextStyle ??
                              const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          widget.deliveredTitleAndDateList?[index].date ?? "",
                          style: widget.subDateTextStyle ??
                              TextStyle(fontSize: 14, color: Colors.grey[300]),
                        )
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 4,
                    );
                  },
                  itemCount: widget.deliveredTitleAndDateList != null &&
                          widget.deliveredTitleAndDateList!.isNotEmpty
                      ? widget.deliveredTitleAndDateList!.length
                      : 0)
            ],
          ),*/
        ],
      ),
    );
  }
}

class TextDto {
  String? title;
  String? date;

  TextDto(this.title, this.date);
}

enum Status { firstList, secondList, thirdList }


/*Padding(
          padding: const EdgeInsets.all(20),
          child: OrderTracker(
            status: Status.thirdList,
            headingTitleStyle: TextStyle(
                color: Colors.black,
                fontSize: 16.px,
                fontWeight: FontWeight.w800),
            firstList: [
              TextDto('title1',
                  'date1'),
            ],
            secondList: [
              TextDto('title2',
                  'date2'),
            ],
            thirdList: [
              TextDto(
                  'title3',
                  'date3'),
            ],
            subTitleTextStyle: const TextStyle(color: Colors.red),
          ),
        )*/