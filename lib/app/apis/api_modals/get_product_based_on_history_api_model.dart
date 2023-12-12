class GetProductBasedOnHistoryApiModel {
  String? message;
  List<ProductDetails>? productDetails;

  GetProductBasedOnHistoryApiModel({this.message, this.productDetails});

  GetProductBasedOnHistoryApiModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['productDetails'] != null) {
      productDetails = <ProductDetails>[];
      json['productDetails'].forEach((v) {
        productDetails!.add(ProductDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (productDetails != null) {
      data['productDetails'] =
          productDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductDetails {
  String? uuid;
  String? productId;
  String? productUuid;
  String? productName;
  String? thumbnailImage;
  String? brandChartImg;
  String? brandId;
  String? brandName;
  String? categoryTypeName;
  String? fashionCatName;
  String? subCategoryName;
  String? productPrice;
  String? percentageDis;
  String? offerPrice;
  String? isOffer;

  ProductDetails(
      {this.uuid,
        this.productId,
        this.productUuid,
        this.productName,
        this.thumbnailImage,
        this.brandChartImg,
        this.brandId,
        this.brandName,
        this.categoryTypeName,
        this.fashionCatName,
        this.subCategoryName,
        this.productPrice,
        this.percentageDis,
        this.offerPrice,
        this.isOffer});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    productId = json['productId'];
    productUuid = json['productUuid'];
    productName = json['productName'];
    thumbnailImage = json['thumbnailImage'];
    brandChartImg = json['brandChartImg'];
    brandId = json['brandId'];
    brandName = json['brandName'];
    categoryTypeName = json['categoryTypeName'];
    fashionCatName = json['fashionCatName'];
    subCategoryName = json['subCategoryName'];
    productPrice = json['productPrice'];
    percentageDis = json['percentageDis'];
    offerPrice = json['offerPrice'];
    isOffer = json['isOffer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['productId'] = productId;
    data['productUuid'] = productUuid;
    data['productName'] = productName;
    data['thumbnailImage'] = thumbnailImage;
    data['brandChartImg'] = brandChartImg;
    data['brandId'] = brandId;
    data['brandName'] = brandName;
    data['categoryTypeName'] = categoryTypeName;
    data['fashionCatName'] = fashionCatName;
    data['subCategoryName'] = subCategoryName;
    data['productPrice'] = productPrice;
    data['percentageDis'] = percentageDis;
    data['offerPrice'] = offerPrice;
    data['isOffer'] = isOffer;
    return data;
  }
}
