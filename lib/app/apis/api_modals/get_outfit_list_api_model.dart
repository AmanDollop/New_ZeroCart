class GetOutfitListApiModel {
  String? message;
  List<OutfitList>? outfitList;

  GetOutfitListApiModel({this.message, this.outfitList});

  GetOutfitListApiModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['outfitList'] != null) {
      outfitList = <OutfitList>[];
      json['outfitList'].forEach((v) {
        outfitList!.add(OutfitList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (outfitList != null) {
      data['outfitList'] = outfitList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OutfitList {
  String? outfitId;
  String? outfitUuid;
  String? customerId;
  SelectedOutfit? selectedUpper;
  SelectedOutfit? selectedBottom;
  SelectedOutfit? selectedFootwear;
  List<SelectedOutfit>? selectedAccessories;

  OutfitList(
      {this.outfitId,
      this.outfitUuid,
      this.customerId,
      this.selectedUpper,
      this.selectedBottom,
      this.selectedFootwear,
      this.selectedAccessories});

  OutfitList.fromJson(Map<String, dynamic> json) {
    outfitId = json['outfitId'];
    outfitUuid = json['outfitUuid'];
    customerId = json['customerId'];
    selectedUpper = json['selectedUpper'] != null
        ? SelectedOutfit.fromJson(json['selectedUpper'])
        : null;
    selectedBottom = json['selectedBottom'] != null
        ? SelectedOutfit.fromJson(json['selectedBottom'])
        : null;
    selectedFootwear = json['selectedFootwear'] != null
        ? SelectedOutfit.fromJson(json['selectedFootwear'])
        : null;
    if (json['selectedAccessories'] != null) {
      selectedAccessories = <SelectedOutfit>[];
      json['selectedAccessories'].forEach((v) {
        selectedAccessories!.add(SelectedOutfit.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['outfitId'] = outfitId;
    data['outfitUuid'] = outfitUuid;
    data['customerId'] = customerId;
    if (selectedUpper != null) {
      data['selectedUpper'] = selectedUpper!.toJson();
    }
    if (selectedBottom != null) {
      data['selectedBottom'] = selectedBottom!.toJson();
    }
    if (selectedFootwear != null) {
      data['selectedFootwear'] = selectedFootwear!.toJson();
    }
    if (selectedAccessories != null) {
      data['selectedAccessories'] =
          selectedAccessories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SelectedOutfit {
  int? productId;
  int? inventoryId;
  String? productName;
  String? thumbnailImage;
  String? categoryTypeName;

  SelectedOutfit(
      {this.productId,
      this.inventoryId,
      this.productName,
      this.thumbnailImage,
      this.categoryTypeName});

  SelectedOutfit.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    inventoryId = json['inventoryId'];
    productName = json['productName'];
    thumbnailImage = json['thumbnailImage'];
    categoryTypeName = json['categoryTypeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['inventoryId'] = inventoryId;
    data['productName'] = productName;
    data['thumbnailImage'] = thumbnailImage;
    data['categoryTypeName'] = categoryTypeName;
    return data;
  }
}
