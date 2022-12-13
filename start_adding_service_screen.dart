import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:insta_jamaica_provider/config/app_colors.dart';
import 'package:insta_jamaica_provider/config/app_routes.dart';
import 'package:insta_jamaica_provider/consts/app_consts.dart';
import 'package:insta_jamaica_provider/controller/setup_business_profile/add_services_controller.dart';
import 'package:insta_jamaica_provider/views/common/widgets/added_service_widget.dart';
import 'package:insta_jamaica_provider/views/common/widgets/common_app_bar.dart';
import 'package:insta_jamaica_provider/views/common/widgets/common_button.dart';

class StartAddingServiceScreen extends StatelessWidget {
  StartAddingServiceScreen({Key? key}) : super(key: key);
  final _addServiceController = Get.put(AddServicesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      appBar: CommonAppBar(
          title: 'start_adding_services'.tr,
          onBackTap: () {
            Get.back();
          }),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
                child: Text(
                  'start_adding_services_instructions'.tr,
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                      fontSize: AppConsts.commonFontSizeFactor * 12,
                      color: AppColors.color_B8),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(top: 0, bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return AddedServiceWidget(
                                service: _addServiceController.services[index],
                                onRemove: () {
                                 _addServiceController.deleteService(index);
                                },
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider(
                                color: AppColors.color_DA,
                              );
                            },
                            itemCount: _addServiceController.services.length),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: TextButton.icon(
                            onPressed: () {
                              Get.toNamed(AppRoutes.routeAddServiceScreen);
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                            label: Text(
                              "Add Service".tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  ?.copyWith(
                                      color: Colors.black,
                                      fontSize:
                                          AppConsts.commonFontSizeFactor * 15),
                            )),
                      ),
                      Divider(
                        color: AppColors.color_DA,
                        indent: 16,
                        endIndent: 16,
                        height: 0,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Obx(() => Visibility(
            visible: _addServiceController.isLoadingServices.value,
            child: Center(
                    child: CircularProgressIndicator(
                  color: AppColors.kPrimaryColor,
                )
            ) ,
          ))
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(top: 16,bottom: Platform.isIOS ? 32 : 16),
        child: CommonButton(text: 'continue'.tr, clickAction: () {
          Get.toNamed(AppRoutes.routeAllSetScreen);
        }),
      ),
    );
  }
}
