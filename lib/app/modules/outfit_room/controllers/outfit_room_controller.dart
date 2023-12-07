import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:zerocart/app/apis/api_modals/sub_categories_model.dart';
import 'package:zerocart/my_responsive_sizer/src/extension.dart';
import 'package:zerocart/app/apis/api_constant/api_constant.dart';
import 'package:zerocart/app/apis/common_apis/common_apis.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/modules/navigator_bottom_bar/controllers/navigator_bottom_bar_controller.dart';
import '../../../../my_common_method/my_common_method.dart';
import '../../../../my_http/my_http.dart';
import '../../../apis/api_modals/get_collection_list_api_model.dart';
import '../../../apis/api_modals/get_outfit_list_api_model.dart';

class OutfitRoomController extends CommonMethods {
  final count = 0.obs;
  double? bottomHeight = /*Get.arguments ??*/ 80.px;
  String categoryTypeNameUpper = '';
  String categoryTypeNameLower = '';
  String categoryTypeNameShoe = '';
  //String productsIds = '';

  String inventoryIdUpper = '';
  String inventoryIdLower = '';
  String inventoryIdShoe = '';

  final isAddToCartButtonClicked = false.obs;

  int responseCode = 0;
  int load = 0;
  final inAsyncCall = false.obs;
  final isLastPage = false.obs;

  final currentIndexOfUpperImageList = 0.obs;
  final currentIndexOfLowerImageList = 0.obs;
  final currentIndexOfShoeImageList = 0.obs;

  final upperImageViewValue1 = true.obs;
  final lowerImageViewValue1 = false.obs;
  final shoeImageViewValue1 = false.obs;


  final upperImagePath = ''.obs;
  final lowerImagePath = ''.obs;
  final shoeImagePath = ''.obs;

  GetOutfitListApiModel? getOutfitListApiModel;
  List<OutfitList> outfitList = [];
  SelectedOutfit? productDetailUpper;
  SelectedOutfit? productDetailLower;
  SelectedOutfit? productDetailShoe;


  GetCollectionListApiModel? getCollectionListApiModel;
  Map<String, dynamic> bodyParams = {};
  List<CollectionList> collectionList = [];
  Map<String, dynamic> queryParametersCollectionList = {};

  List<CollectionList> collectionListUpper = [];
  List<CollectionList> collectionListLower = [];
  List<CollectionList> collectionListShoe = [];
  List<CollectionList> collectionListAccessories = [];
  List<SelectedOutfit> productDetailAccessoriesList = [];
  SelectedOutfit? productDetailAccessories;
  final accessoriesImageList = [].obs;
  final accessoriesImageListIds = [].obs;
  final accessoriesImageViewValue1 = false.obs;
  String categoryTypeNameAccessories = '';


  SubCategoriesModel? subCategoriesModel;
  List<SubCategories>? subCategoriesList;
  SubCategories? subCategories;


  @override
  Future<void> onInit() async {
    super.onInit();
    onReload();
    inAsyncCall.value = true;
    try {
      // clearAllData();
      await getSubCategoriesApi();
      await getCollectionListApi();
      await getOutfitListApi();
    } catch (e) {
      responseCode = 100;
      MyCommonMethods.showSnackBar(message: "Something went wrong", context: Get.context!);
    }
    inAsyncCall.value = false;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  void onReload() {
    connectivity.onConnectivityChanged.listen((event) async {
      if (await MyCommonMethods.internetConnectionCheckerMethod()) {
        if (load == 0) {
          load = 1;
          await onInit();
        }
      } else {
        load = 0;
      }
    });
  }

  clickOnBackIcon() {
    Get.back();
  }

  Future<void> clickOnUpperImage() async {
    if (collectionListUpper.isNotEmpty) {
      upperImageViewValue1.value = true;
      lowerImageViewValue1.value = false;
      shoeImageViewValue1.value = false;
      accessoriesImageViewValue1.value = false;
    } else {
      lowerImageViewValue1.value = false;
      shoeImageViewValue1.value = false;
      accessoriesImageViewValue1.value = false;
      await callingApiAndClearDataMethod(deleteControllerValue: true);
    }
  }

  Future<void> clickOnLowerImage() async {
    if (collectionListLower.isNotEmpty) {
      lowerImageViewValue1.value = true;
      upperImageViewValue1.value = false;
      shoeImageViewValue1.value = false;
      accessoriesImageViewValue1.value = false;
    } else {
      upperImageViewValue1.value = false;
      shoeImageViewValue1.value = false;
      accessoriesImageViewValue1.value = false;
      await callingApiAndClearDataMethod(deleteControllerValue: true);
    }
  }

  Future<void> clickOnShoeImage() async {
    if (collectionListShoe.isNotEmpty) {
      shoeImageViewValue1.value = true;
      upperImageViewValue1.value = false;
      lowerImageViewValue1.value = false;
      accessoriesImageViewValue1.value = false;
    } else {
      upperImageViewValue1.value = false;
      lowerImageViewValue1.value = false;
      accessoriesImageViewValue1.value = false;
      await callingApiAndClearDataMethod(deleteControllerValue: true);
    }
  }

  Future<void> clickOnGridViewAddImage() async {
    if (collectionListAccessories.isNotEmpty) {
      accessoriesImageViewValue1.value = true;
      shoeImageViewValue1.value = false;
      upperImageViewValue1.value = false;
      lowerImageViewValue1.value = false;
    } else {
      shoeImageViewValue1.value = false;
      upperImageViewValue1.value = false;
      lowerImageViewValue1.value = false;
      await callingApiAndClearDataMethod(deleteControllerValue: true);
    }
  }

  void clickOnUpperRemoveImage() {
    upperImagePath.value = '';
    categoryTypeNameUpper = '';
    inventoryIdUpper = '';
    currentIndexOfUpperImageList.value = -1;
  }

  void clickOnLowerRemoveImage() {
    lowerImagePath.value = '';
    categoryTypeNameLower = '';
    inventoryIdLower = '';
    currentIndexOfLowerImageList.value = -1;
  }

  void clickOnShoeRemoveImage() {
    shoeImagePath.value = '';
    categoryTypeNameShoe = '';
    inventoryIdShoe = '';
    currentIndexOfShoeImageList.value = -1;
  }

  void clickOnAccessoriesRemoveImage({required int index}) {
    accessoriesImageListIds.removeAt(index);
    accessoriesImageList.removeAt(index);
  }

  void clickOnListHorizontalOfUpperImage({required int index}) {
    currentIndexOfUpperImageList.value = index;
    if (collectionListUpper[index].thumbnailImage != null && collectionListUpper[index].thumbnailImage!.isNotEmpty) {
      upperImagePath.value = CommonMethods.imageUrl(url: collectionListUpper[index].thumbnailImage.toString());
    }
    if (collectionListUpper[index].categoryTypeName != null) {
      categoryTypeNameUpper = collectionListUpper[index].categoryTypeName.toString();
    }
    if (collectionListUpper[index].inventoryId != null) {
      inventoryIdUpper = collectionListUpper[index].inventoryId.toString();
    }
  }

  void clickOnListHorizontalOfUpperImageCross({required int index}) {
    if (collectionListUpper[index].collectionUuid != null &&
        collectionListUpper[index].collectionUuid!.isNotEmpty) {
      removeCollectionItemApi(collectionUuid: collectionListUpper[index].collectionUuid.toString());
    }
  }

  void clickOnListHorizontalOfLowerImage({required int index}) {
    currentIndexOfLowerImageList.value = index;
    if (collectionListLower[index].thumbnailImage != null && collectionListLower[index].thumbnailImage!.isNotEmpty) {
      lowerImagePath.value = CommonMethods.imageUrl(url: collectionListLower[index].thumbnailImage.toString());
    }

    if (collectionListLower[index].categoryTypeName != null) {
      categoryTypeNameLower = collectionListLower[index].categoryTypeName.toString();
    }

    if (collectionListLower[index].inventoryId != null) {
      inventoryIdLower = collectionListLower[index].inventoryId.toString();
    }
  }

  void clickOnListHorizontalOfLowerImageCross({required int index}) {
    if (collectionListLower[index].collectionUuid != null && collectionListLower[index].collectionUuid!.isNotEmpty) {
      removeCollectionItemApi(collectionUuid: collectionListLower[index].collectionUuid.toString());
    }
  }

  void clickOnListHorizontalOfShoeImage({required int index}) {
    currentIndexOfShoeImageList.value = index;

    if (collectionListShoe[index].thumbnailImage != null && collectionListShoe[index].thumbnailImage!.isNotEmpty) {
      shoeImagePath.value = CommonMethods.imageUrl(url: collectionListShoe[index].thumbnailImage.toString());
    }

    if (collectionListShoe[index].categoryTypeName != null) {
      categoryTypeNameShoe = collectionListShoe[index].categoryTypeName.toString();
    }
    if (collectionListShoe[index].inventoryId != null) {
      inventoryIdShoe = collectionListShoe[index].inventoryId.toString();
    }
  }

  void clickOnListHorizontalOfShoeImageCross({required int index}) {
    if (collectionListShoe[index].collectionUuid != null && collectionListShoe[index].collectionUuid!.isNotEmpty) {
      removeCollectionItemApi(collectionUuid: collectionListShoe[index].collectionUuid.toString());
    }
  }

  void clickOnListHorizontalOfAccessoriesImage({required int index}) {
    if (collectionListAccessories.isNotEmpty) {
      if (collectionListAccessories[index].thumbnailImage != null && collectionListAccessories[index].thumbnailImage!.isNotEmpty && collectionListAccessories[index].inventoryId != null) {
        accessoriesImageListIds.add(collectionListAccessories[index].inventoryId.toString());
        accessoriesImageList.add(CommonMethods.imageUrl(url: collectionListAccessories[index].thumbnailImage.toString()));
      }
    }
  }

  void clickOnListHorizontalOfAccessoriesImageCross({required int index}) {
    if (collectionListAccessories[index].collectionUuid != null && collectionListAccessories[index].collectionUuid!.isNotEmpty) {
      removeCollectionItemApi(collectionUuid: collectionListAccessories[index].collectionUuid.toString());
    }
  }

  Future<void> removeCollectionItemApi({required String collectionUuid}) async {
    bodyParams = {
      ApiKeyConstant.collectionUuid: collectionUuid,
    };
    http.Response? response = await CommonApis.removeCollectionItemApi(bodyParams: bodyParams);
    responseCode = response?.statusCode ?? 0;
    if (response != null) {
      await callingApiAndClearDataMethod();
    }
  }

  Future<void> getCollectionListApi() async {
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};
    http.Response? response = await MyHttp.getMethodForParams(
        baseUri: ApiConstUri.baseUrlForGetMethod,
        endPointUri: ApiConstUri.endPointGetCollectionListApi,
        queryParameters: queryParametersCollectionList,
        authorization: authorization,
        context: Get.context!);
    responseCode = response?.statusCode ?? 0;
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        getCollectionListApiModel = GetCollectionListApiModel.fromJson(jsonDecode(response.body));
        if (getCollectionListApiModel != null && getCollectionListApiModel!.collectionList != null && getCollectionListApiModel!.collectionList!.isNotEmpty) {
          collectionList = getCollectionListApiModel!.collectionList!;
          if (collectionList.isNotEmpty) {
            collectionList.forEach((element) {

              if (element.categoryTypeName.toString() == 'Upper') {
                collectionListUpper.add(element);

                // if(collectionListUpper.isNotEmpty){
                //   upperImageViewValue1.value=true;
                //   lowerImageViewValue1.value=false;
                //   shoeImageViewValue1.value=false;
                //   accessoriesImageViewValue1.value=false;
                // }

               /* if (collectionListUpper.isNotEmpty) {
                  if (collectionListUpper[0].thumbnailImage != null && collectionListUpper[0].thumbnailImage!.isNotEmpty) {
                    upperImagePath.value = CommonMethods.imageUrl(url: collectionListUpper[0].thumbnailImage.toString());
                  }
                  if (collectionListUpper[0].categoryTypeName != null) {
                    categoryTypeNameUpper = collectionListUpper[0].categoryTypeName.toString();
                  }
                  if (collectionListUpper[0].inventoryId != null) {
                    inventoryIdUpper = collectionListUpper[0].inventoryId.toString();
                  }
                }*/
              }

              if (element.categoryTypeName == 'Lower') {
                collectionListLower.add(element);

                // if(collectionListLower.isNotEmpty){
                //   upperImageViewValue1.value=false;
                //   lowerImageViewValue1.value=true;
                //   shoeImageViewValue1.value=false;
                //   accessoriesImageViewValue1.value=false;
                // }

               /* if (collectionListLower.isNotEmpty) {
                  if (collectionListLower[0].thumbnailImage != null &&
                      collectionListLower[0].thumbnailImage!.isNotEmpty) {
                    lowerImagePath.value = CommonMethods.imageUrl(
                        url: collectionListLower[0].thumbnailImage.toString());
                  }
                  if (collectionListLower[0].categoryTypeName != null) {
                    categoryTypeNameLower =
                        collectionListLower[0].categoryTypeName.toString();
                  }
                  if (collectionListLower[0].inventoryId != null) {
                    inventoryIdLower =
                        collectionListLower[0].inventoryId.toString();
                  }
                }*/
              }

              if (element.categoryTypeName == 'Shoes') {
                collectionListShoe.add(element);

                // if(collectionListShoe.isNotEmpty){
                //   upperImageViewValue1.value=false;
                //   lowerImageViewValue1.value=false;
                //   shoeImageViewValue1.value=true;
                //   accessoriesImageViewValue1.value=false;
                // }

               /* if (collectionListShoe.isNotEmpty) {
                  if (collectionListShoe[0].thumbnailImage != null && collectionListShoe[0].thumbnailImage!.isNotEmpty) {
                    shoeImagePath.value = CommonMethods.imageUrl(url: collectionListShoe[0].thumbnailImage.toString());
                  }
                  if (collectionListShoe[0].categoryTypeName != null) {
                    categoryTypeNameShoe = collectionListShoe[0].categoryTypeName.toString();
                  }
                  if (collectionListShoe[0].inventoryId != null) {
                    inventoryIdShoe = collectionListShoe[0].inventoryId.toString();
                  }
                }*/
              }

              if (element.categoryTypeName == 'Accessories') {
                collectionListAccessories.add(element);

                // if(collectionListAccessories.isNotEmpty){
                //   upperImageViewValue1.value=false;
                //   lowerImageViewValue1.value=false;
                //   shoeImageViewValue1.value=false;
                //   accessoriesImageViewValue1.value=true;
                // }

               /* if (collectionListAccessories.isNotEmpty) {
                  print('collectionListAccessories::::::$collectionListAccessories');
                  if (collectionListAccessories[0].thumbnailImage != null && collectionListAccessories[0].thumbnailImage!.isNotEmpty) {
                    accessoriesImageList.add(CommonMethods.imageUrl(url: collectionListAccessories[0].thumbnailImage.toString()));
                    print('accessoriesImagePath.value::::::  ${accessoriesImagePath.value}');
                 }
                  if (collectionListAccessories[0].categoryTypeName != null) {
                    categoryTypeNameAccessories = collectionListAccessories[0].categoryTypeName.toString();
                  }
                  if (collectionListAccessories[0].inventoryId != null) {
                    inventoryIdAccessories = collectionListAccessories[0].inventoryId.toString();
                  }
                }*/
              }
            });
          }
        }
      }
      increment();
    }
  }

  Future<void> getOutfitListApi() async {
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};
    http.Response? response = await MyHttp.getMethod(
        url: ApiConstUri.endPointGetOutfitListApi,
        token: authorization,
        context: Get.context!);
    responseCode = response?.statusCode ?? 0;
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        getOutfitListApiModel = GetOutfitListApiModel.fromJson(jsonDecode(response.body));
        if (getOutfitListApiModel != null && getOutfitListApiModel!.outfitList != null && getOutfitListApiModel!.outfitList!.isNotEmpty) {
          outfitList = getOutfitListApiModel!.outfitList!;
          print('controller.outfitList::::::::::  ${outfitList.length}');
          if (outfitList.isNotEmpty) {

            outfitList.forEach((element) {
              if (element.selectedUpper != null) {
                if (element.selectedUpper?.categoryTypeName == 'Upper') {
                  productDetailUpper = element.selectedUpper;
                  if (productDetailUpper != null) {

                    if (productDetailUpper?.thumbnailImage != null && productDetailUpper!.thumbnailImage!.isNotEmpty) {
                      upperImagePath.value = CommonMethods.imageUrl(url: productDetailUpper!.thumbnailImage.toString());
                    }
                    if (productDetailUpper!.categoryTypeName != null) {
                      categoryTypeNameUpper = productDetailUpper!.categoryTypeName.toString();
                    }
                    if (productDetailUpper?.inventoryId != null) {
                      inventoryIdUpper = productDetailUpper!.inventoryId.toString();
                    }
                  }
                }
              }

              if (element.selectedBottom != null) {
                if (element.selectedBottom?.categoryTypeName == 'Lower') {
                  productDetailLower = element.selectedBottom;
                  if (productDetailLower != null) {
                    if (productDetailLower!.thumbnailImage != null && productDetailLower!.thumbnailImage!.isNotEmpty) {
                      lowerImagePath.value = CommonMethods.imageUrl(url: productDetailLower!.thumbnailImage.toString());
                    }
                    if (productDetailLower!.categoryTypeName != null) {
                      categoryTypeNameLower = productDetailLower!.categoryTypeName.toString();
                    }
                    if (productDetailLower!.inventoryId != null) {
                      inventoryIdLower = productDetailLower!.inventoryId.toString();
                    }
                  }
                }
              }

              if (element.selectedFootwear != null) {
                if (element.selectedFootwear?.categoryTypeName == 'Shoes') {
                  productDetailShoe = element.selectedFootwear;
                  if (productDetailShoe != null) {
                    if (productDetailShoe!.thumbnailImage != null && productDetailShoe!.thumbnailImage!.isNotEmpty) {
                      shoeImagePath.value = CommonMethods.imageUrl(url: productDetailShoe!.thumbnailImage.toString());
                    }
                    if (productDetailShoe!.categoryTypeName != null) {
                      categoryTypeNameShoe = productDetailShoe!.categoryTypeName.toString();
                    }
                    if (productDetailShoe!.inventoryId != null) {
                      inventoryIdShoe = productDetailShoe!.inventoryId.toString();
                    }
                  }
                }
              }

              if (element.selectedAccessories != null && element.selectedAccessories!.isNotEmpty) {
                productDetailAccessoriesList = element.selectedAccessories!;
                if (productDetailAccessoriesList.isNotEmpty) {
                  productDetailAccessoriesList.forEach((e) {
                    if (e.categoryTypeName != null) {
                      if (e.categoryTypeName == 'Accessories') {
                        productDetailAccessories = e;
                        if (productDetailAccessories != null) {

                          if (productDetailAccessories!.thumbnailImage != null && productDetailAccessories!.thumbnailImage!.isNotEmpty) {
                            accessoriesImageList.add(CommonMethods.imageUrl(url: productDetailAccessories!.thumbnailImage.toString()));
                          }
                          if (productDetailAccessories!.categoryTypeName != null) {
                            categoryTypeNameAccessories = productDetailAccessories!.categoryTypeName.toString();
                          }
                          if (productDetailAccessories?.inventoryId != null) {
                            accessoriesImageListIds.add(productDetailAccessories?.inventoryId.toString());
                          }
                        }
                      }
                    }
                  });
                }
              }

              /*if (element.selectedAccessories != null &&
              element.selectedAccessories!.isNotEmpty) {
                productDetailAccessoriesList = element.selectedAccessories!;
              }*/

            });
          }
        }
      }
      increment();
    }
  }

  Future<void> clickOnSaveButton() async {
    // await callingApiAndClearDataMethod();
    try{
      addToOutfitsApi();
    }catch(e){
      MyCommonMethods.showSnackBar(message: 'Something went wrong!', context: Get.context!);
    }
  }

  Future<void> clickOnAddToCartButton() async {
    inAsyncCall.value = true;
    try{
      isAddToCartButtonClicked.value=true;
      await moveOutfitToCartApi();
    }catch(e){
      isAddToCartButtonClicked.value=false;
      MyCommonMethods.showSnackBar(message: 'Something went wrong!', context: Get.context!);
      inAsyncCall.value = false;
    }
    inAsyncCall.value = false;
  }

  Future<void> moveOutfitToCartApi() async {
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};
    http.Response? response = await MyHttp.getMethod(url: ApiConstUri.endPointMoveOutfitToCartApi, token: authorization, context: Get.context!);
    responseCode = response?.statusCode ?? 0;
    if (response != null) {
      isAddToCartButtonClicked.value=false;
      increment();
      MyCommonMethods.showSnackBar(message: 'Product successfully add in cart.', context: Get.context!);
      // selectedIndex.value = 3;
    }else{
      isAddToCartButtonClicked.value=false;
    }
  }

  Future<void> clearAllData({bool accessoriesImageListValue = true,bool callingOnInitValue = false}) async {
    categoryTypeNameUpper = '';
    inventoryIdUpper = '';

    categoryTypeNameLower = '';
    inventoryIdLower = '';

    categoryTypeNameShoe = '';
    inventoryIdShoe = '';

    /*currentIndexOfUpperImageList.value = 0;
    currentIndexOfLowerImageList.value = 0;
    currentIndexOfShoeImageList.value = 0;*/

    upperImagePath.value = '';
    lowerImagePath.value = '';
    shoeImagePath.value = '';


    if (accessoriesImageListValue) {
      accessoriesImageList.clear();
      accessoriesImageListIds.clear();
    }

    getOutfitListApiModel = null;
    outfitList.clear();

    collectionListUpper.clear();
    collectionListLower.clear();
    collectionListShoe.clear();
    collectionListAccessories.clear();

    productDetailAccessoriesList.clear();
    accessoriesImageList.clear();
    accessoriesImageListIds.clear();


    if(callingOnInitValue){
      await onInit();
    }
  }

  Future<void> addToOutfitsApi() async {
    List accessoriesInventoryIds = [];
    String upperInventoryId = '';
    String bottomInventoryId = '';
    String footwearInventoryId = '';

    if (inventoryIdUpper != '' && inventoryIdUpper.isNotEmpty) {
      upperInventoryId = inventoryIdUpper;
    }
    if (inventoryIdLower != '' && inventoryIdLower.isNotEmpty) {
      bottomInventoryId = inventoryIdLower;
    }
    if (inventoryIdShoe != '' && inventoryIdShoe.isNotEmpty) {
      footwearInventoryId = inventoryIdShoe;
    }

    for (var element in accessoriesImageListIds) {
      accessoriesInventoryIds.add(element);
    }
    bodyParams = {
      ApiKeyConstant.upperInventoryId: upperInventoryId,
      ApiKeyConstant.bottomInventoryId: bottomInventoryId,
      ApiKeyConstant.footwearInventoryId: footwearInventoryId,
      ApiKeyConstant.accessoriesInventoryIds: accessoriesImageListIds.join(','),
    };

    http.Response? response = await CommonApis.addToOutfitsApi(bodyParams: bodyParams);
    responseCode = response?.statusCode ?? 0;
    if (response != null) {
      clearAllData(callingOnInitValue: true);
      // await callingApiAndClearDataMethod();
    }
  }

  Future<void> callingApiAndClearDataMethod({bool deleteControllerValue = false}) async {
    if (deleteControllerValue) {
      clearAllData(accessoriesImageListValue: false);
      selectedIndex.value = 2;
      // await Get.toNamed(Routes.CATEGORY,arguments: true
      // ,);
      //callingGetOutfitRoomListApi();
      //await onInit();
    } else {
      clearAllData();
      await getCollectionListApi();
      await getOutfitListApi();
      /*await Get.delete<MyCartController>();
        Get.lazyPut<MyCartController>(
              () => MyCartController(),
        );*/
      //selectedIndex.value = 3;
      //await Get.toNamed(Routes.MY_CART,arguments: true);
      //await onInit();
    }
  }

  onRefresh() async {
    collectionListUpper.clear();
    collectionListLower.clear();
    collectionListShoe.clear();
    collectionListAccessories.clear();
    await onInit();
  }

  Future<void> getSubCategoriesApi() async {
    try{
      Map<String, String> authorization = {};
      String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
      authorization = {"Authorization": token!};
      http.Response? response = await MyHttp.getMethod(url: ApiConstUri.endPointGetSubCategoriesApi, token: authorization, context: Get.context!);
      responseCode = response?.statusCode ?? 0;
      if (response != null) {
        if (await CommonMethods.checkResponse(response: response)) {
          subCategoriesModel = SubCategoriesModel.fromJson(jsonDecode(response.body));
          if (subCategoriesModel != null && subCategoriesModel!.subCategories != null && subCategoriesModel!.subCategories!.isNotEmpty) {
            subCategoriesList = subCategoriesModel!.subCategories ?? [];
            print('subCategoriesList:::::::   $subCategoriesList');
          }
        }
        increment();
      }
    }catch(e){
      print('Sub::::::  $e');
    }
  }

}


///TODO OLD

/*
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:zerocart/my_responsive_sizer/src/extension.dart';
import 'package:zerocart/app/apis/api_constant/api_constant.dart';
import 'package:zerocart/app/apis/api_modals/get_outfit_room_list_api_model.dart';
import 'package:zerocart/app/apis/common_apis/common_apis.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/modules/my_cart/controllers/my_cart_controller.dart';
import 'package:zerocart/app/modules/navigator_bottom_bar/controllers/navigator_bottom_bar_controller.dart';

import '../../../../my_common_method/my_common_method.dart';
import '../../../../my_http/my_http.dart';

class OutfitRoomController extends CommonMethods {
  final count = 0.obs;
  double? bottomHeight = Get.arguments ?? 80.px;
  String upperId = '';
  String lowerId = '';
  String shoeId = '';
  String productsIds = '';

  final isAddToCartButtonClicked = false.obs;

  int responseCode = 0;
  int load = 0;
  final inAsyncCall = false.obs;
  final isLastPage = false.obs;


  final currentIndexOfUpperImageList = 0.obs;
  final currentIndexOfLowerImageList = 0.obs;
  final currentIndexOfShoeImageList = 0.obs;

  final upperImageViewValue1 = true.obs;
  final lowerImageViewValue1 = false.obs;
  final shoeImageViewValue1 = false.obs;
  final accessoriesImageViewValue1 = false.obs;

  final upperImagePath = ''.obs;
  final lowerImagePath = ''.obs;
  final shoeImagePath = ''.obs;
  final accessoriesImageList = [].obs;
  final accessoriesImageListIds = [].obs;

  GetOutfitRoomListApiModel? getOutfitRoomListApiModel;
  Map<String, dynamic> bodyParams = {};
  List<OutfitRoomList> outfitRoomList = [];
  List<PorductDetail> productDetailUpper = [];
  List<PorductDetail> productDetailLower = [];
  List<PorductDetail> productDetailShoe = [];
  List<PorductDetail> productDetailAccessories = [];

  @override
  Future<void> onInit() async {
    super.onInit();
    onReload();
    inAsyncCall.value = true;
    try {
      await callingGetOutfitRoomListApi();
    } catch (e) {
      responseCode = 100;
      MyCommonMethods.showSnackBar(
          message: "Something went wrong", context: Get.context!);
    }
    inAsyncCall.value = false;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  void onReload() {
    connectivity.onConnectivityChanged.listen((event) async {
      if (await MyCommonMethods.internetConnectionCheckerMethod()) {
        if (load == 0) {
          load = 1;
          await onInit();
        }
      } else {
        load = 0;
      }
    });
  }

  clickOnBackIcon() {
    Get.back();
  }

  Future<void> clickOnUpperImage() async {
    if (productDetailUpper.isNotEmpty) {
      upperImageViewValue1.value = true;
      lowerImageViewValue1.value = false;
      shoeImageViewValue1.value = false;
      accessoriesImageViewValue1.value = false;
    } else {
      lowerImageViewValue1.value = false;
      shoeImageViewValue1.value = false;
      accessoriesImageViewValue1.value = false;
      await callingApiAndClearDataMethod(deleteControllerValue: true);
    }
  }

  Future<void> clickOnLowerImage() async {
    if (productDetailLower.isNotEmpty) {
      lowerImageViewValue1.value = true;
      upperImageViewValue1.value = false;
      shoeImageViewValue1.value = false;
      accessoriesImageViewValue1.value = false;
    } else {
      upperImageViewValue1.value = false;
      shoeImageViewValue1.value = false;
      accessoriesImageViewValue1.value = false;
      await callingApiAndClearDataMethod(deleteControllerValue: true);
    }
  }

  Future<void> clickOnShoeImage() async {
    if (productDetailShoe.isNotEmpty) {
      shoeImageViewValue1.value = true;
      upperImageViewValue1.value = false;
      lowerImageViewValue1.value = false;
      accessoriesImageViewValue1.value = false;
    } else {
      upperImageViewValue1.value = false;
      lowerImageViewValue1.value = false;
      accessoriesImageViewValue1.value = false;
      await callingApiAndClearDataMethod(deleteControllerValue: true);
    }
  }

  Future<void> clickOnGridViewAddImage() async {
    if (productDetailAccessories.isNotEmpty) {
      accessoriesImageViewValue1.value = true;
      shoeImageViewValue1.value = false;
      upperImageViewValue1.value = false;
      lowerImageViewValue1.value = false;
    } else {
      shoeImageViewValue1.value = false;
      upperImageViewValue1.value = false;
      lowerImageViewValue1.value = false;
      await callingApiAndClearDataMethod(deleteControllerValue: true);
    }
  }

  void clickOnUpperRemoveImage() {
    upperImagePath.value = '';
    upperId = '';
    currentIndexOfUpperImageList.value = -1;
  }

  void clickOnLowerRemoveImage() {
    lowerImagePath.value = '';
    lowerId = '';
    currentIndexOfLowerImageList.value = -1;
  }

  void clickOnShoeRemoveImage() {
    shoeImagePath.value = '';
    shoeId = '';
    currentIndexOfShoeImageList.value = -1;
  }

  void clickOnAccessoriesRemoveImage({required int index}) {
    accessoriesImageListIds.removeAt(index);
    accessoriesImageList.removeAt(index);
  }

  void clickOnListHorizontalOfUpperImage({required int index}) {
    currentIndexOfUpperImageList.value = index;
    if (productDetailUpper[index].thumbnailImage != null &&
        productDetailUpper[index].thumbnailImage!.isNotEmpty) {
      upperImagePath.value = CommonMethods.imageUrl(
          url: productDetailUpper[index].thumbnailImage.toString());
    }

    if (productDetailUpper[index].outfitRoomId != null) {
      upperId = productDetailUpper[index].outfitRoomId.toString();
    }
  }

  void clickOnListHorizontalOfLowerImage({required int index}) {
    currentIndexOfLowerImageList.value = index;

    if (productDetailLower[index].thumbnailImage != null &&
        productDetailLower[index].thumbnailImage!.isNotEmpty) {
      lowerImagePath.value = CommonMethods.imageUrl(
          url: productDetailLower[index].thumbnailImage.toString());
    }

    if (productDetailLower[index].outfitRoomId != null) {
      lowerId = productDetailLower[index].outfitRoomId.toString();
    }
  }

  void clickOnListHorizontalOfShoeImage({required int index}) {
    currentIndexOfShoeImageList.value = index;

    if (productDetailShoe[index].thumbnailImage != null &&
        productDetailShoe[index].thumbnailImage!.isNotEmpty) {
      shoeImagePath.value = CommonMethods.imageUrl(
          url: productDetailShoe[index].thumbnailImage.toString());
    }

    if (productDetailShoe[index].outfitRoomId != null) {
      shoeId = productDetailShoe[index].outfitRoomId.toString();
    }
  }

  void clickOnListHorizontalOfAccessoriesImage({required int index}) {
    if (productDetailAccessories.isNotEmpty) {
      if (productDetailAccessories[index].thumbnailImage != null &&
          productDetailAccessories[index].thumbnailImage!.isNotEmpty &&
          productDetailAccessories[index].outfitRoomId != null) {
        accessoriesImageListIds.add(
            productDetailAccessories[index].outfitRoomId.toString());
        accessoriesImageList.add(CommonMethods.imageUrl(
            url: productDetailAccessories[index].thumbnailImage.toString()));
      }
    }
  }

  Future<void> callingGetOutfitRoomListApi() async {
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};
    http.Response? response = await MyHttp.getMethod(
        url: ApiConstUri.endPointGetOutfitRoomListApi,
        token: authorization,
        context: Get.context!);
    responseCode = response?.statusCode ?? 0;
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        getOutfitRoomListApiModel =
            GetOutfitRoomListApiModel.fromJson(jsonDecode(response.body));
        if (getOutfitRoomListApiModel != null &&
            getOutfitRoomListApiModel!.outfitRoomList != null &&
            getOutfitRoomListApiModel!.outfitRoomList!.isNotEmpty) {
          outfitRoomList = getOutfitRoomListApiModel!.outfitRoomList!;
          if (outfitRoomList.isNotEmpty) {
            outfitRoomList.forEach((element) {
              String receivedJson = element.porductDetail.toString();
              Iterable l = json.decode(receivedJson);
              if (element.categoryTypeName == 'Upper') {
                productDetailUpper = List<PorductDetail>.from(
                    l.map((model) => PorductDetail.fromJson(model)));
                if (productDetailUpper.isNotEmpty) {
                  if (productDetailUpper[0].thumbnailImage != null &&
                      productDetailUpper[0].thumbnailImage!.isNotEmpty) {
                    upperImagePath.value = CommonMethods.imageUrl(
                        url: productDetailUpper[0].thumbnailImage.toString());
                  }
                  if (productDetailUpper[0].outfitRoomId != null) {
                    upperId = productDetailUpper[0].outfitRoomId.toString();
                  }
                }
              }

              if (element.categoryTypeName == 'Lower') {
                productDetailLower = List<PorductDetail>.from(
                    l.map((model) => PorductDetail.fromJson(model)));
                if (productDetailLower.isNotEmpty) {
                  if (productDetailLower[0].thumbnailImage != null &&
                      productDetailLower[0].thumbnailImage!.isNotEmpty) {
                    lowerImagePath.value = CommonMethods.imageUrl(
                        url: productDetailLower[0].thumbnailImage.toString());
                  }
                  if (productDetailLower[0].outfitRoomId != null) {
                    lowerId = productDetailLower[0].outfitRoomId.toString();
                  }
                }
              }

              if (element.categoryTypeName == 'Shoe') {
                productDetailShoe = List<PorductDetail>.from(
                    l.map((model) => PorductDetail.fromJson(model)));
                if (productDetailShoe.isNotEmpty) {
                  if (productDetailShoe[0].thumbnailImage != null &&
                      productDetailShoe[0].thumbnailImage!.isNotEmpty) {
                    shoeImagePath.value = CommonMethods.imageUrl(
                        url: productDetailShoe[0].thumbnailImage.toString());
                  }
                  if (productDetailShoe[0].outfitRoomId != null) {
                    shoeId = productDetailShoe[0].outfitRoomId.toString();
                  }
                }
              }

              if (element.categoryTypeName == 'Accessories') {
                productDetailAccessories = List<PorductDetail>.from(l.map((model) => PorductDetail.fromJson(model)));
              }
            });
          }
        }
      }
      increment();
    }
  }

    Future<void> clickOnBrowserMoreButton() async {
      await callingApiAndClearDataMethod(deleteControllerValue: true);
    }

    Future<void> clickOnAddToCartButton() async {
      inAsyncCall.value = true;
      await callingAddOutFitToCartApi();
      inAsyncCall.value = false;
    }

    void clearAllData({bool accessoriesImageListValue = true}) {
      upperId = '';
      lowerId = '';
      productsIds = '';
      shoeId = '';
      currentIndexOfUpperImageList.value = 0;
      currentIndexOfLowerImageList.value = 0;
      currentIndexOfShoeImageList.value = 0;
      upperImagePath.value = '';
      lowerImagePath.value = '';
      shoeImagePath.value = '';
      if (accessoriesImageListValue) {
        accessoriesImageList.clear();
        accessoriesImageListIds.clear();
      }
      getOutfitRoomListApiModel = null;
      outfitRoomList.clear();
      productDetailUpper.clear();
      productDetailLower.clear();
      productDetailShoe.clear();
      productDetailAccessories.clear();
    }

    Future<void> callingAddOutFitToCartApi() async {
      List ids = [];

      if (upperId != '' && upperId.isNotEmpty) {
        ids.add(upperId);
      }

      if (lowerId != '' && lowerId.isNotEmpty) {
        ids.add(lowerId);
      }

      if (shoeId != '' && shoeId.isNotEmpty) {
        ids.add(shoeId);
      }

      for (var element in accessoriesImageListIds) {
        ids.add(element);
      }
      productsIds = ids.join(',');

      bodyParams = {
        ApiKeyConstant.outfitRoomId: productsIds,
      };

      http.Response? response =
      await CommonApis.addOutfitToCartApi(bodyParams: bodyParams);
      responseCode = response?.statusCode ?? 0;
      if (response != null) {
        await callingApiAndClearDataMethod();
      }
    }

    Future<void> callingApiAndClearDataMethod(
        {bool deleteControllerValue = false}) async {
      if (deleteControllerValue) {
        clearAllData(accessoriesImageListValue: false);
        selectedIndex.value = 2;
        // await Get.toNamed(Routes.CATEGORY,arguments: true,);
        callingGetOutfitRoomListApi();
      } else {
        clearAllData();
        */
/*await Get.delete<MyCartController>();
        Get.lazyPut<MyCartController>(
              () => MyCartController(),
        );*/
/*
        //selectedIndex.value = 3;
        //await Get.toNamed(Routes.MY_CART,arguments: true);
        callingGetOutfitRoomListApi();
      }
    }

  onRefresh() async {
    await onInit();
  }
  }
*/
