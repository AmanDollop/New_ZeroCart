import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zerocart/app/modules/navigator_bottom_bar/controllers/navigator_bottom_bar_controller.dart';
import 'package:zerocart/my_responsive_sizer/src/extension.dart';
import 'package:zerocart/app/apis/api_constant/api_constant.dart';
import 'package:zerocart/app/apis/api_modals/get_order_list_modal.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/modules/my_orders/views/cancel_bottom_sheet.dart';
import 'package:zerocart/app/modules/my_orders/views/orders_filter_bottom_sheet.dart';
import 'package:zerocart/app/modules/my_orders/views/tracking_bottomsheet.dart';
import 'package:zerocart/app/routes/app_pages.dart';
import 'package:zerocart/my_colors/my_colors.dart';

import '../../../../my_common_method/my_common_method.dart';
import '../../../../my_http/my_http.dart';

class MyOrdersController extends CommonMethods {
  final count = 0.obs;
  int responseCode = 0;
  int load = 0;
  final inAsyncCall = false.obs;
  final isLastPage = false.obs;
  final searchOrderController = TextEditingController();
  final pageName = Get.parameters['pageName'].obs;

  List orderStatusList = [
    "Pending",
    "Shipped",
    "Picked",
    "Delivered",
    "Canceled",
  ];
  final orderFilterType = "-1".obs;
  final isApplyButtonClicked = false.obs;

  String limit = "10";
  int offset = 0;
  Map<String, dynamic> queryParametersForGetOrderListApi = {};
  GetOrderListApiModal? getOrderListModal;

  List<OrderList> orderList = [];

  final totalTrackStep = 4.obs;
  final currentTrackStep = 2.obs;

  Timer? searchOnStoppedTyping;
  DateTime? dateTime;
  DateFormat? dateFormat;

  @override
  Future<void> onInit() async {
    super.onInit();
    onReload();
    inAsyncCall.value = true;
    if (await MyCommonMethods.internetConnectionCheckerMethod()) {
      try {
        await getOrderListApiCalling();
      } catch (e) {
        MyCommonMethods.showSnackBar(
            message: "Something went wrong", context: Get.context!);
        responseCode = 100;
      }
    }
    inAsyncCall.value = false;
  }

  void increment() => count.value++;

  void onReload() {
    connectivity.onConnectivityChanged.listen((event) async {
      if (await MyCommonMethods.internetConnectionCheckerMethod()) {
        if (load == 0) {
          load = 1;
          offset = 0;
          await onInit();
        }
      } else {
        load = 0;
      }
    });
  }

  Future<void> onRefresh() async {
    offset = 0;
    await onInit();
  }

  Future<void> onLoadMore() async {
    offset = offset + 10;
    try {
      await getOrderListApiCalling();
    } catch (e) {
      responseCode = 100;
      MyCommonMethods.showSnackBar(
          message: "Something went wrong", context: Get.context!);
    }
  }

  Future<void> getOrderListApiCalling() async {
    queryParametersForGetOrderListApi.clear();
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};
    queryParametersForGetOrderListApi = {
      ApiKeyConstant.orderStatus: orderFilterType.value != "-1"
          ? orderStatusList[int.parse(orderFilterType.value)].toString().replaceAll(" ", "")
          : "",
      ApiKeyConstant.limit: limit,
      ApiKeyConstant.offset: offset.toString(),
      ApiKeyConstant.searchSrting: searchOrderController.text.trim().toString(),
    };
    http.Response? response = await MyHttp.getMethodForParams(
        context: Get.context!,
        queryParameters: queryParametersForGetOrderListApi,
        authorization: authorization,
        baseUri: ApiConstUri.baseUrlForGetMethod,
        endPointUri: ApiConstUri.endPointGetOrderListApi);
    responseCode = response?.statusCode ?? 0;
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        getOrderListModal =
            GetOrderListApiModal.fromJson(jsonDecode(response.body));
        if (getOrderListModal != null) {
          if (offset == 0) {
            orderList.clear();
          }
          if (getOrderListModal?.orderList != null &&
              getOrderListModal!.orderList!.isNotEmpty) {
            isLastPage.value = false;
            getOrderListModal?.orderList?.forEach((element) {
              orderList.add(element);
            });
          } else {
            isLastPage.value = true;
          }
        }
      }
    }
    increment();
  }

  clickOnBackIcon({required BuildContext context}) {
    inAsyncCall.value = true;
    if (pageName.value == 'ProfileMenu' &&
        pageName.value != null &&
        pageName.value!.isNotEmpty) {
      Get.back();
    } else {
      selectedIndex.value = 0;
      Get.offAllNamed(Routes.NAVIGATOR_BOTTOM_BAR);
    }
    inAsyncCall.value = false;
  }

  void clickOnFilterButton() {
    showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: false,
        backgroundColor: MyColorsLight().secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.px),
            topRight: Radius.circular(20.px),
          ),
        ),
        context: Get.context!,
        builder: (context) {
          return const OderFilterBottomSheet();
        }).whenComplete(() {
      print('val::::::::   ${orderFilterType.value}');
    });
  }

  Future<void> onChangeSearchTextField({String? value}) async {
    if (value != null) {
      const duration = Duration(
          milliseconds:
              800); // set the duration that you want call search() after that.
      if (searchOnStoppedTyping != null) {
        searchOnStoppedTyping?.cancel(); // clear timer
      }
      searchOnStoppedTyping = Timer(duration, () async {
        offset = 0;
        await getOrderListApiCalling();
      });
    }
  }

  void clickOnClearFilterButton() {
    inAsyncCall.value = true;

    orderFilterType.value = "-1";
    inAsyncCall.value = false;
  }

  void clickOnOrderStatus({required int index}) {
    inAsyncCall.value = true;
    orderFilterType.value = "$index";
    inAsyncCall.value = false;
  }

  Future<void> clickOnApplyButton({required BuildContext context}) async {
    Get.back();
    offset = 0;
    await onInit();
  }

  void clickOnTrackButton({
    required String orderPlaceDate,
    required String orderNo,
  }) {
    showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: false,
        backgroundColor: MyColorsLight().secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.px),
            topRight: Radius.circular(20.px),
          ),
        ),
        context: Get.context!,
        builder: (context) => TrackingBottomSheet(
              orderNo: orderNo,
              orderPlaceDate: orderPlaceDate,
            ));
  }

  void clickOnCancelButton(
      {required BuildContext context, required int index}) {
    showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: false,
        backgroundColor: MyColorsLight().secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.px),
            topRight: Radius.circular(20.px),
          ),
        ),
        context: Get.context!,
        builder: (context) {
          OrderList orderListObject = orderList[index];
          double price = 0.0;
          /*for(int i=1;i<=int.parse(orderListObject.productQty??"1");i++)
          {

          }*/
          if (orderListObject.isOffer == "1") {
            price = price +
                double.parse(double.parse(orderListObject.productDisPrice!)
                    .toStringAsFixed(2));
          } else {
            price = price +
                double.parse(double.parse(orderListObject.productPrice!)
                    .toStringAsFixed(2));
          }
          return MyOrdersCancelBottomSheet(
            index: index,
            price: price,
          );
        });
  }

  void clickOnDoNotCancelButton() {
    inAsyncCall.value = true;
    Get.back();
    inAsyncCall.value = false;
  }

  Future<void> clickOnCancelFiltersBottomSheetButton() async {
    inAsyncCall.value = true;
    orderFilterType.value = '-1';
    Get.back();
    offset = 0;
    await onInit();
    inAsyncCall.value = false;
  }

  Future<void> clickOnCancelOrderButton(
      {required BuildContext context, required int index}) async {
    inAsyncCall.value = true;
    Get.back();
    await Get.toNamed(
      Routes.CANCEL_ORDER,
      arguments: {"orderList[index]": orderList[index]},
    );
    offset = 0;
    await getOrderListApiCalling();
    inAsyncCall.value = false;
  }

  Future<void> clickOnOrderDetails(
      {required String productId, required int index}) async {
    inAsyncCall.value = true;
    await Get.toNamed(Routes.MY_ORDER_DETAILS,
        arguments: [productId, orderList[index]]);
    offset = 0;
    await onInit();
    inAsyncCall.value = false;
  }
}
