import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:insta_jamaica_provider/config/app_colors.dart';
import 'package:insta_jamaica_provider/config/app_routes.dart';
import 'package:insta_jamaica_provider/consts/app_consts.dart';
import 'package:insta_jamaica_provider/controller/setup_business_profile/setup_business_hours_controller.dart';
import 'package:insta_jamaica_provider/utils/helpers.dart';
import 'package:insta_jamaica_provider/views/common/widgets/common_app_bar.dart';
import 'package:insta_jamaica_provider/views/common/widgets/common_button.dart';
import 'package:insta_jamaica_provider/views/common/widgets/hours_picker_widget.dart';

class SelectWorkHoursScreen extends StatelessWidget {
  SelectWorkHoursScreen({Key? key}) : super(key: key);

  final _setupBusinessHoursController =
      Get.find<SetupBusinessHoursController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      appBar: CommonAppBar(
        title: _setupBusinessHoursController.weekDayNameMap[
                _setupBusinessHoursController.selectedWeekDay.value?.weekDay] ??
            "",
        onBackTap: () {
          Get.back();
        },
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              children: [
                Obx(
                  () => Text(
                    (_setupBusinessHoursController
                                .selectedWeekDay.value?.isClosed ??
                            true)
                        ? 'close'.tr
                        : 'open'.tr,
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                        fontSize: AppConsts.commonFontSizeFactor * 12,
                        color: Colors.black),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Obx(
                  () => FlutterSwitch(
                      width: 44,
                      height: 24,
                      value: (_setupBusinessHoursController
                              .selectedWeekDay.value?.isClosed ??
                          true),
                      toggleSize: 16,
                      activeColor: AppColors.kPrimaryColor,
                      onToggle: (value) {
                        _setupBusinessHoursController.selectedWeekDay.value
                            ?.isClosed = !(_setupBusinessHoursController
                                .selectedWeekDay.value?.isClosed ??
                            true);
                        _setupBusinessHoursController.selectedWeekDay.refresh();
                      }),
                )
              ],
            ),
          )
        ],
      ),
      body: Obx(
        () => Visibility(
          visible:
              !(_setupBusinessHoursController.selectedWeekDay.value?.isClosed ??
                  true),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                child: Text(
                  'set_business_hours_description'.tr,
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                      color: AppColors.color_B8,
                      fontSize: AppConsts.commonFontSizeFactor * 12),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Center(
                  child: Obx(
                    () => HoursPickerWidget(
                      startTime: TimeOfDay(hour: 0, minute: 0),
                      endTime: TimeOfDay(hour: 24, minute: 0),
                      step: Duration(minutes: 30),
                      selectedStartTime: TimeOfDay(
                          hour: int.parse(_setupBusinessHoursController
                              .selectedWeekDay.value!.startTime!
                              .split(":")
                              .first),
                          minute: int.parse(_setupBusinessHoursController
                              .selectedWeekDay.value!.startTime!
                              .split(":")
                              .last)),
                      selectedEndTime: TimeOfDay(
                          hour: int.parse(_setupBusinessHoursController
                              .selectedWeekDay.value!.endTime!
                              .split(":")
                              .first),
                          minute: int.parse(_setupBusinessHoursController
                              .selectedWeekDay.value!.endTime!
                              .split(":")
                              .last)),
                      onTimeSelected: (TimeOfDay startTime, TimeOfDay endTime) {
                        Helpers.printLog(
                            screenName: "Start/End",
                            message: "$startTime/$endTime");

                        _setupBusinessHoursController
                                .selectedWeekDay.value?.startTime =
                            "${startTime.hour}:${startTime.minute}";
                        _setupBusinessHoursController.selectedWeekDay.value
                            ?.endTime = "${endTime.hour}:${endTime.minute}";

                        _setupBusinessHoursController.selectedWeekDay.refresh();
                      },
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                    color: AppColors.color_C4_CA.withOpacity(0.1)),
                child: Text(
                  'breaks'.tr,
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                      fontSize: AppConsts.commonFontSizeFactor * 15,
                      color: Colors.black),
                ),
              ),
              Obx(
                () => Visibility(
                  visible: _setupBusinessHoursController
                              .selectedWeekDay.value?.breakStartTime !=
                          null &&
                      _setupBusinessHoursController
                              .selectedWeekDay.value?.breakEndTime !=
                          null,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8),
                    child: Text(
                      '${_setupBusinessHoursController.formatTimeIn12Hours(context, _setupBusinessHoursController.selectedWeekDay.value?.breakStartTime)}-'
                      ' ${_setupBusinessHoursController.formatTimeIn12Hours(context, _setupBusinessHoursController.selectedWeekDay.value?.breakEndTime)}',
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                          color: Colors.black,
                          fontSize: AppConsts.commonFontSizeFactor * 16),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                child: TextButton.icon(
                    onPressed: () {
                      Get.toNamed(AppRoutes.routeSelectBreakHoursScreen);
                    },
                    icon: Icon(
                      _setupBusinessHoursController
                                      .selectedWeekDay.value?.breakStartTime !=
                                  null &&
                              _setupBusinessHoursController
                                      .selectedWeekDay.value?.breakEndTime !=
                                  null
                          ? Icons.edit
                          : Icons.add,
                      color: Colors.black,
                    ),
                    label: Obx(
                      () => Text(
                        _setupBusinessHoursController.selectedWeekDay.value
                                        ?.breakStartTime !=
                                    null &&
                                _setupBusinessHoursController
                                        .selectedWeekDay.value?.breakEndTime !=
                                    null
                            ? 'edit_break'.tr
                            : 'add_break',
                        style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.black,
                            fontSize: AppConsts.commonFontSizeFactor * 15),
                      ),
                    )),
              ),
              Divider(
                indent: 16,
                endIndent: 16,
                height: 0,
                thickness: 1,
                color: AppColors.color_D7,
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(top: 16,bottom: Platform.isIOS ? 32 : 16),
        child: CommonButton(
            text: 'ok'.tr,
            clickAction: () {
              _setupBusinessHoursController.workHours[
                      _setupBusinessHoursController.selectedWeekDayIndex] = _setupBusinessHoursController.selectedWeekDay.value!;

              _setupBusinessHoursController.workHours.refresh();

              Helpers.printLog(
                  screenName: "Hours",
                  message:
                      _setupBusinessHoursController.selectedWeekDay.toString());

              Get.back();
            }),
      ),
    );
  }
}
