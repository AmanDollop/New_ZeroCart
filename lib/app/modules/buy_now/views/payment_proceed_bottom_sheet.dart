import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zerocart/my_responsive_sizer/src/extension.dart';
import 'package:zerocart/app/common_widgets/common_widgets.dart';
import 'package:zerocart/app/modules/buy_now/controllers/buy_now_controller.dart';
import 'package:zerocart/my_colors/my_colors.dart';

class PaymentProceedBuyNow extends GetView<BuyNowController> {
  const PaymentProceedBuyNow({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      print("${controller.count.value}");
      return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        color: MyColorsLight().dashMenuColor,
                        borderRadius: BorderRadius.all(Radius.circular(2.5.px)),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 1.5.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.px),
                    child: Text(
                      "Payment Methods",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  walletRadioButtonView(
                    context: context,
                      value: controller.wallets.value,
                      groupValue: controller.paymentMethod.value,
                      title: textViewDebitCreditCard(text: 'Wallets',context: context)),
                  Center(
                    child: dividerForBottomSheet(),
                  ),
                  cashOnDeliveryRadioButtonView(
                      context: context,
                      value: controller.cashOnDelivery.value,
                      groupValue: controller.paymentMethod.value,
                      title: textViewDebitCreditCard(text: 'Cash On Delivery',context: context)),
                  Center(
                    child: dividerForBottomSheet(),
                  ),
                  othersRadioButtonView(
                      context: context,
                      value: controller.others.value,
                      groupValue: controller.paymentMethod.value,
                      title: textViewDebitCreditCard(text: 'Others',context: context)),
                  Center(
                    child: dividerForBottomSheet(),
                  ),
                  SizedBox(height: 4.h),
                  Obx(() => Center(
                        child: CommonWidgets.myElevatedButton(
                            height: 42.px,
                            width: 80.w,
                            borderRadius: 5.px,
                            text: controller.isClickOnProceedToCheckOut.value
                                ? CommonWidgets.buttonProgressBarView()
                                : Text(
                                    style: Theme.of(Get.context!)
                                        .textTheme
                                        .subtitle1
                                        ?.copyWith(
                                            fontSize: 14.px,
                                            color: MyColorsLight().secondary),
                                    "PROCEED TO CHECKOUT"),
                            onPressed: () =>
                                controller.isClickOnProceedToCheckOut.value
                                    ? null
                                    : controller.clickOnProceedToCheckout()),
                      )),
                  SizedBox(height: 4.h),
                ],
              ),
            ],
          ),
        ],
      );
    });
  }

  Widget textViewDebitCreditCard({required String text,required BuildContext context}) => Text(
        text,
        style: Theme.of(context)
            .textTheme
            .subtitle1
            ?.copyWith(fontSize: 14.px,),
      );

  Widget dividerForBottomSheet() => SizedBox(
      width: 90.w,
      child:
          CommonWidgets.profileMenuDash(color: MyColorsLight().dashMenuColor));

  Widget walletRadioButtonView(
          {required final value,
          required final groupValue,
          required Widget title,
          required BuildContext context}) =>
      Theme(
        data: Theme.of(context).copyWith(
          unselectedWidgetColor: MyColorsLight().onText.withOpacity(.4),
        ),
        child: RadioListTile(
          // tileColor: Colors.grey.withOpacity(0.4),
          title: title,
          activeColor: Theme.of(context).primaryColor,
          value: value,
          groupValue: groupValue,
          onChanged: (value) {
            controller.paymentMethod.value = value;
          },
        ),
      );

  Widget cashOnDeliveryRadioButtonView(
          {required final value,
          required final groupValue,
          required Widget title, required BuildContext context}) =>
      Theme(
        data: Theme.of(context).copyWith(
          unselectedWidgetColor: MyColorsLight().onText.withOpacity(.4),
        ),
        child: RadioListTile(
          //tileColor: Colors.grey.withOpacity(0.4),
          title: title,
          activeColor: Theme.of(context).primaryColor,
          value: value,
          groupValue: groupValue,
          onChanged: (value) {
            controller.paymentMethod.value = value;
          },
        ),
      );

  Widget othersRadioButtonView(
          {required final value,
          required final groupValue,
          required Widget title, required BuildContext context}) =>
      Theme(
        data: Theme.of(context).copyWith(
          unselectedWidgetColor: MyColorsLight().onText.withOpacity(.4),
        ),
        child: RadioListTile(
          // tileColor: Colors.grey.withOpacity(0.4),
          title: title,
          activeColor: Theme.of(context).primaryColor,
          value: value,
          groupValue: groupValue,
          onChanged: (value) {
            controller.paymentMethod.value = value;
          },
        ),
      );
}
