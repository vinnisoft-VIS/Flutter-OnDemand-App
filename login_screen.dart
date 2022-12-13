import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:insta_jamaica_provider/config/app_colors.dart';
import 'package:insta_jamaica_provider/config/app_routes.dart';
import 'package:insta_jamaica_provider/config/size_config.dart';
import 'package:insta_jamaica_provider/consts/app_consts.dart';
import 'package:insta_jamaica_provider/consts/app_icons.dart';
import 'package:insta_jamaica_provider/consts/app_images.dart';
import 'package:insta_jamaica_provider/controller/login/login_controller.dart';
import 'package:insta_jamaica_provider/utils/validations.dart';
import 'package:insta_jamaica_provider/views/common/widgets/common_button.dart';
import 'package:insta_jamaica_provider/views/common/widgets/common_input_field.dart';
import 'package:insta_jamaica_provider/views/common/widgets/common_password_input_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark
        .copyWith(statusBarColor: AppColors.appBackgroundColor));



    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: SizeConfig.screenHeight - 30,
          child: Form(
            key: _loginController.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 100.0, bottom: 24),
                  child: Image.asset(
                    AppImages.imgSplash,
                    height: 140,
                  ),
                ),
                CommonInputField(
                  controller: _loginController.emailController,
                  hint: 'email',
                  inputType: TextInputType.emailAddress,
                  leading: Container(
                      height: 18,
                      padding: const EdgeInsets.only(top: 14, bottom: 14),
                      child: SvgPicture.asset(
                        AppIcons.ic_message,
                      )),
                  validator: Validations.checkEmailValidations,
                ),
                CommonPasswordInputField(
                  controller: _loginController.passwordController,
                  hint: 'password',
                  isShowHelperText: false,
                  leading: Container(
                      height: 18,
                      padding: const EdgeInsets.only(top: 14, bottom: 14),
                      child: SvgPicture.asset(
                        AppIcons.ic_lock,
                      )),
                  validator: Validations.checkPasswordValidations,
                ),
                const SizedBox(
                  height: 24,
                ),
                Obx(() => _loginController.isLoading.value
                    ?
                Center(
                        child: Container(
                            height: 51,
                            width: 51,
                            padding: const EdgeInsets.all(8),
                            child: const CircularProgressIndicator()))
                    : CommonButton(
                        text: 'sign_in',
                        clickAction: () {
                          _loginController.login();
                        })),
                const SizedBox(
                  height: 8,
                ),
                TextButton(
                    onPressed: () {
                      _loginController.clearFormData();
                      Get.toNamed(AppRoutes.routeForgotPasswordScreen);
                    },
                    child: Text(
                      'forgot_password_que'.tr,
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                          color: AppColors.kPrimaryColor,
                          fontSize: AppConsts.commonFontSizeFactor * 15),
                    )),
                Spacer(),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 16, bottom: 24),
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "dont_have_account".tr,
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              ?.copyWith(
                                  color: Colors.black.withOpacity(0.4),
                                  fontSize:
                                      AppConsts.commonFontSizeFactor * 15)),
                      const WidgetSpan(
                          child: SizedBox(
                        width: 4,
                      )),
                      TextSpan(
                          text: "sign_up".tr,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(
                                  color: AppColors.kPrimaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize:
                                      AppConsts.commonFontSizeFactor * 15),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              _loginController.clearFormData();
                              Get.toNamed(AppRoutes.routeSignupScreen);
                            })
                    ])),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget socialButtonWidget(
      {required String image, required VoidCallback onClick}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Image.asset(
        image,
        height: 18,
      ),
    );
  }
}
