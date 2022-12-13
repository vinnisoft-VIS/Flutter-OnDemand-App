

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:insta_jamaica_provider/config/app_colors.dart';
import 'package:insta_jamaica_provider/config/app_routes.dart';
import 'package:insta_jamaica_provider/consts/app_consts.dart';
import 'package:insta_jamaica_provider/consts/app_icons.dart';
import 'package:insta_jamaica_provider/consts/app_images.dart';
import 'package:insta_jamaica_provider/utils/preference_manager.dart';
import 'package:insta_jamaica_provider/views/common/widgets/common_button.dart';

class AllSetScreen extends StatelessWidget {
  const AllSetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: AppColors.colorAllSetGreen
    ));
    return Scaffold(
      backgroundColor: AppColors.colorAllSetGreen,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Padding(
            padding: const EdgeInsets.only(top: 100.0,bottom: 44),
            child: Image.asset(AppImages.imgSplash,color:Colors.black,height: 91,),
          ),

          SvgPicture.asset(AppIcons.ic_check_circle,height: 118,),

          
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0,vertical: 8),
              child: Text(
                'congratulations_you_are_set'.tr,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4?.copyWith(
                fontSize: AppConsts.commonFontSizeFactor *26, color: Colors.white
              ),),
            ),
          ),

          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'message_all_set'.tr,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4?.copyWith(
                    fontSize: AppConsts.commonFontSizeFactor *15, color: Colors.white
                ),),
            ),
          )
        ],
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(top: 16,bottom: Platform.isIOS ? 32 : 16),
        child: CommonButton(
            text: 'continue'.tr,
            elevation: 0,
            backgroundColor: Colors.white.withOpacity(0.4),
            clickAction: (){
              PreferenceManager.save2Pref(PreferenceManager.prefIsBusinessSetup, true);
              Get.offNamedUntil(AppRoutes.routeDashboardScreen,ModalRoute.withName(AppRoutes.routeDashboardScreen));
        }),
      ),
    );
  }
}
