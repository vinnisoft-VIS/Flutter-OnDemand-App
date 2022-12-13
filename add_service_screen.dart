import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_jamaica_provider/config/app_colors.dart';
import 'package:insta_jamaica_provider/consts/app_consts.dart';
import 'package:insta_jamaica_provider/controller/setup_business_profile/add_services_controller.dart';
import 'package:insta_jamaica_provider/utils/helpers.dart';
import 'package:insta_jamaica_provider/utils/validations.dart';
import 'package:insta_jamaica_provider/views/common/widgets/common_app_bar.dart';
import 'package:insta_jamaica_provider/views/common/widgets/common_button.dart';
import 'package:insta_jamaica_provider/views/common/widgets/common_input_field.dart';

class AddServiceScreen extends StatelessWidget {
  AddServiceScreen({Key? key}) : super(key: key);
  final _addServiceController = Get.find<AddServicesController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Helpers.hideKeyboard();
      },
      child: Scaffold(
        backgroundColor: AppColors.appBackgroundColor,
        appBar: CommonAppBar(
            title: 'add_service'.tr,
            onBackTap: () {
              Get.back();
            }),
        body: Form(
          key: _addServiceController.formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                child: Text(
                  'add_service_description'.tr,
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                      fontSize: AppConsts.commonFontSizeFactor * 15,
                      color: AppColors.color_B8),
                ),
              ),
              CommonInputField(
                  controller: _addServiceController.serviceNameController,
                  hint: 'service_name'.tr,
                  showFloatingLabel: true,
                  validator: Validations.checkEmptyFieldValidation),
              CommonInputField(
                  controller: _addServiceController.serviceDurationController,
                  hint: 'duration'.tr,
                  isEnable: true,
                  showFloatingLabel: true,
                  maxLength: 3,
                  trailing: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text("mins".tr,style: Theme.of(context).textTheme.headline5?.copyWith(
                      fontSize: AppConsts.commonFontSizeFactor *16,
                      color: AppColors.textColorPrimary
                    ),),
                  ),
                  validator: Validations.checkEmptyFieldValidation),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CommonInputField(
                        controller:
                            _addServiceController.servicePriceTypeController,
                        hint: 'price_type'.tr,
                        isEnable: false,
                        showFloatingLabel: true,
                        marginRight: 8,
                        validator: Validations.checkEmptyFieldValidation),
                  ),
                  Expanded(
                    child: CommonInputField(
                        controller: _addServiceController.servicePriceController,
                        hint: 'price'.tr,
                        isEnable: true,
                        showFloatingLabel: true,
                        marginLeft: 8,
                        maxLength: 5,
                        leading: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Container(
                            height: 51,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('\$',style: Theme.of(context).textTheme.headline5?.copyWith(
                                  fontSize: AppConsts.commonFontSizeFactor *15,
                                  color: AppColors.textColorPrimary
                                ),),
                             const SizedBox(width: 10,),
                              const  VerticalDivider(
                                indent: 8,
                                  width: 1,
                                endIndent: 10,
                                )
                              ],
                            ),
                          ),
                        ),
                        validator: Validations.checkEmptyFieldValidation),
                  )
                ],
              )
            ],

          ),
        ),
        bottomNavigationBar: Obx(
              ()=> _addServiceController.isLoadingAddService.value?
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  height: 71,
                  width: 71,
                  margin: EdgeInsets.only(top: 16,bottom: Platform.isIOS ? 32 : 16),
                  padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
                  child: const CircularProgressIndicator()),
            ],
          ):
          Padding(
            padding: EdgeInsets.only(top: 16,bottom: Platform.isIOS ? 32 : 16),
            child: CommonButton(text: 'continue'.tr, clickAction: (){
              _addServiceController.createService();
            }),
          ),
        ),
      ),
    );
  }
}
