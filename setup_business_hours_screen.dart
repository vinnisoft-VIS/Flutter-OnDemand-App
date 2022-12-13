import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_jamaica_provider/config/app_colors.dart';
import 'package:insta_jamaica_provider/config/app_routes.dart';
import 'package:insta_jamaica_provider/consts/app_consts.dart';
import 'package:insta_jamaica_provider/controller/setup_business_profile/setup_business_hours_controller.dart';
import 'package:insta_jamaica_provider/model/work_hour_model.dart';
import 'package:insta_jamaica_provider/utils/helpers.dart';
import 'package:insta_jamaica_provider/views/common/widgets/common_app_bar.dart';
import 'package:insta_jamaica_provider/views/common/widgets/common_button.dart';
import 'package:insta_jamaica_provider/views/common/widgets/work_hour_widget.dart';

class SetupBusinessHoursScreen extends StatelessWidget {
  SetupBusinessHoursScreen({Key? key}) : super(key: key);

  final _setupBusinessHoursController = Get.put(SetupBusinessHoursController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      appBar: CommonAppBar(
          title: 'your_business_hours'.tr,
          onBackTap: () {
            Get.back();
          }),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            child: Text(
              'when_client_book_with_you'.tr,
              style: Theme.of(context).textTheme.headline5?.copyWith(
                  fontSize: AppConsts.commonFontSizeFactor * 15,
                  color: AppColors.color_B8),
            ),
          ),
          Obx(
            () => Expanded(
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return WorkHourWidget(
                      workHourModel:
                          _setupBusinessHoursController.workHours[index],
                      onItemClick: (WorkHourModel workHourModel) {
                        Helpers.printLog(
                            screenName: "screenName",
                            message: workHourModel.toString());
                        _setupBusinessHoursController.selectedWeekDay.value =
                            workHourModel;
                        _setupBusinessHoursController.selectedWeekDayIndex =
                            index;
                        Get.toNamed(AppRoutes.routeSelectWorkHoursScreen);
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: _setupBusinessHoursController.workHours.length),
            ),
          )
        ],
      ),
      bottomNavigationBar: Obx(
            ()=> _setupBusinessHoursController.isLoading.value?
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                height: 71,
                width: 71,
                margin:  EdgeInsets.only(top: 16,bottom: Platform.isIOS ? 32 : 16),
                padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
                child: const CircularProgressIndicator()),
          ],
        ):
        Padding(
          padding: EdgeInsets.only(top: 16,bottom: Platform.isIOS ? 32 : 16),
          child: CommonButton(text: 'continue'.tr, clickAction: (){
            _setupBusinessHoursController.createBusinessTimings();
          }),
        ),
      ),
    );
  }
}
