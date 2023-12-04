import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zerocart/app/apis/api_modals/sub_categories_model.dart';
import 'package:zerocart/app/custom/dropdown_zerocart.dart';
import 'package:zerocart/my_responsive_sizer/src/extension.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/common_widgets/common_widgets.dart';
import 'package:zerocart/app/custom/scroll_splash_gone.dart';
import 'package:zerocart/my_colors/my_colors.dart';
import '../../../../model_progress_bar/model_progress_bar.dart';
import '../controllers/outfit_room_controller.dart';

class OutfitRoomView extends GetView<OutfitRoomController> {
  const OutfitRoomView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      Get.lazyPut(()=>OutfitRoomController());
      controller.count.value;
      return ModalProgress(
        inAsyncCall: controller.inAsyncCall.value,
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: appBarView(),
          body: Obx(
            () {
              controller.count.value;
              if (CommonMethods.isConnect.value) {
                /* if (controller.getOutfitListApiModel != null || controller.getCollectionListApiModel != null && controller.responseCode == 200) {
                  if (controller.outfitList.isNotEmpty || controller.collectionList.isNotEmpty) {
                    return CommonWidgets.commonRefreshIndicator(
                      onRefresh: () => controller.onRefresh(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15.px),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.px,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ScrollConfiguration(
                                    behavior: MyBehavior(),
                                    child: SizedBox(
                                      width: 115.px,
                                      child: ListView(
                                        shrinkWrap: true,
                                        padding: EdgeInsets.zero,
                                        physics: const ScrollPhysics(),
                                        children: [
                                          controller.upperImagePath.value.isNotEmpty
                                              ? InkWell(
                                                  onTap: () => controller.clickOnUpperImage(),
                                                  borderRadius: BorderRadius.circular(5.px),
                                                  child: upperImageView())
                                              : commonConAddImage(
                                                  height: 115.px,
                                                  width: 112.px,
                                                  onTapAddImage: () => controller.clickOnUpperImage()),
                                          SizedBox(height: 12.px),
                                          controller.lowerImagePath.value
                                                  .isNotEmpty
                                              ? InkWell(
                                                  onTap: () => controller.clickOnLowerImage(),
                                                  borderRadius: BorderRadius.circular(5.px),
                                                  child: lowerImageView())
                                              : commonConAddImage(
                                                  height: 115.px,
                                                  width: 112.px,
                                                  onTapAddImage: () => controller.clickOnLowerImage()),
                                          SizedBox(height: 12.px),
                                          controller.shoeImagePath.value
                                                  .isNotEmpty
                                              ? InkWell(
                                                  onTap: () => controller.clickOnShoeImage(),
                                                  borderRadius: BorderRadius.circular(5.px),
                                                  child: shoeImageView())
                                              : commonConAddImage(
                                                  height: 115.px,
                                                  width: 112.px,
                                                  onTapAddImage: () => controller.clickOnShoeImage())
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 18.px),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: ScrollConfiguration(
                                            behavior: MyBehavior(),
                                            child: GridView.builder(
                                              itemCount: controller.accessoriesImageList.length + 1,
                                              shrinkWrap: true,
                                              padding: EdgeInsets.only(left: 16.px),
                                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 4.px, crossAxisSpacing: 4.px),
                                              itemBuilder: (context, index) {
                                                if (index < controller.accessoriesImageList.length) {
                                                  return commonImage(
                                                    imagePath: controller.accessoriesImageList[index].toString(),
                                                    onTapCrossImage: () => controller.clickOnAccessoriesRemoveImage(index: index),
                                                  );
                                                } else {
                                                  // if(controller.accessoriesImageList.isEmpty) {
                                                  return commonConAddImage(
                                                    onTapAddImage: () => controller.clickOnGridViewAddImage(),
                                                  );
                                                  // }
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              SizedBox(height: 12.px),
                                              if (controller.bottomHeight != 0.0)
                                                saveButton(),
                                              SizedBox(height: 8.px),
                                              if (controller.outfitList.isNotEmpty)
                                                addToCartButtonView(),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (controller.collectionListUpper.isNotEmpty || controller.collectionListLower.isNotEmpty || controller.collectionListShoe.isNotEmpty || controller.collectionListAccessories.isNotEmpty)
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.px),
                              child: SizedBox(
                                height: 80.px,
                                //flex: 2,
                                child: controller.upperImageViewValue1.value
                                    ? commonListViewBuilderForUpper()
                                    : controller.lowerImageViewValue1.value
                                        ? commonListViewBuilderForLower()
                                        : controller.shoeImageViewValue1.value
                                            ? commonListViewBuilderForShoe()
                                            : controller.accessoriesImageViewValue1.value
                                                ? commonListViewBuilderForAccessories()
                                                : const SizedBox(),
                              ),
                            ),
                          SizedBox(height: controller.bottomHeight),
                        ],
                      ),
                    );
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
                }*/
                return CommonWidgets.commonRefreshIndicator(
                  onRefresh: () => controller.onRefresh(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15.px),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.px,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ScrollConfiguration(
                                behavior: MyBehavior(),
                                child: SizedBox(
                                  width: 115.px,
                                  child: ListView(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    physics: const ScrollPhysics(),
                                    children: [
                                      controller.upperImagePath.value.isNotEmpty
                                          ? InkWell(
                                          onTap: () => controller.clickOnUpperImage(),
                                          borderRadius: BorderRadius.circular(5.px),
                                          child: upperImageView())
                                          : commonConAddImage(
                                          height: 115.px,
                                          width: 112.px,
                                          onTapAddImage: () => controller.clickOnUpperImage()),
                                      SizedBox(height: 12.px),
                                      controller.lowerImagePath.value
                                          .isNotEmpty
                                          ? InkWell(
                                          onTap: () => controller.clickOnLowerImage(),
                                          borderRadius: BorderRadius.circular(5.px),
                                          child: lowerImageView())
                                          : commonConAddImage(
                                          height: 115.px,
                                          width: 112.px,
                                          onTapAddImage: () => controller.clickOnLowerImage()),
                                      SizedBox(height: 12.px),
                                      controller.shoeImagePath.value
                                          .isNotEmpty
                                          ? InkWell(
                                          onTap: () => controller.clickOnShoeImage(),
                                          borderRadius: BorderRadius.circular(5.px),
                                          child: shoeImageView())
                                          : commonConAddImage(
                                          height: 115.px,
                                          width: 112.px,
                                          onTapAddImage: () => controller.clickOnShoeImage())
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 18.px),
                              Expanded(
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ScrollConfiguration(
                                        behavior: MyBehavior(),
                                        child: GridView.builder(
                                          itemCount: controller.accessoriesImageList.length + 1,
                                          shrinkWrap: true,
                                          padding: EdgeInsets.only(left: 16.px),
                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 4.px, crossAxisSpacing: 4.px),
                                          itemBuilder: (context, index) {
                                            if (index < controller.accessoriesImageList.length) {
                                              return commonImage(
                                                imagePath: controller.accessoriesImageList[index].toString(),
                                                onTapCrossImage: () => controller.clickOnAccessoriesRemoveImage(index: index),
                                              );
                                            } else {
                                              // if(controller.accessoriesImageList.isEmpty) {
                                              return commonConAddImage(
                                                onTapAddImage: () => controller.clickOnGridViewAddImage(),
                                              );
                                              // }
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          SizedBox(height: 12.px),
                                          if (controller.bottomHeight != 0.0)
                                             saveButton(),
                                          SizedBox(height: 8.px),
                                          if (controller.outfitList.isNotEmpty)
                                             addToCartButtonView(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (controller.collectionListUpper.isNotEmpty || controller.collectionListLower.isNotEmpty || controller.collectionListShoe.isNotEmpty || controller.collectionListAccessories.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.px),
                          child: SizedBox(
                            height: 80.px,
                            //flex: 2,
                            child: controller.upperImageViewValue1.value
                                ? commonListViewBuilderForUpper()
                                : controller.lowerImageViewValue1.value
                                ? commonListViewBuilderForLower()
                                : controller.shoeImageViewValue1.value
                                ? commonListViewBuilderForShoe()
                                : controller.accessoriesImageViewValue1.value
                                ? commonListViewBuilderForAccessories()
                                : const SizedBox(),
                          ),
                        ),
                      SizedBox(height: controller.bottomHeight),
                    ],
                  ),
                );
              } else {
               return CommonWidgets.commonNoInternetImage(
                  onRefresh: () => controller.onRefresh(),
                );
              }
            },
          ),
        ),
      );
    });
  }

  PreferredSizeWidget appBarView() => AppBar(
    automaticallyImplyLeading: false,
    elevation: 0,
    shadowColor:
    Theme.of(Get.context!).scaffoldBackgroundColor.withOpacity(.4),
    centerTitle: false,
    leadingWidth:  0.px,
    backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,

    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(flex: 8,child: appBarTitleTextView(text: 'Outfit Room')),
        if(controller.subCategoriesList != null && controller.subCategoriesList!.isNotEmpty)
        Flexible(flex: 2,child: categoriesDropdown(),),
      ],
    ),
  );

  Widget appBarTitleTextView({required String text}) => Text(
    text,
    style: Theme.of(Get.context!).textTheme.subtitle1,
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
  );

  Widget categoriesDropdown() {
    return Container(
      height: 35.px,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(6.px)
      ),
      padding: EdgeInsets.symmetric(horizontal: 4.px),
      child: Center(
        child: DropdownZeroCart<SubCategories>(
          wantDivider: false,
          hint: Text(
            "Select type",
            style:
            Theme.of(Get.context!).textTheme.caption?.copyWith(fontSize: 10.px),
          ),
          icon: Icon(Icons.keyboard_arrow_down_rounded,
              color: MyColorsLight().onText, size: 18.px),
          selected: controller.subCategories,
          items: controller.subCategoriesList!.map((SubCategories? e) => DropdownMenuItem<SubCategories>(
              value: e,
              child: Text(
                e?.subCategoryName.toString()??'',
                overflow: TextOverflow.ellipsis,
                style: Theme.of(Get.context!).textTheme.caption?.copyWith(fontSize: 10.px),
              ),
            ),
          ).toList(),
          onChanged: (value) async {
            controller.subCategories = value;
            print('value.subCategories:::::::   ${value.subCategoryId}');
            // await controller.getCollectionListApi(queryParametersCollectionList: {'subCategoryId' : controller.subCategories?.subCategoryId.toString()});
            await controller.clearAllData(accessoriesImageListValue: true);
            controller.queryParametersCollectionList = {'subCategoryId' : controller.subCategories?.subCategoryId.toString()};
            await controller.getCollectionListApi();
          },
        ),
      ),
    );
  }

  /*PreferredSizeWidget appBarView() => const MyCustomContainer().myAppBar(
        text: 'Outfit Room',
        isIcon: controller.bottomHeight == 0.0 ? true : false,
        backIconOnPressed: () => controller.clickOnBackIcon(),
      );*/

  Widget upperImageView() => commonImage(
        height: 115.px,
        width: 112.px,
        imagePath: controller.upperImagePath.value.toString(),
        onTapCrossImage: () => controller.clickOnUpperRemoveImage(),
      );

  Widget lowerImageView() => commonImage(
        height: 115.px,
        width: 112.px,
        imagePath: controller.lowerImagePath.value.toString(),
        onTapCrossImage: () => controller.clickOnLowerRemoveImage(),
      );

  Widget shoeImageView() => commonImage(
        height: 115.px,
        width: 112.px,
        imagePath: controller.shoeImagePath.value.toString(),
        onTapCrossImage: () => controller.clickOnShoeRemoveImage(),
      );

  Widget saveButton() => CommonWidgets.myOutlinedButton(
      text: Text(
        'Save',
        style: Theme.of(Get.context!).textTheme.headline3,
      ),
      onPressed: () => controller.clickOnSaveButton(),
      radius: 5.px,
      height: 40.px,
      margin: EdgeInsets.zero,
      width: 120.px);

  Widget addToCartButtonView() {
    if (!controller.isAddToCartButtonClicked.value) {
      return CommonWidgets.myElevatedButton(
          text: Text(
            'Add to cart',
            style: Theme.of(Get.context!).textTheme.headline3?.copyWith(color: MyColorsLight().secondary),
          ),
          onPressed: () => controller.clickOnAddToCartButton(),
          borderRadius: 5.px,
          height: 40.px,
          margin: EdgeInsets.zero,
          width: 120.px);
    } else {
      return CommonWidgets.myElevatedButton(
          text: SizedBox(
              height: 20.px,
              width: 20.px,
              child: CommonWidgets.buttonProgressBarView()),
          // ignore: avoid_returning_null_for_void
          onPressed: () => null,
          borderRadius: 5.px,
          height: 40.px,
          margin: EdgeInsets.zero,
          width: 120.px);
    }
  }

  Widget commonImage({
    required String imagePath,
    required GestureTapCallback onTapCrossImage,
    double? width,
    double? height,
  }) => Stack(
        alignment: Alignment.topRight,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5.px),
            child: SizedBox(
              width: width ?? double.infinity,
              height: height ?? 115.px,
              child: Image.network(
                imagePath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return CommonWidgets.commonShimmerViewForImage();
                },
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset('assets/default_image.jpg',fit: BoxFit.cover,);
                },
              ),
            ),
          ),
          commonCrossIconView(onTapCrossImage: onTapCrossImage)
        ],
      );

  Widget commonCrossIconView({required GestureTapCallback onTapCrossImage}) => Padding(
        padding: EdgeInsets.all(4.px),
        child: InkWell(
          onTap: onTapCrossImage,
          child: Container(
            height: 16.px,
            width: 16.px,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.px),
              color: MyColorsLight().greyColor,
            ),
            child: Icon(Icons.close, color: MyColorsLight().onText, size: 8.px),
          ),
        ),
      );

  Widget commonAddIconView() => Padding(
        padding: EdgeInsets.all(4.px),
        child: Container(
          height: 16.px,
          width: 16.px,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.px),
            color: MyColorsLight().greyColor,
          ),
          child: Icon(Icons.add, color: MyColorsLight().onText, size: 8.px),
        ),
      );

  Widget commonImageForHorizontalList({required String imagePath}) => ClipRRect(
        borderRadius: BorderRadius.circular(5.px),
        child: SizedBox(
          width: 80.px,
          height: 80.px,
          child: Image.network(
            imagePath,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return CommonWidgets.commonShimmerViewForImage();
            },
            errorBuilder: (context, error, stackTrace) {
              return Image.asset('assets/default_image.jpg',fit: BoxFit.cover,);
            },
          ),
        ),
      );

  Widget commonImageForHorizontalListBorder({required String imagePath}) =>
      CommonWidgets.myOutlinedButton(
        text: ClipRRect(
          borderRadius: BorderRadius.circular(5.px),
          child: SizedBox(
            width: 80.px,
            height: 80.px,
            child: Image.network(
              imagePath,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return CommonWidgets.commonShimmerViewForImage();
              },
              errorBuilder: (context, error, stackTrace) {
                return Image.asset('assets/default_image.jpg',fit: BoxFit.cover,);
              },
            ),
          ),
        ),
        onPressed: () {},
        radius: 5.px,
        wantFixedSize: false,
        width: 88.px,
        margin: EdgeInsets.zero,
        strokeWidth: 2,
        padding: EdgeInsets.all(4.px),
        height: 88.px,
      );

  Widget commonConAddImage({required GestureTapCallback onTapAddImage, double? height, double? width}) => InkWell(
        onTap: onTapAddImage,
        borderRadius: BorderRadius.circular(5.px),
        child: Container(
          width: 115.px,
          height: 115.px,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.px),
              color: MyColorsLight().onPrimary.withOpacity(.3)),
          child: Center(
            child: commonAddIconView(),
          ),
        ),
      );

  Widget commonListViewBuilderForUpper() {
    if (controller.collectionListUpper.isNotEmpty) {
      return ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView.builder(
            itemCount: controller.collectionListUpper.length,
            physics: const ScrollPhysics(),
            itemBuilder: (context, index) {
              return Obx(() {
                controller.count.value;
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.px),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(5.px),
                          onTap: () => controller.clickOnListHorizontalOfUpperImage(index: index),
                          child:
                              controller.inventoryIdUpper == controller.collectionListUpper[index].inventoryId
                                  ? commonImageForHorizontalListBorder(
                                      imagePath: CommonMethods.imageUrl(url: controller.collectionListUpper[index].thumbnailImage.toString()),
                                    )
                                  : commonImageForHorizontalList(
                                      imagePath: CommonMethods.imageUrl(url: controller.collectionListUpper[index].thumbnailImage.toString()),
                                    ),
                        ),
                      ),
                      commonCrossIconView(
                        onTapCrossImage: () => controller.clickOnListHorizontalOfUpperImageCross(index: index),
                      )
                    ],
                  ),
                );
              });
            },
            scrollDirection: Axis.horizontal,
            shrinkWrap: true),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget commonListViewBuilderForLower() {
    if (controller.collectionListLower.isNotEmpty) {
      return ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView.builder(
            itemCount: controller.collectionListLower.length,
            physics: const ScrollPhysics(),
            itemBuilder: (context, index) {
              return Obx(() {
                controller.count.value;
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.px),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(5.px),
                          onTap: () => controller.clickOnListHorizontalOfLowerImage(index: index),
                          child: /*controller.currentIndexOfLowerImageList.value == index*/
                          controller.inventoryIdLower == controller.collectionListLower[index].inventoryId
                                  ? commonImageForHorizontalListBorder(
                                      imagePath: CommonMethods.imageUrl(url: controller.collectionListLower[index].thumbnailImage.toString()),
                                    )
                                  : commonImageForHorizontalList(
                                      imagePath: CommonMethods.imageUrl(url: controller.collectionListLower[index].thumbnailImage.toString()),
                                    ),
                        ),
                      ),
                      commonCrossIconView(
                        onTapCrossImage: () => controller.clickOnListHorizontalOfLowerImageCross(index: index),
                      )
                    ],
                  ),
                );
              });
            },
            scrollDirection: Axis.horizontal,
            shrinkWrap: true),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget commonListViewBuilderForShoe() {
    if (controller.collectionListShoe.isNotEmpty) {
      return ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView.builder(
            itemCount: controller.collectionListShoe.length,
            physics: const ScrollPhysics(),
            itemBuilder: (context, index) {
              return Obx(() {
                controller.count.value;
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.px),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(5.px),
                          onTap: () => controller
                              .clickOnListHorizontalOfShoeImage(index: index),
                          child: /*controller.currentIndexOfShoeImageList.value == index*/
                          controller.inventoryIdShoe == controller.collectionListShoe[index].inventoryId
                              ? commonImageForHorizontalListBorder(
                                  imagePath: CommonMethods.imageUrl(url: controller.collectionListShoe[index].thumbnailImage.toString()),
                                )
                              : commonImageForHorizontalList(
                                  imagePath: CommonMethods.imageUrl(url: controller.collectionListShoe[index].thumbnailImage.toString()),
                                ),
                        ),
                      ),
                      commonCrossIconView(
                        onTapCrossImage: () => controller.clickOnListHorizontalOfShoeImageCross(index: index),
                      )
                    ],
                  ),
                );
              });
            },
            scrollDirection: Axis.horizontal,
            shrinkWrap: true),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget commonListViewBuilderForAccessories() {
    if (controller.collectionListAccessories.isNotEmpty) {
      return ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView.builder(
          itemCount: controller.collectionListAccessories.length,
          physics: const ScrollPhysics(),
          itemBuilder: (context, index) {
            return Obx(() {
              controller.count.value;
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.px),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(5.px),
                        onTap: () => controller.clickOnListHorizontalOfAccessoriesImage(index: index),
                        child: controller.accessoriesImageListIds.contains(controller.collectionListAccessories[index].inventoryId.toString())
                            ? commonImageForHorizontalListBorder(
                                imagePath: CommonMethods.imageUrl(url: controller.collectionListAccessories[index].thumbnailImage.toString()),
                              )
                            : commonImageForHorizontalList(
                                imagePath: CommonMethods.imageUrl(
                                    url: controller.collectionListAccessories[index].thumbnailImage.toString()),
                              ),
                      ),
                    ),
                    commonCrossIconView(
                      onTapCrossImage: () => controller.clickOnListHorizontalOfAccessoriesImageCross(index: index),
                    )
                  ],
                ),
              );
            });
          },
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
