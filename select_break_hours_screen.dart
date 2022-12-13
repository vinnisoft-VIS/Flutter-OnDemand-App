import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_jamaica_provider/config/app_colors.dart';
import 'package:insta_jamaica_provider/controller/setup_business_profile/setup_business_hours_controller.dart';
import 'package:insta_jamaica_provider/utils/helpers.dart';
import 'package:insta_jamaica_provider/views/common/widgets/common_app_bar.dart';
import 'package:insta_jamaica_provider/views/common/widgets/common_button.dart';
import 'package:insta_jamaica_provider/views/common/widgets/hours_picker_widget.dart';

class SelectBreakHoursScreen extends StatelessWidget {
  SelectBreakHoursScreen({Key? key}) : super(key: key);
  final _setupBusinessHoursController =
      Get.find<SetupBusinessHoursController>();

  //hii this is
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      appBar: CommonAppBar(
        title: 'Break ${_setupBusinessHoursController.weekDayNameMap[_setupBusinessHoursController.selectedWeekDay.value?.weekDay]}',
        onBackTap: () {
          Get.back();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 100.0),
        child:
              HoursPickerWidget(
              startTime: const TimeOfDay(hour: 0, minute: 0),
              endTime: const TimeOfDay(hour: 24, minute: 0),

              selectedStartTime: TimeOfDay(
                  hour: int.parse(_setupBusinessHoursController.selectedWeekDay.value?.breakStartTime?.split(":").first??"13"),
                  minute: int.parse(_setupBusinessHoursController.selectedWeekDay.value?.breakStartTime?.split(":").last??"00")),
              selectedEndTime: TimeOfDay(
                  hour: int.parse(_setupBusinessHoursController
                      .selectedWeekDay.value?.breakEndTime?.split(":").first??"14"),
                  minute: int.parse(_setupBusinessHoursController.selectedWeekDay.value?.breakEndTime?.split(":").last??"00")),
              step: Duration(minutes: 30),
                onTimeSelected: (TimeOfDay startTime, TimeOfDay endTime) {

                  _setupBusinessHoursController.selectedWeekDay.value?.breakStartTime = "${startTime.hour}:${startTime.minute}";
                  _setupBusinessHoursController.selectedWeekDay.value?.breakEndTime = "${endTime.hour}:${endTime.minute}";
                  _setupBusinessHoursController.selectedWeekDay.refresh();

                Helpers.printLog(screenName: "start/End", message: "$startTime/$endTime");
                },),

      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(top: 16,bottom: Platform.isIOS ? 32 : 16),
        child: CommonButton(
            text: 'ok'.tr,
            clickAction: () {
              Get.back();
            }),
      ),
    );
  }
}
