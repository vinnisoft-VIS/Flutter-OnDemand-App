import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_jamaica_provider/config/app_colors.dart';
import 'package:insta_jamaica_provider/consts/app_consts.dart';
import 'package:insta_jamaica_provider/controller/setup_business_profile/setup_business_profile_controller.dart';
import 'package:insta_jamaica_provider/views/common/widgets/common_app_bar.dart';
import 'package:insta_jamaica_provider/views/common/widgets/common_button.dart';
import 'package:insta_jamaica_provider/views/common/widgets/work_preference_option_widget.dart';

class SelectWorkPreferenceScreen extends StatelessWidget {
  SelectWorkPreferenceScreen({Key? key}) : super(key: key);
  final _setupBusinessProfileController = Get.find<SetupBusinessProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      appBar: CommonAppBar(
          title: 'where_do_you_work'.tr,
          onBackTap: () {
            Get.back();
          }),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            child: Text(
              'message_do_your_clients_come_to_you'.tr,
              style: Theme.of(context).textTheme.headline5?.copyWith(
                  fontSize: AppConsts.commonFontSizeFactor * 15,
                  color: AppColors.color_B8),
            ),
          ),
          Obx(
            () => ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return WorkPreferenceOptionWidget(
                    workPreferenceOption: _setupBusinessProfileController
                        .workPreferenceOptions[index],
                    onClick: () {
                      _setupBusinessProfileController.workPreferenceOptions
                          .refresh();
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: _setupBusinessProfileController
                    .workPreferenceOptions.value.length),
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding:  EdgeInsets.only(top:16,bottom: Platform.isIOS ? 32 : 16),
        child: CommonButton(text: 'continue'.tr, clickAction: () {
          _setupBusinessProfileController.validateWorkplacePreference();
        }),
      ),
    );
  }
}
