import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:insta_jamaica_provider/config/app_colors.dart';
import 'package:insta_jamaica_provider/consts/app_consts.dart';
import 'package:insta_jamaica_provider/consts/app_icons.dart';
import 'package:insta_jamaica_provider/controller/singup/singup_controller.dart';
import 'package:insta_jamaica_provider/utils/validations.dart';
import 'package:insta_jamaica_provider/views/common/widgets/common_button.dart';
import 'package:insta_jamaica_provider/views/common/widgets/common_input_field.dart';
import 'package:insta_jamaica_provider/views/common/widgets/common_password_input_field.dart';
import 'package:insta_jamaica_provider/views/common/widgets/common_phone_input_field.dart';
import 'package:insta_jamaica_provider/views/dialogs/common/common_country_code_picker.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

  final _signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.white));
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: SvgPicture.asset(AppIcons.ic_back)),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _signupController.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 130.0, top: 16.0),
                child: Text(
                  'create_your_account'.tr,
                  style: Theme.of(context).textTheme.headline2?.copyWith(
                      color: AppColors.kPrimaryColor,
                      fontSize: AppConsts.commonFontSizeFactor * 30),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              CommonInputField(
                controller: _signupController.firstNameController,
                hint: 'first_name'.tr,
                leading: Container(
                    height: 18,
                    padding: const EdgeInsets.only(top: 14, bottom: 14),
                    child: SvgPicture.asset(
                      AppIcons.ic_user,
                    )),
                validator: Validations.checkFirstNameValidations,
              ),
              CommonInputField(
                controller: _signupController.lastNameController,
                hint: 'last_name'.tr,
                leading: Container(
                    height: 18,
                    padding: const EdgeInsets.only(top: 14, bottom: 14),
                    child: SvgPicture.asset(
                      AppIcons.ic_user,
                    )),
                validator: Validations.checkFirstNameValidations,
              ),
              CommonInputField(
                  controller: _signupController.emailController,
                  hint: 'email'.tr,
                  inputType: TextInputType.emailAddress,
                  leading: Container(
                      height: 18,
                      padding: const EdgeInsets.only(top: 14, bottom: 14),
                      child: SvgPicture.asset(
                        AppIcons.ic_message,
                      )),
                  validator: Validations.checkEmailValidations),
              Obx(
                () => Visibility(
                  visible: _signupController.isShowEmailExistTip.value,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 32.0),
                    child: Text(
                      _signupController.isEmailExist.value
                          ? 'email_already_exist'.tr
                          : '',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: Colors.red,
                          fontSize: AppConsts.commonFontSizeFactor * 12,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
              ),
             /* CommonPhoneInputField(
                  controller: _signupController.phoneController,
                  hint: 'phone_number',
                  inputType: TextInputType.phone,
                  selectedCountry: _signupController.selectedCountry,
                  validator: Validations.checkPhoneValidations,
                  countryCodePickerCallback: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    // _signupController.pickCountryCode(context);
                    CommonCountryCodePicker.show(
                        context,
                        (country) =>
                            _signupController.selectedCountry.value = country);
                  }),*/
              CommonPasswordInputField(
                controller: _signupController.passwordController,
                hint: 'password',
                isShowHelperText: true,
                leading: Container(
                    height: 18,
                    padding: const EdgeInsets.only(top: 14, bottom: 14),
                    child: SvgPicture.asset(
                      AppIcons.ic_lock,
                    )),
                validator: Validations.checkPasswordValidations,
              ),
              CommonPasswordInputField(
                  controller: _signupController.confirmPasswordController,
                  hint: 'confirm_password',
                  isShowHelperText: false,
                  leading: Container(
                      height: 18,
                      padding: const EdgeInsets.only(top: 14, bottom: 14),
                      child: SvgPicture.asset(
                        AppIcons.ic_lock,
                      )),
                  validator: (value) {
                    return Validations.checkConfirmPasswordValidations(
                        value, _signupController.passwordController.text);
                  }),
              Obx(() => Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 16),
                    child: Row(
                      children: [
                        Checkbox(
                            side: BorderSide(color: AppColors.kPrimaryColor),
                            checkColor: Colors.white,
                            activeColor: AppColors.kPrimaryColor,
                            value: _signupController.isAgreeToTerms.value,
                            onChanged: _signupController.isAgreeToTerms),
                        Text(
                          'i_accept_terms'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              ?.copyWith(
                                  color: Colors.black,
                                  fontSize:
                                      AppConsts.commonFontSizeFactor * 15),
                        )
                      ],
                    ),
                  )),
              const SizedBox(
                height: 16,
              ),
              Obx(() => _signupController.isLoading.value
                  ? const Center(
                      child: SizedBox(
                          height: 51,
                          width: 51,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          )))
                  : CommonButton(
                      text: 'sign_up',
                      clickAction: () {
                        _signupController.validatePageData();
                      })),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, top: 16, bottom: 24),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "already_have_account".tr,
                        style: Theme.of(context).textTheme.headline5?.copyWith(
                            color: Colors.black.withOpacity(0.4),
                            fontSize: AppConsts.commonFontSizeFactor * 15)),
                    const WidgetSpan(
                        child: SizedBox(
                      width: 4,
                    )),
                    TextSpan(
                        text: "sign_in".tr,
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: AppColors.kPrimaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: AppConsts.commonFontSizeFactor * 15),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.back();
                          })
                  ])),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
