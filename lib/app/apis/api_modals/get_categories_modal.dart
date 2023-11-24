class GetCategories {
  String? message;
  List<Categories>? categories;
  Categories? tailor;

  GetCategories({this.message, this.categories, this.tailor});

  GetCategories.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    tailor =
    json['tailor'] != null ? new Categories.fromJson(json['tailor']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    if (tailor != null) {
      data['tailor'] = tailor!.toJson();
    }
    return data;
  }
}

class Categories {
  String? fashionCategoryId;
  String? name;
  String? categoryImage;
  String? type;

  Categories(
      {this.fashionCategoryId, this.name, this.categoryImage, this.type});

  Categories.fromJson(Map<String, dynamic> json) {
    fashionCategoryId = json['fashionCategoryId'];
    name = json['name'];
    categoryImage = json['categoryImage'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fashionCategoryId'] = fashionCategoryId;
    data['name'] = name;
    data['categoryImage'] = categoryImage;
    data['type'] = type;
    return data;
  }
}




/*class GetCategories {
  String? message;
  List<Categories>? categories;

  GetCategories({this.message, this.categories});

  GetCategories.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  String? categoryId;
  String? uuid;
  String? categoryName;
  String? isChatOption;
  String? isCategoryType;
  String? parentCategoryId;
  String? categoryImage;
  String? countryIds;
  String? stateIds;
  String? cityIds;
  String? isActive;
  String? isDelete;
  String? createdDate;

  Categories(
      {this.categoryId,
        this.uuid,
        this.categoryName,
        this.isChatOption,
        this.isCategoryType,
        this.parentCategoryId,
        this.categoryImage,
        this.countryIds,
        this.stateIds,
        this.cityIds,
        this.isActive,
        this.isDelete,
        this.createdDate});

  Categories.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    uuid = json['uuid'];
    categoryName = json['categoryName'];
    isChatOption = json['isChatOption'];
    isCategoryType = json['isCategoryType'];
    parentCategoryId = json['parentCategoryId'];
    categoryImage = json['categoryImage'];
    countryIds = json['countryIds'];
    stateIds = json['stateIds'];
    cityIds = json['cityIds'];
    isActive = json['isActive'];
    isDelete = json['isDelete'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['categoryId'] = categoryId;
    data['uuid'] = uuid;
    data['categoryName'] = categoryName;
    data['isChatOption'] = isChatOption;
    data['isCategoryType'] = isCategoryType;
    data['parentCategoryId'] = parentCategoryId;
    data['categoryImage'] = categoryImage;
    data['countryIds'] = countryIds;
    data['stateIds'] = stateIds;
    data['cityIds'] = cityIds;
    data['isActive'] = isActive;
    data['isDelete'] = isDelete;
    data['createdDate'] = createdDate;
    return data;
  }
}*/
