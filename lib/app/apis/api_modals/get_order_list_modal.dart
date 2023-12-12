class GetOrderListApiModal {
  String? message;
  List<OrderList>? orderList;

  GetOrderListApiModal({this.message, this.orderList});

  GetOrderListApiModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['orderList'] != null) {
      orderList = <OrderList>[];
      json['orderList'].forEach((v) {
        orderList!.add(OrderList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (orderList != null) {
      data['orderList'] = orderList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderList {
  String? ordId;
  String? ordNo;
  String? itemUuid;
  String? ordItmId;
  String? productId;
  String? inventoryId;
  String? tailorId;
  String? categoryId;
  String? subCategoryId;
  String? productQty;
  String? productPrice;
  String? productDisPrice;
  String? productName;
  String? categoryName;
  String? subCategoryName;
  String? categoryType;
  String? thumbnailImage;
  String? brandChartImg;
  String? brandName;
  String? colorName;
  String? colorCode;
  String? variantName;
  String? variantAbbreviation;
  String? vendorName;
  String? itemOrderStatus;
  String? trackingUuid;
  String? isOffer;
  String? createdDate;
  String? modelDesc;
  String? cartSnap;
  ShiprocketResponse? shiprocketResponse;

  OrderList(
      {this.ordId,
        this.ordNo,
        this.itemUuid,
        this.ordItmId,
        this.productId,
        this.inventoryId,
        this.tailorId,
        this.categoryId,
        this.subCategoryId,
        this.productQty,
        this.productPrice,
        this.productDisPrice,
        this.productName,
        this.categoryName,
        this.subCategoryName,
        this.categoryType,
        this.thumbnailImage,
        this.brandChartImg,
        this.brandName,
        this.colorName,
        this.colorCode,
        this.variantName,
        this.variantAbbreviation,
        this.vendorName,
        this.itemOrderStatus,
        this.trackingUuid,
        this.isOffer,
        this.createdDate,
        this.modelDesc,
        this.cartSnap,
        this.shiprocketResponse});

  OrderList.fromJson(Map<String, dynamic> json) {
    ordId = json['ordId'];
    ordNo = json['ordNo'];
    itemUuid = json['itemUuid'];
    ordItmId = json['ordItmId'];
    productId = json['productId'];
    inventoryId = json['inventoryId'];
    tailorId = json['tailorId'];
    categoryId = json['categoryId'];
    subCategoryId = json['subCategoryId'];
    productQty = json['productQty'];
    productPrice = json['productPrice'];
    productDisPrice = json['productDisPrice'];
    productName = json['productName'];
    categoryName = json['categoryName'];
    subCategoryName = json['subCategoryName'];
    categoryType = json['categoryType'];
    thumbnailImage = json['thumbnailImage'];
    brandChartImg = json['brandChartImg'];
    brandName = json['brandName'];
    colorName = json['colorName'];
    colorCode = json['colorCode'];
    variantName = json['variantName'];
    variantAbbreviation = json['variantAbbreviation'];
    vendorName = json['vendorName'];
    itemOrderStatus = json['itemOrderStatus'];
    trackingUuid = json['trackingUuid'];
    isOffer = json['isOffer'];
    createdDate = json['createdDate'];
    modelDesc = json['modelDesc'];
    cartSnap = json['cartSnap'];
    shiprocketResponse = json['shiprocketResponse'] != null
        ? ShiprocketResponse.fromJson(json['shiprocketResponse'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ordId'] = ordId;
    data['ordNo'] = ordNo;
    data['itemUuid'] = itemUuid;
    data['ordItmId'] = ordItmId;
    data['productId'] = productId;
    data['inventoryId'] = inventoryId;
    data['tailorId'] = tailorId;
    data['categoryId'] = categoryId;
    data['subCategoryId'] = subCategoryId;
    data['productQty'] = productQty;
    data['productPrice'] = productPrice;
    data['productDisPrice'] = productDisPrice;
    data['productName'] = productName;
    data['categoryName'] = categoryName;
    data['subCategoryName'] = subCategoryName;
    data['categoryType'] = categoryType;
    data['thumbnailImage'] = thumbnailImage;
    data['brandChartImg'] = brandChartImg;
    data['brandName'] = brandName;
    data['colorName'] = colorName;
    data['colorCode'] = colorCode;
    data['variantName'] = variantName;
    data['variantAbbreviation'] = variantAbbreviation;
    data['vendorName'] = vendorName;
    data['itemOrderStatus'] = itemOrderStatus;
    data['trackingUuid'] = trackingUuid;
    data['isOffer'] = isOffer;
    data['createdDate'] = createdDate;
    data['modelDesc'] = modelDesc;
    data['cartSnap'] = cartSnap;
    if (shiprocketResponse != null) {
      data['shiprocketResponse'] = shiprocketResponse!.toJson();
    }
    return data;
  }
}

class ShiprocketResponse {
  int? orderId;
  int? shipmentId;
  String? status;
  int? statusCode;
  int? onboardingCompletedNow;
  String? awbCode;
  String? courierCompanyId;
  String? courierName;

  ShiprocketResponse(
      {this.orderId,
        this.shipmentId,
        this.status,
        this.statusCode,
        this.onboardingCompletedNow,
        this.awbCode,
        this.courierCompanyId,
        this.courierName});

  ShiprocketResponse.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    shipmentId = json['shipment_id'];
    status = json['status'];
    statusCode = json['status_code'];
    onboardingCompletedNow = json['onboarding_completed_now'];
    awbCode = json['awb_code'];
    courierCompanyId = json['courier_company_id'];
    courierName = json['courier_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['shipment_id'] = shipmentId;
    data['status'] = status;
    data['status_code'] = statusCode;
    data['onboarding_completed_now'] = onboardingCompletedNow;
    data['awb_code'] = awbCode;
    data['courier_company_id'] = courierCompanyId;
    data['courier_name'] = courierName;
    return data;
  }
}
