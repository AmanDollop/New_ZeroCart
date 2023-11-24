class GetCollectionListApiModel {
  String? message;
  List<CollectionList>? collectionList;

  GetCollectionListApiModel({this.message, this.collectionList});

  GetCollectionListApiModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['collectionList'] != null) {
      collectionList = <CollectionList>[];
      json['collectionList'].forEach((v) {
        collectionList!.add(CollectionList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (collectionList != null) {
      data['collectionList'] =
          collectionList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CollectionList {
  String? collectionId;
  String? collectionUuid;
  String? customerId;
  String? inventoryId;
  String? productId;
  String? colorName;
  String? colorCode;
  String? variantName;
  String? variantAbbreviation;
  String? availability;
  String? sellPrice;
  String? isOffer;
  String? offerPrice;
  String? productDescription;
  String? customImage;
  String? isCustom;
  String? productName;
  String? thumbnailImage;
  String? categoryId;
  String? categoryName;
  String? subCategoryId;
  String? subCategoryName;
  String? categoryTypeId;
  String? categoryTypeName;
  String? fashionCategoryId;
  String? fashionCatName;
  String? brandId;
  String? brandName;
  List<ProductImages>? productImages;

  CollectionList(
      {this.collectionId,
        this.collectionUuid,
        this.customerId,
        this.inventoryId,
        this.productId,
        this.colorName,
        this.colorCode,
        this.variantName,
        this.variantAbbreviation,
        this.availability,
        this.sellPrice,
        this.isOffer,
        this.offerPrice,
        this.productDescription,
        this.customImage,
        this.isCustom,
        this.productName,
        this.thumbnailImage,
        this.categoryId,
        this.categoryName,
        this.subCategoryId,
        this.subCategoryName,
        this.categoryTypeId,
        this.categoryTypeName,
        this.fashionCategoryId,
        this.fashionCatName,
        this.brandId,
        this.brandName,
        this.productImages});

  CollectionList.fromJson(Map<String, dynamic> json) {
    collectionId = json['collectionId'];
    collectionUuid = json['collectionUuid'];
    customerId = json['customerId'];
    inventoryId = json['inventoryId'];
    productId = json['productId'];
    colorName = json['colorName'];
    colorCode = json['colorCode'];
    variantName = json['variantName'];
    variantAbbreviation = json['variantAbbreviation'];
    availability = json['availability'];
    sellPrice = json['sellPrice'];
    isOffer = json['isOffer'];
    offerPrice = json['offerPrice'];
    productDescription = json['productDescription'];
    customImage = json['customImage'];
    isCustom = json['isCustom'];
    productName = json['productName'];
    thumbnailImage = json['thumbnailImage'];
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    subCategoryId = json['subCategoryId'];
    subCategoryName = json['subCategoryName'];
    categoryTypeId = json['categoryTypeId'];
    categoryTypeName = json['categoryTypeName'];
    fashionCategoryId = json['fashionCategoryId'];
    fashionCatName = json['fashionCatName'];
    brandId = json['brandId'];
    brandName = json['brandName'];
    if (json['productImages'] != null) {
      productImages = <ProductImages>[];
      json['productImages'].forEach((v) {
        productImages!.add(ProductImages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['collectionId'] = collectionId;
    data['collectionUuid'] = collectionUuid;
    data['customerId'] = customerId;
    data['inventoryId'] = inventoryId;
    data['productId'] = productId;
    data['colorName'] = colorName;
    data['colorCode'] = colorCode;
    data['variantName'] = variantName;
    data['variantAbbreviation'] = variantAbbreviation;
    data['availability'] = availability;
    data['sellPrice'] = sellPrice;
    data['isOffer'] = isOffer;
    data['offerPrice'] = offerPrice;
    data['productDescription'] = productDescription;
    data['customImage'] = customImage;
    data['isCustom'] = isCustom;
    data['productName'] = productName;
    data['thumbnailImage'] = thumbnailImage;
    data['categoryId'] = categoryId;
    data['categoryName'] = categoryName;
    data['subCategoryId'] = subCategoryId;
    data['subCategoryName'] = subCategoryName;
    data['categoryTypeId'] = categoryTypeId;
    data['categoryTypeName'] = categoryTypeName;
    data['fashionCategoryId'] = fashionCategoryId;
    data['fashionCatName'] = fashionCatName;
    data['brandId'] = brandId;
    data['brandName'] = brandName;
    if (productImages != null) {
      data['productImages'] =
          productImages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductImages {
  String? productImage;

  ProductImages({this.productImage});

  ProductImages.fromJson(Map<String, dynamic> json) {
    productImage = json['productImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productImage'] = productImage;
    return data;
  }
}
