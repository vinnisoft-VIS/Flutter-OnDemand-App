import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_jamaica_customer/config/app_routes.dart';
import 'package:insta_jamaica_customer/consts/app_images.dart';
import 'package:insta_jamaica_customer/controller/home/home_controller.dart';
import 'package:insta_jamaica_customer/model/categories_res_model.dart';
import 'package:insta_jamaica_customer/views/widgets/category/category_widget.dart';
import 'package:insta_jamaica_customer/views/widgets/category/category_widget_shimmer.dart';

class HomeCatListWidget extends StatelessWidget {
  HomeCatListWidget({Key? key}) : super(key: key);

  final _homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 8,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 16)]),
      child: Obx(
        () => ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return _homeController.isLoadingCategories.value ? const CategoryWidgetShimmer():(index == 4
                  ? CategoryWidget(
                category: Category(categoryImage:  AppImages.imgSeeAll ,categoryName:'see_all' ),
                isFromAssets: true,
                onClick: (Category cateogry) {
                  Get.toNamed(AppRoutes.routeCategoriesScreen);
                },
              )
                  : CategoryWidget(
                category: _homeController.categories[index],
                onClick: (Category category) {
                  Get.toNamed(AppRoutes.routeBusinessListScreen, arguments: {
                    'title': category.categoryName,
                    'category_id':category.id

                  });
                },
              ));


            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                width: 16,
              );
            },
            itemCount: _homeController.isLoadingCategories.value
                ? 5
                : (_homeController.categories.length > 5
                    ? 5
                    : _homeController.categories.length)),
      ),
    );
  }
}
