class SubCategoriesModel {
  String? message;
  List<SubCategories>? subCategories;

  SubCategoriesModel({this.message, this.subCategories});

  SubCategoriesModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['subCategories'] != null) {
      subCategories = <SubCategories>[];
      json['subCategories'].forEach((v) {
        subCategories!.add(SubCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (subCategories != null) {
      data['subCategories'] =
          subCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategories {
  String? subCategoryId;
  String? uuid;
  String? categoryId;
  String? subCategoryName;
  String? subCategoryImg;
  String? categoryTypeId;
  String? subCategoryKeyword;
  String? isActive;
  String? isDelete;
  String? createdDate;

  SubCategories(
      {this.subCategoryId,
        this.uuid,
        this.categoryId,
        this.subCategoryName,
        this.subCategoryImg,
        this.categoryTypeId,
        this.subCategoryKeyword,
        this.isActive,
        this.isDelete,
        this.createdDate});

  SubCategories.fromJson(Map<String, dynamic> json) {
    subCategoryId = json['subCategoryId'];
    uuid = json['uuid'];
    categoryId = json['categoryId'];
    subCategoryName = json['subCategoryName'];
    subCategoryImg = json['subCategoryImg'];
    categoryTypeId = json['categoryTypeId'];
    subCategoryKeyword = json['subCategoryKeyword'];
    isActive = json['isActive'];
    isDelete = json['isDelete'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subCategoryId'] = subCategoryId;
    data['uuid'] = uuid;
    data['categoryId'] = categoryId;
    data['subCategoryName'] = subCategoryName;
    data['subCategoryImg'] = subCategoryImg;
    data['categoryTypeId'] = categoryTypeId;
    data['subCategoryKeyword'] = subCategoryKeyword;
    data['isActive'] = isActive;
    data['isDelete'] = isDelete;
    data['createdDate'] = createdDate;
    return data;
  }
}
