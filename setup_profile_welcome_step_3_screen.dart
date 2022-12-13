

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:insta_jamaica_provider/config/app_colors.dart';
import 'package:insta_jamaica_provider/config/app_routes.dart';
import 'package:insta_jamaica_provider/config/size_config.dart';
import 'package:insta_jamaica_provider/consts/app_consts.dart';
import 'package:insta_jamaica_provider/consts/app_images.dart';
import 'package:insta_jamaica_provider/views/common/widgets/common_button.dart';

class SetupProfileWelcomeStep3Screen extends StatelessWidget {
  const SetupProfileWelcomeStep3Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(

      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Expanded(
            child: SizedBox(
              width: SizeConfig.screenWidth,
              child: Image.asset(AppImages.imgSetupProfileWelcomeStep3,
                fit: BoxFit.cover,
              ),
            ),
          ),


          Padding(
            padding: const EdgeInsets.only(left: 0,right: 0,top: 24),
            child: Text('profile_setup_welcome_step_3_title'.tr,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: AppColors.onBoardingTitleColor,
                  fontWeight: FontWeight.w600,
                  fontSize: AppConsts.commonFontSizeFactor *18
              ),),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 32,right: 32,top: 12),
            child: Text('profile_setup_welcome_step_3_subtitle'.tr,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline5?.copyWith(
                  fontSize: AppConsts.commonFontSizeFactor *16,
                  wordSpacing: 1,
                  color: Colors.black
              ),),
          ),


          const   SizedBox(height: 8,),

          Center(
            child: SizedBox(
                height: 50, child: Image.asset(AppImages.imgSplash)),
          ),



          Padding(
            padding:  EdgeInsets.only(top: 16,bottom: Platform.isIOS ? 32 : 16),
            child: CommonButton(text: 'continue'.tr, clickAction: (){
              Get.toNamed(AppRoutes.routeSetupBusinessHoursScreen);
            }),
          ),




        ],),
    );
  }
}
