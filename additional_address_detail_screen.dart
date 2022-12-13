import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_jamaica_provider/config/app_colors.dart';
import 'package:insta_jamaica_provider/consts/app_consts.dart';
import 'package:insta_jamaica_provider/controller/setup_business_profile/additional_address_detail_controller.dart';
import 'package:insta_jamaica_provider/utils/validations.dart';
import 'package:insta_jamaica_provider/views/common/widgets/common_app_bar.dart';
import 'package:insta_jamaica_provider/views/common/widgets/common_button.dart';
import 'package:insta_jamaica_provider/views/common/widgets/common_input_field.dart';

class AdditionalAddressDetailScreen extends StatelessWidget {
  AdditionalAddressDetailScreen({Key? key}) : super(key: key);

  final _additionalAddressDetailController =
      Get.put(AdditionalAddressDetailController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.appBackgroundColor,
        appBar: CommonAppBar(
            title: 'confirm_your_address'.tr,
            onBackTap: () {
              Get.back();
            }),
        body: Form(
          key:  _additionalAddressDetailController.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                child: Text(
                  'where_can_clients_find_you'.tr,
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                      fontSize: AppConsts.commonFontSizeFactor * 15,
                      color: AppColors.color_B8),
                ),
              ),
              CommonInputField(
                  controller:
                      _additionalAddressDetailController.addressLine1Controller,
                  hint: 'street_address_line_1'.tr,
              showFloatingLabel: true,
              textCapitalization: TextCapitalization.sentences,
              validator: Validations.checkEmptyFieldValidation,),

              CommonInputField(
                  controller:
                  _additionalAddressDetailController.addressLine2Controller,
                  hint: 'street_address_line_2'.tr,
                  showFloatingLabel: true,
                  textCapitalization: TextCapitalization.sentences,
                  validator: Validations.checkEmptyFieldValidation),

              CommonInputField(
                  controller:
                  _additionalAddressDetailController.cityController,
                  hint: 'city'.tr,
                  isEnable: false,
                  showFloatingLabel: true,
                  validator: Validations.checkEmptyFieldValidation),

              CommonInputField(
                  controller:
                  _additionalAddressDetailController.zipcodeController,
                  hint: 'zipcode'.tr,
                  isEnable: false,
                  showFloatingLabel: true,
                  validator: Validations.checkEmptyFieldValidation)
            ],
          ),
        ),

        bottomNavigationBar: Obx(
            ()=>

            _additionalAddressDetailController.setupBusinessProfileController.isLoadingCreateBusiness.value?
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                   height: 71,
                    width: 71,
                    margin: EdgeInsets.only(top:16,bottom: Platform.isIOS ? 32 : 16),
                    padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
                    child: const CircularProgressIndicator()),
              ],
            ):
                Padding(
            padding: EdgeInsets.only(top:16,bottom: Platform.isIOS ? 32 : 16),
            child: CommonButton(text: 'continue'.tr, clickAction: (){
              _additionalAddressDetailController.validateAddressData();
            }),
          ),
        ),
      ),
    );
  }
}
