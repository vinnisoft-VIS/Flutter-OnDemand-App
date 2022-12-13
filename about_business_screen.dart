import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_jamaica_provider/config/app_colors.dart';
import 'package:insta_jamaica_provider/config/device_info.dart';
import 'package:insta_jamaica_provider/consts/app_consts.dart';
import 'package:insta_jamaica_provider/controller/setup_business_profile/setup_business_profile_controller.dart';
import 'package:insta_jamaica_provider/utils/validations.dart';
import 'package:insta_jamaica_provider/views/common/widgets/common_app_bar.dart';
import 'package:insta_jamaica_provider/views/common/widgets/common_button.dart';
import 'package:insta_jamaica_provider/views/common/widgets/common_input_field.dart';
import 'package:insta_jamaica_provider/views/common/widgets/common_phone_input_field.dart';
import 'package:insta_jamaica_provider/views/dialogs/common/common_country_code_picker.dart';

class AboutBusinessScreen extends StatelessWidget {
  AboutBusinessScreen({Key? key}) : super(key: key);

  final _setupBusinessProfileController =
      Get.put(SetupBusinessProfileController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _setupBusinessProfileController.aboutBusinessFormKey,
      child: GestureDetector(
        onTap : (){FocusManager.instance.primaryFocus?.unfocus();},
        child: Scaffold(
          backgroundColor: AppColors.appBackgroundColor,
          appBar: CommonAppBar(
            title: 'about_you'.tr,
            onBackTap: () {
              Get.back();
            },
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 16),
                child: Text('tell_us_about_title'.tr,style: Theme.of(context).textTheme.headline5?.copyWith(
                  color: AppColors.color_B8,
                  fontSize: AppConsts.commonFontSizeFactor *15
                ),),
              ),


              CommonInputField(
                  controller:
                      _setupBusinessProfileController.businessNameController,
                  hint: 'business_name'.tr,
              textCapitalization: TextCapitalization.sentences,
              validator: Validations.checkEmptyFieldValidation,),
              /* CommonInputField(
                  controller:
                      _setupBusinessProfileController.businessNameController,
                  hint: 'business_owner_name'.tr,
                validator: Validations.checkEmptyFieldValidation,),*/

              CommonPhoneInputField(
                  controller:
                      _setupBusinessProfileController.businessPhoneNumberController,
                  hint: 'business_phone_number'.tr,
                  countryCodePickerCallback: (){
                    CommonCountryCodePicker.show(context, (selectedCountry) =>
                    _setupBusinessProfileController.selectedCountry.value = selectedCountry);
                  },
                  selectedCountry: _setupBusinessProfileController.selectedCountry,
              validator: Validations.checkPhoneValidations,)
            ],
          ),
          bottomNavigationBar: Padding(
            padding:  EdgeInsets.only(top: 16.0,bottom: Platform.isIOS ? 32 : 16),
            child: CommonButton(text: 'continue', clickAction: (){
              _setupBusinessProfileController.validatedAboutBusinessForm();
            }),
          ),
        ),
      ),
    );
  }
}
