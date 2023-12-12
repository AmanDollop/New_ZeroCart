import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zerocart/my_responsive_sizer/src/extension.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/constant/zconstant.dart';
import 'package:zerocart/app/custom/scroll_splash_gone.dart';
import 'package:zerocart/app/modules/category/controllers/category_controller.dart';
import 'package:zerocart/my_colors/my_colors.dart';
import '../../../../model_progress_bar/model_progress_bar.dart';
import '../../../common_widgets/common_widgets.dart';
import '../../../custom/custom_appbar.dart';

class CategoryView extends GetView<CategoryController> {
  const CategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ModalProgress(
        inAsyncCall: controller.inAsyncCall.value,
        child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: const MyCustomContainer().myAppBar(
              text: 'Categories'
            ),
            body: Obx(
              () {
                if (CommonMethods.isConnect.value) {
                  if (controller.getCategories != null && controller.responseCode == 200) {
                    if (controller.listOfCategories.isNotEmpty || controller.tailor != null) {
                      return ScrollConfiguration(
                        behavior: MyBehavior(),
                        child: ListView(
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: [
                            if (controller.tailor != null)
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: Zconstant.margin, vertical: 4.px),
                                child: InkWell(
                                  onTap: () => controller.clickOnTailorCategory(context: context),
                                  borderRadius: BorderRadius.circular(6.px),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: Zconstant.margin - 10.px),
                                    decoration: BoxDecoration(
                                      color: Theme.of(Get.context!).brightness == Brightness.dark
                                              ? MyColorsLight().secondary.withOpacity(0.15)
                                              : MyColorsDark().secondary.withOpacity(0.03),
                                      borderRadius: BorderRadius.circular(6.px),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: Zconstant.margin - 12.px),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                controller.tailor?.categoryImage != null && controller.tailor!.categoryImage!.isNotEmpty
                                                    ? categoryImageView(
                                                    imageUrl: controller.tailor!.categoryImage.toString())
                                                    : CommonWidgets.defaultImage(height: 60.px, width: 64.px,),
                                                   SizedBox(width: Zconstant.margin - 8.px),
                                                  Flexible(
                                                    child: categoryTitleTextView(
                                                      title: controller.tailor?.name != null && controller.tailor!.name!.isNotEmpty
                                                          ?controller.tailor!.name.toString():'Tailor',
                                                    ),
                                                  ),
                                                if (controller.tailor?.name != null && controller.tailor!.name!.isNotEmpty)
                                                  SizedBox(width: Zconstant.margin - 8.px),
                                              ],
                                            ),
                                          ),
                                          arrowView(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            if (controller.listOfCategories.isNotEmpty)
                              categoriesListView(context: context),
                            SizedBox(height: 8.h),
                          ],
                        ),
                      );
                      /* return CommonWidgets.commonRefreshIndicator(
                        onRefresh: () => controller.onRefresh(),
                        child: RefreshLoadMore(
                          isLastPage: controller.isLastPage.value,
                          onLoadMore: () => controller.onLoadMore(),
                          child: ScrollConfiguration
                        ),
                      );*/
                    } else {
                      return CommonWidgets.commonNoDataFoundImage(
                        onRefresh: () => controller.onRefresh(),
                      );
                    }
                  } else {
                    if (controller.responseCode == 0) {
                      return const SizedBox();
                    }
                    return CommonWidgets.commonSomethingWentWrongImage(
                      onRefresh: () => controller.onRefresh(),
                    );
                  }
                } else {
                  return CommonWidgets.commonNoInternetImage(
                    onRefresh: () => controller.onRefresh(),
                  );
                }
              },
            )),
      );
    });
  }

  Widget backIconView() => Material(
        color: Colors.transparent,
        child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_back_ios_new_outlined,
                size: 18.px,
                color: Theme.of(Get.context!).textTheme.subtitle1?.color),
            splashRadius: 24.px),
      );

  Widget categoryTextView() => Text(
        'Categories',
        style: Theme.of(Get.context!).textTheme.subtitle1,
      );

  Widget categoriesListView({required BuildContext context}) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.listOfCategories.length,
        itemBuilder: (context, index) {
          controller.categories = controller.listOfCategories[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: Zconstant.margin, vertical: 4.px),
            child: InkWell(
              onTap: () => controller.clickOnCategory(index: index, context: context),
              borderRadius: BorderRadius.circular(6.px),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: Zconstant.margin - 10.px),
                decoration: BoxDecoration(
                  color: Theme.of(Get.context!).brightness == Brightness.dark
                      ? MyColorsLight().secondary.withOpacity(0.15)
                      : MyColorsDark().secondary.withOpacity(0.03),
                  borderRadius: BorderRadius.circular(6.px),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: Zconstant.margin - 12.px),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            categoryImageView(imageUrl: controller.categories!.categoryImage.toString()),
                            SizedBox(width: Zconstant.margin - 8.px),
                            Flexible(
                              child: categoryTitleTextView(
                                  title: controller.categories!.name.toString()),
                            ),
                            SizedBox(width: Zconstant.margin - 8.px),
                          ],
                        ),
                      ),
                      arrowView(),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget categoryImageView({required String imageUrl}) => FittedBox(
        child: Container(
          height: 60.px,
          width: 64.px,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.px),
          ),
          child: Image.network(
            CommonMethods.imageUrl(url: imageUrl),
            fit: BoxFit.cover,
            alignment: Alignment.center,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return CommonWidgets.commonShimmerViewForImage();
            },
            errorBuilder: (context, error, stackTrace) =>
                CommonWidgets.defaultImage(),
          ),
        ),
      );

  Widget categoryTitleTextView({required String title}) => Text(
        title,
        maxLines: 1,
        style: Theme.of(Get.context!).textTheme.subtitle1,
    overflow: TextOverflow.ellipsis,
      );

  Widget arrowView() => Icon(Icons.arrow_forward_ios_rounded,
      size: 14.px, color: Theme.of(Get.context!).textTheme.subtitle1?.color);
}
