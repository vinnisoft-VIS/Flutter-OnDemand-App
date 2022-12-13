import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_jamaica_provider/config/app_colors.dart';
import 'package:insta_jamaica_provider/controller/setup_business_profile/choose_category_controller.dart';
import 'package:insta_jamaica_provider/model/categories_res_model.dart';
import 'package:insta_jamaica_provider/views/common/widgets/business_category_list_cell.dart';
import 'package:insta_jamaica_provider/views/common/widgets/common_app_bar.dart';

class ChooseBusinessCategoryScreen extends StatelessWidget {
  ChooseBusinessCategoryScreen({Key? key}) : super(key: key);

  final _chooseCategoryController = Get.put(ChooseCategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      appBar: CommonAppBar(
          title: 'choose_your_business_category'.tr,
          onBackTap: () {
            Get.back();
          }),
      body: Obx(
          ()=> _chooseCategoryController.isLoading.value ? Center(child: CircularProgressIndicator()) :

              ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 16),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return BusinessCategoryListCell(
                category: _chooseCategoryController.categories[index],
                selectedCategory: (Category category) {
                  _chooseCategoryController.setSelectedCategory(category);
                },
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: _chooseCategoryController.categories.length),
      ),
    );
  }
}
