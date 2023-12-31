import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zerocart/app/apis/api_constant/api_constant.dart';
import 'package:zerocart/app/apis/api_modals/user_data_modal.dart';
import 'package:zerocart/app/apis/common_apis/common_apis.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/routes/app_pages.dart';
import 'package:http/http.dart' as http;

import '../../../../my_common_method/my_common_method.dart';
import '../../../../my_firebase/my_firebase.dart';

class LoginController extends GetxController {
  final count = 0.obs;
  final keyNumber = GlobalKey<FormState>();
  final keyPassword = GlobalKey<FormState>();
  final absorbing=false.obs;
  final isLoginButtonClicked = false.obs;
  final isGoogleLoginButtonClicked = false.obs;
  final passwordVisible = false.obs;
  final mobileNumberController = TextEditingController();
  final passwordController = TextEditingController();

  Map<String, dynamic>  bodyParamsForSendOtp= {};
  Map<String, dynamic> sendOtpApiResponseMap = {};
  String otp = "";

  Map<String, dynamic> bodyParamsForLogin = {};
  final userData = Rxn<UserData?>();

  Map<String, dynamic>? userFirebaseData;
  Map<String, dynamic> bodyParamsForFirebaseSignIn = {};
  String deviceType = "";

  @override
  Future<void> onInit() async {
    super.onInit();
    deviceType = MyCommonMethods.getDeviceType();
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

  Future<void> sendOtpApiCalling({required String type}) async {
    bodyParamsForSendOtp = {
      ApiKeyConstant.mobile: mobileNumberController.text.trim().toString(),
      ApiKeyConstant.countryCode: "+91",
      ApiKeyConstant.type: type,
    };
    http.Response? response =
    await CommonApis.sendOtpApi(bodyParams: bodyParamsForSendOtp);
    if (response != null) {
      sendOtpApiResponseMap = jsonDecode(response.body);
      Get.toNamed(Routes.VERIFICATION, arguments: [
        1,
        "Login",
        sendOtpApiResponseMap[ApiKeyConstant.otp],
        "login",
        mobileNumberController.text.trim().toString()
      ]);
    }
  }

  Future<void> callLoginApi() async {
    userData.value = null;
    bodyParamsForLogin = {
      ApiKeyConstant.emailPhone: mobileNumberController.text.trim().toString(),
      ApiKeyConstant.password: passwordController.text.trim().toString(),
      ApiKeyConstant.deviceType: deviceType
    };
    userData.value = await CommonApis.loginApi(bodyParams: bodyParamsForLogin);
    if (userData.value != null) {
      Get.offAllNamed(Routes.NAVIGATOR_BOTTOM_BAR);
    }
    isLoginButtonClicked.value = false;

  }

  Future<void> signInWithGoogleApiCalling() async {
    userData.value = null;
    bodyParamsForFirebaseSignIn = {
      ApiKeyConstant.fullName: userFirebaseData!["name"],
      // ApiKeyConstant.email: userFirebaseData!["email"],
      ApiKeyConstant.loginType: "Google",
      ApiKeyConstant.accessToken: userFirebaseData?["accessToken"],
    };
    userData.value = await CommonApis.signInWithGoogle(bodyParams: bodyParamsForFirebaseSignIn);
    if (userData.value != null) {
      await MyCommonMethods.setString(key: ApiKeyConstant.uuid, value: userData.value!.customer!.uuid!);
      if (userData.value?.customer?.isRegister == "1") {
        await MyCommonMethods.setString(key:ApiKeyConstant.token,value: userData.value!.customer!.token.toString());
        await MyCommonMethods.setString(key: ApiKeyConstant.customerId, value: userData.value?.customer?.customerId.toString() ?? "");
        await MyCommonMethods.setString(key: UserDataKeyConstant.selectedCity, value: userData.value?.customer?.cityName ?? "");
        await MyCommonMethods.setString(key: UserDataKeyConstant.selectedState, value: userData.value?.customer?.stateName ?? "");
        await MyCommonMethods.setString(key: UserDataKeyConstant.selectedState, value: userData.value?.customer?.countryId ?? "");
        await MyCommonMethods.setString(key: UserDataKeyConstant.selectedState, value: userData.value?.customer?.stateId ?? "");
        await MyCommonMethods.setString(key: UserDataKeyConstant.fullName, value: userData.value?.customer?.fullName ?? "");
        await MyCommonMethods.setString(key: UserDataKeyConstant.walletAmount, value: userData.value?.customer?.walletAmount ?? "");
        Get.offAllNamed(Routes.NAVIGATOR_BOTTOM_BAR);
        MyCommonMethods.showSnackBar(message: "Login Successfully", context: Get.context!);

      } else {
        mobileNumberController.clear();
        passwordController.clear();
        passwordVisible.value = false;
        Get.toNamed(Routes.REGISTRATION, arguments: userFirebaseData);
      }
    }
  }

  void clickOnEyeButton() {
    passwordVisible.value = !passwordVisible.value;
  }

  Future<void> clickOnSendOtpButton() async {
    absorbing.value = CommonMethods.changeTheAbsorbingValueTrue();
    MyCommonMethods.unFocsKeyBoard();
    if(keyNumber.currentState!.validate())
      {
        try{
          await sendOtpApiCalling(type: "login");
        }catch(e){
          MyCommonMethods.showSnackBar(message: 'Something went wrong!', context: Get.context!);
          absorbing.value = CommonMethods.changeTheAbsorbingValueFalse();
        }
      }
    absorbing.value = CommonMethods.changeTheAbsorbingValueFalse();
  }

  void clickOnForgotPasswordButton() {
    absorbing.value = CommonMethods.changeTheAbsorbingValueTrue();
    mobileNumberController.text="";
    passwordController.text="";
    MyCommonMethods.unFocsKeyBoard();
    Get.toNamed(Routes.FORGOT_PASSWORD);
    absorbing.value = CommonMethods.changeTheAbsorbingValueFalse();
  }

  Future<void> clickOnLoginButton() async {
    absorbing.value = CommonMethods.changeTheAbsorbingValueTrue();
    MyCommonMethods.unFocsKeyBoard();
    if (keyNumber.currentState!.validate() && keyPassword.currentState!.validate()) {
      isLoginButtonClicked.value = true;
      try{
        await callLoginApi();
      }catch(e){
        MyCommonMethods.showSnackBar(message: 'Something went wrong!', context: Get.context!);
        isLoginButtonClicked.value = false;
        absorbing.value = CommonMethods.changeTheAbsorbingValueFalse();
      }
    }
    isLoginButtonClicked.value = false;
    absorbing.value = CommonMethods.changeTheAbsorbingValueFalse();
  }

  Future<void> clickOnLoginWithGoogleButton() async {
    absorbing.value = CommonMethods.changeTheAbsorbingValueTrue();
    MyCommonMethods.unFocsKeyBoard();
    isGoogleLoginButtonClicked.value = true;
    try{
      userFirebaseData = await MyFirebaseSignIn.signInWithGoogle(context: Get.context!).whenComplete((){
        isGoogleLoginButtonClicked.value = false;
        absorbing.value = CommonMethods.changeTheAbsorbingValueFalse();
      });
      if (userFirebaseData != null) {
        await signInWithGoogleApiCalling();
      }
    }catch(e){
      MyCommonMethods.showSnackBar(message: 'Something went wrong!', context: Get.context!);
      isGoogleLoginButtonClicked.value = false;
      absorbing.value = CommonMethods.changeTheAbsorbingValueFalse();
    }
    isGoogleLoginButtonClicked.value = false;
    absorbing.value = CommonMethods.changeTheAbsorbingValueFalse();
  }

}
