// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zerocart/app/apis/api_constant/api_constant.dart';
import 'package:zerocart/app/apis/api_modals/get_all_brand_list_api_model.dart';
import 'package:zerocart/app/apis/api_modals/get_all_fashion_category_list_api_model.dart';
import 'package:zerocart/app/apis/api_modals/get_city_model.dart';
import 'package:zerocart/app/apis/api_modals/get_state_model.dart';
import 'package:zerocart/app/apis/api_modals/user_data_modal.dart';
import 'package:zerocart/app/apis/common_apis/common_apis.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/common_widgets/common_widgets.dart';
import 'package:zerocart/app/routes/app_pages.dart';
import 'package:http/http.dart' as http;
import 'package:zerocart/my_colors/my_colors.dart';
import 'package:zerocart/my_responsive_sizer/src/extension.dart';

import '../../../../my_common_method/my_common_method.dart';
import '../../../../my_firebase/my_firebase.dart';

class RegistrationController extends GetxController {
  Map<String, dynamic> userFirebaseData = Get.arguments;
  final count = 0.obs;
  final inAsyncCall = false.obs;

  final key = GlobalKey<FormState>();
  final absorbing = false.obs;
  final passwordVisible = false.obs;
  final confirmPasswordVisible = false.obs;
  final isSendOtpVisible = true.obs;
  final isStateSelectedValue = false.obs;
  final isCitySelectedValue = false.obs;
  final isSubmitButtonVisible = false.obs;
  final isSubmitButtonClicked = false.obs;
  final isSendOtpButtonClicked = false.obs;
  final isVisibleIcon = false.obs;
  final isCityTextFieldNotVisible = true.obs;
  String deviceType = "";

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String countryId = "101";

  Map<String, dynamic> queryParametersState = {};
  final stateModel = Rxn<StateModel?>();
  List<States>? statesList;
  final selectedState = Rxn<States?>();
  String stateId = '';

  final stateController = TextEditingController();
  final searchStateController = TextEditingController();
  List<States> statesListSearch = [];

  Map<String, dynamic> queryParametersCity = {};
  final cityModel = Rxn<CityModel?>();
  List<Cities>? citiesList;
  final selectedCity = Rxn<Cities?>();
  String cityId = '';

  final cityController = TextEditingController();
  final searchCityController = TextEditingController();
  List<Cities> cityListSearch = [];


  final getAllBrandListApiModel = Rxn<GetAllBrandListApiModel?>();
  final getAllFashionCategoryListApiModel = Rxn<GetAllFashionCategoryListApiModel?>();
  List<BrandList>? brandList;
  List<FashionCategoryList>? fashionCategoryList;
  Map<String, dynamic> bodyParamsForSendOtp = {};
  Map<String, dynamic> sendOtpApiResponse = {};

  Map<String, dynamic> bodyParamsForSubmitApi = {};
  final userData = Rxn<UserData?>();

  //TODO This Code ADD By Aman
  final checkTypeOfProductsValue = '-1'.obs;
  final checkValue = true.obs;

  final isResponse = false.obs;

  List checkBoxTitle = [
    'Men',
    'Women',
    'Unisex',
  ];

  final selectedBrands = [].obs;
  List idBrand = [];
  List fashionCategoryId = [];
  final selectedFashionCategory = [].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    emailController.text = userFirebaseData["email"];
    deviceType = MyCommonMethods.getDeviceType();
    await getStateApiCalling();
    await getAllFashionCategoryListApiCalling();
    await getAllBrandListApiCalling();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> sendOtpApiCalling({required String type}) async {
    String? uuid = await MyCommonMethods.getString(key: ApiKeyConstant.uuid);
    try{
      bodyParamsForSendOtp = {
        ApiKeyConstant.mobile: mobileNumberController.text.trim().toString(),
        ApiKeyConstant.countryCode: "+91",
        ApiKeyConstant.type: type,
        ApiKeyConstant.uuid: uuid,
      };
      http.Response? response = await CommonApis.sendOtpApi(bodyParams: bodyParamsForSendOtp);
      if (response != null) {
        sendOtpApiResponse = jsonDecode(response.body);
        Get.toNamed(Routes.VERIFICATION, arguments: [
          3,
          "Submit",
          sendOtpApiResponse[ApiKeyConstant.otp],
          "registration",
          mobileNumberController.text.toString().trim()
        ]);
      }
    }catch(e){
      MyCommonMethods.showSnackBar(message: 'Something went wrong!', context: Get.context!);
    }
  }

  Future<void> registrationApiCalling() async {
    String? uuid = await MyCommonMethods.getString(key: ApiKeyConstant.uuid);
    String? fcmId = await MyFirebaseSignIn.getUserFcmId(context: Get.context!);
    String gender = "";
    if (checkTypeOfProductsValue.toString() == "0") {
      gender = "m";
    } else if (checkTypeOfProductsValue.toString() == "1") {
      gender = "f";
    } else if (checkTypeOfProductsValue.toString() == "2") {
      gender = "m,f";
    } else {
      gender = "";
    }
    bodyParamsForSubmitApi = {
      ApiKeyConstant.fullName: nameController.text.trim().toString(),
      ApiKeyConstant.uuid: uuid,
      ApiKeyConstant.password: passwordController.text.trim().toString(),
      ApiKeyConstant.deviceType: deviceType,
      ApiKeyConstant.fcmId: fcmId,
      ApiKeyConstant.countryId: countryId,
      ApiKeyConstant.stateId: stateId,
      ApiKeyConstant.cityId: cityId,
      ApiKeyConstant.genderPreferences: gender,
      ApiKeyConstant.brandPreferences: idBrand.isNotEmpty ? idBrand.join(',') : '',
      ApiKeyConstant.categoryPreferences: fashionCategoryId.isNotEmpty ? fashionCategoryId.join(',') : ''
    };
    userData.value = await CommonApis.registrationApi(bodyParams: bodyParamsForSubmitApi);
    if (userData.value != null) {
      MyCommonMethods.showSnackBar(message: "Registered Successfully", context: Get.context!);
      Get.offAllNamed(Routes.NAVIGATOR_BOTTOM_BAR);
    }
  }

  Future<void> getStateApiCalling() async {
    queryParametersState = {ApiKeyConstant.countryId: countryId};
    stateModel.value = await CommonApis.getStateApi(queryParameters: queryParametersState);
    if (stateModel.value != null) {
      statesList = stateModel.value?.states;
      //selectedState = statesList?.first;
    }
  }

  Future<void> getCityApiCalling({required String sId}) async {
    selectedCity.value = null;
    queryParametersCity = {ApiKeyConstant.stateId: sId};
    cityModel.value = await CommonApis.getCityApi(queryParameters: queryParametersCity);
    if (cityModel.value != null) {
      citiesList = cityModel.value?.cities;
    }
  }

  Future<void> getAllBrandListApiCalling() async {
    getAllBrandListApiModel.value = await CommonApis.getAllBrandListApi();
    if (getAllBrandListApiModel.value != null) {
      brandList = getAllBrandListApiModel.value?.brandList;
    }
    isResponse.value = true;
  }

  Future<void> getAllFashionCategoryListApiCalling() async {
    getAllFashionCategoryListApiModel.value = await CommonApis.getAllFashionCategoryListApi();
    if (getAllFashionCategoryListApiModel.value != null) {
      fashionCategoryList = getAllFashionCategoryListApiModel.value?.fashionCategoryList;
    }
  }

  void increment() => count.value++;

  void clickOnPasswordEyeButton() {
    passwordVisible.value = !passwordVisible.value;
  }

  void clickOnConfirmPasswordEyeButton() {
    confirmPasswordVisible.value = !confirmPasswordVisible.value;
  }

  Future<void> clickOnSendOtpButton() async {
    absorbing.value = CommonMethods.changeTheAbsorbingValueTrue();
    MyCommonMethods.unFocsKeyBoard();
    isSendOtpButtonClicked.value = true;
    try{
      await sendOtpApiCalling(type: 'registration');
    }catch(e){
      MyCommonMethods.showSnackBar(message: 'Something went wrong!', context: Get.context!);
      isSendOtpButtonClicked.value = false;
      absorbing.value = CommonMethods.changeTheAbsorbingValueFalse();
    }
    isSendOtpButtonClicked.value = false;
    absorbing.value = CommonMethods.changeTheAbsorbingValueFalse();
  }

  Future<void> clickOnSubmitButton() async {
    absorbing.value = CommonMethods.changeTheAbsorbingValueTrue();
    MyCommonMethods.unFocsKeyBoard();
    dropDownValidationChecker();
    if (key.currentState!.validate() && !isStateSelectedValue.value && !isCitySelectedValue.value) {
      isSubmitButtonClicked.value = true;
      if (checkTypeOfProductsValue.toString()=="-1" && idBrand.isEmpty && fashionCategoryId.isEmpty) {
        try{
          await registrationApiCalling();
        }catch(e){
          isSubmitButtonClicked.value = false;
          absorbing.value = CommonMethods.changeTheAbsorbingValueFalse();
        }
      } else if ((checkTypeOfProductsValue.toString() !="-1" && idBrand.isNotEmpty && fashionCategoryId.isNotEmpty)) {
        try{
          await registrationApiCalling();
        }catch(e){
          MyCommonMethods.showSnackBar(message: 'Something went wrong!', context: Get.context!);
          isSubmitButtonClicked.value = false;
          absorbing.value = CommonMethods.changeTheAbsorbingValueFalse();
        }
      }else
        {
         MyCommonMethods.showSnackBar(message: "All field required", context: Get.context!);
        }
      isSubmitButtonClicked.value = false;
    }
    absorbing.value = CommonMethods.changeTheAbsorbingValueFalse();
  }

  void dropDownValidationChecker()  {
    if (selectedState.value == null && stateId == '') {
      isStateSelectedValue.value = true;
    } else {
      isStateSelectedValue.value = false;
    }

    if (selectedCity.value == null && cityId == '') {
      isCitySelectedValue.value = true;
    } else {
      isCitySelectedValue.value = false;
    }
  }

  clickOnStateTextField() {
    bottomSheetForState();
  }

  void bottomSheetForState() {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: false,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 6.px),
            child: Column(
              children: [
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
                          borderRadius:
                          BorderRadius.all(Radius.circular(2.5.px)),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 6.px),
                CommonWidgets.commonTestFieldForSearch(
                  hintText: 'Search State',
                  labelText: 'Search State',
                  controller: searchStateController,
                  onChanged: (value) {
                    statesListSearch.clear();
                    if (value.isEmpty) {
                      return;
                    } else {
                      statesList?.forEach((stateAllData) {
                        if (stateAllData.name!.toLowerCase().contains(value.toLowerCase().trim())) {
                          if (stateAllData.name?.toLowerCase().trim().contains(value.toLowerCase().trim()) != null) {
                            statesListSearch.add(stateAllData);
                          } else {
                            statesListSearch = [];
                          }
                        }
                      });
                      setState((){
                        count.value++;
                      });
                    }
                  },
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: searchStateController.text.isNotEmpty ? statesListSearch.length : statesList?.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          inAsyncCall.value = true;
                          try{
                            if(searchStateController.text.isNotEmpty){

                              stateId = statesListSearch[index].id??'';
                              selectedState.value = statesListSearch[index];
                              stateController.text=statesListSearch[index].name.toString();
                              if (statesListSearch[index].id != null) {
                                cityModel.value = null;
                                cityId = "";
                                cityController.clear();
                                isStateSelectedValue.value = false;
                                await getCityApiCalling(sId: stateId);
                              }
                              Get.back();
                              setState((){count.value++;});
                            }else{
                              stateId = statesList?[index].id??'';
                              selectedState.value = statesList?[index];
                              stateController.text=statesList?[index].name.toString()??'';
                              if (statesList?[index].id != null) {
                                cityModel.value = null;
                                cityId = "";
                                cityController.clear();
                                isStateSelectedValue.value = false;
                                await getCityApiCalling(sId: stateId);
                              }
                              Get.back();
                              setState((){count.value++;});
                            }
                          }catch(e){
                            inAsyncCall.value = false;
                            Get.back();
                            MyCommonMethods.showSnackBar(message: 'Something went wrong!', context: context);
                          }
                          inAsyncCall.value = false;
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:  EdgeInsets.symmetric(vertical: 10.px),
                              child: Text(
                                "${searchStateController.text.isNotEmpty ? statesListSearch[index].name : statesList?[index].name}",
                                style: Theme.of(Get.context!).textTheme.subtitle2?.copyWith(fontSize: 16.px, color: Theme.of(Get.context!).colorScheme.onSurface),
                              ),
                            ),
                            SizedBox(
                              height: 1.px,
                              child: Divider(
                                color: Theme.of(context).colorScheme.onSecondary,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },);
      },
    ).whenComplete(() {
      searchStateController.clear();
      statesListSearch.clear();
      MyCommonMethods.unFocsKeyBoard();
    });
  }

  clickOnCityTextField() {
    bottomSheetForCity();
  }

  void bottomSheetForCity(){
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: false,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 6.px),
            child: Column(
              children: [
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
                          borderRadius:
                          BorderRadius.all(Radius.circular(2.5.px)),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 6.px),
                CommonWidgets.commonTestFieldForSearch(
                  hintText: 'Search City',
                  labelText: 'Search City',
                  controller: searchCityController,
                  onChanged: (value) {
                    cityListSearch.clear();
                    if (value.isEmpty) {
                      return;
                    } else {
                      citiesList?.forEach((cityAllData) {
                        if (cityAllData.name!.toLowerCase().contains(value.toLowerCase().trim())) {
                          if (cityAllData.name?.toLowerCase().trim().contains(value.toLowerCase().trim()) != null) {
                            cityListSearch.add(cityAllData);
                          } else {
                            cityListSearch = [];
                          }
                        }
                      });
                      setState((){
                        count.value++;
                      });
                    }
                  },
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: searchCityController.text.isNotEmpty ? cityListSearch.length : citiesList?.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          inAsyncCall.value = true;
                          try{
                            if(searchCityController.text.isNotEmpty){
                              selectedCity.value = cityListSearch[index];
                              cityId = cityListSearch[index].id ?? '';
                              cityController.text=cityListSearch[index].name.toString();
                              if (cityListSearch[index].id != null) {
                                isCitySelectedValue.value = false;
                              }
                              Get.back();
                              setState((){count.value++;});
                            }
                            else{
                              selectedCity.value = citiesList?[index];
                              cityId = citiesList?[index].id ?? '';
                              cityController.text=citiesList?[index].name.toString()??'';
                              if (citiesList?[index].id != null) {
                                isCitySelectedValue.value = false;
                              }
                              Get.back();
                              setState((){count.value++;});
                            }
                          }catch(e){
                            inAsyncCall.value = false;
                            Get.back();
                            MyCommonMethods.showSnackBar(message: 'Something went wrong!', context: context);
                          }
                          inAsyncCall.value = false;
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:  EdgeInsets.symmetric(vertical: 10.px),
                              child: Text(
                                "${searchCityController.text.isNotEmpty ? cityListSearch[index].name : citiesList?[index].name}",
                                style: Theme.of(Get.context!).textTheme.subtitle2?.copyWith(fontSize: 16.px, color: Theme.of(Get.context!).colorScheme.onSurface),
                              ),
                            ),
                            SizedBox(
                              height: 1.px,
                              child: Divider(
                                color: Theme.of(context).colorScheme.onSecondary,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },);
      },
    ).whenComplete(() {
      searchCityController.clear();
      cityListSearch.clear();
      MyCommonMethods.unFocsKeyBoard();
    });

  }


}
