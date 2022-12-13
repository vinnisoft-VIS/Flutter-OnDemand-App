import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_projects/Strings.dart';
import 'package:flutter_projects/Colors.dart';
import 'package:flutter_projects/controllers/repeat_controller.dart';
import 'package:flutter_projects/pages/repeat_page/components/repeat_month_options_bottom_sheet_dialog.dart';
import 'package:flutter_projects/pages/repeat_page/components/repeat_week_options_bottom_sheet_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class RepeatPage extends StatefulWidget {
  const RepeatPage({Key? key}) : super(key: key);

  @override
  State<RepeatPage> createState() => _RepeatPage();
}

class _RepeatPage extends State<RepeatPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _repeatController = Get.put(RepeatController());


  var frequency = "";

  @override
  void initState() {


    super.initState();

    _repeatController.durationStatus.value = 1;

    _repeatController.showHideYearView.value = false;
    _repeatController.showHideMonthsView.value = false;
    _repeatController.showHideWeeksView.value = false;
    _repeatController.showHideDurationView.value = true;
    _repeatController.currentValue.value = 1;




  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFCFCFC),
        elevation: 0,
        leadingWidth: 48,
        centerTitle: true,
        title: const Text(
          Strings.repeat,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Image.asset('assets/ic_back.png'),
          padding: const EdgeInsets.only(left: 24),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Stack(
          children: [
            Image.asset('assets/PageBG.png',
                fit: BoxFit.fill,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Obx(
                      () => Text(
                        _repeatController.repeatEventMessage.value,
                        style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.themeColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: GestureDetector(
                      onTap: () {

                        _repeatController.repeatDuration.value = '60';
                        _repeatController.selectRepeatFrequency(RepeatFrequency.everyday);

                        _repeatController.durationType.value = DurationType.forever;
                        _repeatController.repeatDurationController.clear();


                        },
                      child: Obx(
                        () => Row(
                          children: [
                            Image.asset(
                              _repeatController.repeatFrequency.value ==
                                      RepeatFrequency.everyday
                                  ? 'assets/ic_circle_selected.png'
                                  : 'assets/ic_uncheck_circel.png',
                              color: AppColors.themeColor,
                              height: 20,
                              width: 20,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            const Text(
                              'Everyday',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    color: AppColors.themeColor,
                    height: 24,
                    indent: 50,
                    endIndent: 16,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: GestureDetector(
                      onTap: () {
                        RepeatWeekOptionsBottomSheetDialog.showDialog(
                            selectedWeekFrequency:
                                _repeatController.repeatFrequencyWeek.value,
                            items: _repeatController
                                .repeatFrequencyWeekMap.values
                                .toList(),
                            onTap: (RepeatFrequencyWeek repeatFrequency) {
                              _repeatController.repeatFrequencyWeek.value = repeatFrequency;
                              _repeatController.repeatDuration.value = '60';
                              _repeatController.selectRepeatFrequency(RepeatFrequency.everyWeek);


                              _repeatController.durationType.value = DurationType.forever;
                              _repeatController.repeatDurationController.clear();


                            });
                      },
                      child: Obx(
                        () => Row(
                          children: [
                            Image.asset(
                              _repeatController.repeatFrequency.value ==
                                      RepeatFrequency.everyWeek
                                  ? 'assets/ic_circle_selected.png'
                                  : 'assets/ic_uncheck_circel.png',
                              color: AppColors.themeColor,
                              height: 20,
                              width: 20,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Text(
                              _repeatController.repeatFrequencyWeekMap[_repeatController.repeatFrequencyWeek.value]??'',
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),



                  const Divider(
                    color: AppColors.themeColor,
                    height: 24,
                    indent: 50,
                    endIndent: 16,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: GestureDetector(
                      onTap: () {
                        RepeatMonthOptionsBottomSheetDialog.showDialog(
                            selectedMonthFrequency:
                            _repeatController.repeatFrequencyMonth.value,
                            items: _repeatController
                                .repeatFrequencyMonthMap.values
                                .toList(),
                            onTap: (RepeatFrequencyMonth repeatFrequency) {

                              _repeatController.repeatFrequencyMonth.value = repeatFrequency;
                              _repeatController.repeatDuration.value = '60';
                              _repeatController.selectRepeatFrequency(RepeatFrequency.everyMonth);

                              _repeatController.durationType.value = DurationType.forever;
                              _repeatController.repeatDurationController.clear();
                            });

                      },
                      child: Obx(
                        () => Row(
                          children: [
                            Image.asset(
                              _repeatController.repeatFrequency.value ==
                                  RepeatFrequency.everyMonth
                                  ? 'assets/ic_circle_selected.png'
                                  : 'assets/ic_uncheck_circel.png',
                              color: AppColors.themeColor,
                              height: 20,
                              width: 20,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Text(
                              _repeatController.repeatFrequencyMonthMap[_repeatController.repeatFrequencyMonth]??'',
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  //MARK: - MONTH VIEW



                  const Divider(
                    color: AppColors.themeColor,
                    height: 24,
                    indent: 50,
                    endIndent: 16,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: GestureDetector(
                      onTap: () {
                        _repeatController.repeatDuration.value = '60';

                        _repeatController.selectRepeatFrequency(RepeatFrequency.everyYear);
                        _repeatController.durationType.value = DurationType.forever;
                        _repeatController.repeatDurationController.clear();

                      },
                      child: Obx(
                        () => Row(
                          children: [
                            Image.asset(
                              _repeatController.repeatFrequency.value ==
                                  RepeatFrequency.everyYear
                                  ? 'assets/ic_circle_selected.png'
                                  : 'assets/ic_uncheck_circel.png',
                              color: AppColors.themeColor,
                              height: 20,
                              width: 20,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            const Text(
                              'Every year',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const Divider(
                    color: AppColors.themeColor,
                    height: 24,
                    indent: 50,
                    endIndent: 16,
                  ),
                  //MARK: - YEAR VIEW
                  Obx(
                    () => Visibility(
                      visible: _repeatController.showHideYearView.value,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Obx(
                          () => Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _repeatController.yearStatus.value = 0;
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 32, right: 32),
                                  child: Container(
                                    height: 44,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(22.0),
                                        border: Border.all(
                                          color: _repeatController
                                                      .yearStatus.value ==
                                                  0
                                              ? AppColors.themeColor
                                              : const Color(0xFF818181),
                                          style: BorderStyle.solid,
                                          width: 1.0,
                                        )),
                                    child: Center(
                                      child: Text(
                                        'Repeat on the 28th',
                                        style: TextStyle(
                                          color: _repeatController
                                                      .yearStatus.value ==
                                                  0
                                              ? AppColors.themeColor
                                              : const Color(0xFF818181),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              GestureDetector(
                                onTap: () {
                                  _repeatController.yearStatus.value = 1;
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 32, right: 32),
                                  child: Container(
                                    height: 44,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(22.0),
                                        border: Border.all(
                                          color: _repeatController
                                                      .yearStatus.value ==
                                                  1
                                              ? AppColors.themeColor
                                              : const Color(0xFF818181),
                                          style: BorderStyle.solid,
                                          width: 1.0,
                                        )),
                                    child: Center(
                                      child: Text(
                                        'Repeat on the 4th Tuesday of Jun',
                                        style: TextStyle(
                                          color: _repeatController
                                                      .yearStatus.value ==
                                                  1
                                              ? AppColors.themeColor
                                              : const Color(0xFF818181),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              GestureDetector(
                                onTap: () {
                                  _repeatController.yearStatus.value = 2;
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 32, right: 32),
                                  child: Container(
                                    height: 44,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(22.0),
                                        border: Border.all(
                                          color: _repeatController
                                                      .yearStatus.value ==
                                                  2
                                              ? AppColors.themeColor
                                              : const Color(0xFF818181),
                                          style: BorderStyle.solid,
                                          width: 1.0,
                                        )),
                                    child: Center(
                                      child: Text(
                                        'Repeat on the last Tuesday of Jun',
                                        style: TextStyle(
                                          color: _repeatController
                                                      .yearStatus.value ==
                                                  2
                                              ? AppColors.themeColor
                                              : const Color(0xFF818181),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              GestureDetector(
                                onTap: () {
                                  _repeatController.yearStatus.value = 3;
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 32, right: 32),
                                  child: Container(
                                    height: 44,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(22.0),
                                        border: Border.all(
                                          color: _repeatController
                                                      .yearStatus.value ==
                                                  3
                                              ? AppColors.themeColor
                                              : const Color(0xFF818181),
                                          style: BorderStyle.solid,
                                          width: 1.0,
                                        )),
                                    child: Center(
                                      child: Text(
                                        'Select months to repeat on the 28th day',
                                        style: TextStyle(
                                          color: _repeatController
                                                      .yearStatus.value ==
                                                  3
                                              ? AppColors.themeColor
                                              : const Color(0xFF818181),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  //MARK: - DURATION VIEW
                  Obx(
                    () => Visibility(
                      visible: _repeatController.showHideDurationView.value,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 32,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              "Duration",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF909090),
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: GestureDetector(
                              onTap: () {
                               _repeatController.selectDurationType(DurationType.forever);
                               _repeatController.repeatDuration.value = '60';
                               if(_repeatController.repeatFrequency.value !=null){
                                 _repeatController.selectRepeatFrequency(_repeatController.repeatFrequency.value!);
                               }
                              },
                              child: Obx(
                                () => Row(
                                  children: [
                                     Image.asset(
                                           _repeatController.durationType.value == DurationType.forever? 'assets/ic_circle_selected.png':  'assets/ic_uncheck_circel.png',
                                            color: AppColors.themeColor,
                                            height: 20,
                                            width: 20,
                                          ),

                                    const SizedBox(
                                      width: 16,
                                    ),
                                    const Text(
                                      'Forever(5 years)',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const Divider(
                            color: AppColors.themeColor,
                            height: 24,
                            indent: 50,
                            endIndent: 16,
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: GestureDetector(
                              onTap: () {
                               _repeatController.durationType.value = DurationType.specificMonths;
                               _repeatController.repeatDuration.value = _repeatController.repeatDurationController.text.isEmpty ? '0' :_repeatController.repeatDurationController.text;

                               if(_repeatController.repeatFrequency.value !=null){
                                 _repeatController.selectRepeatFrequency(_repeatController.repeatFrequency.value!);
                               }

                              },
                              child: Obx(
                                () => Row(
                                  children: [
                                    Image.asset(
                                      _repeatController.durationType.value == DurationType.specificMonths? 'assets/ic_circle_selected.png':  'assets/ic_uncheck_circel.png',
                                      color: AppColors.themeColor,
                                      height: 20,
                                      width: 20,
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    const Text(
                                      'Specific number of Months(Max 60)',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Obx(
                            () => Visibility(
                              visible: _repeatController.durationType.value == DurationType.specificMonths,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, top: 16),
                                child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        color: Colors.white
                                        // color: _debtPayOffController.monthsOfPayOff.value == true?
                                        // const Color(0xFFE3EAF6): Colors.grey.withOpacity(0.2),
                                        ),
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16, right: 16),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: TextFormField(
                                                onChanged:  _repeatController.onDurationChanged,
                                                controller: _repeatController
                                                    .repeatDurationController,
                                                textInputAction:
                                                    TextInputAction.done,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration:
                                                    const InputDecoration(
                                                        border:
                                                            InputBorder.none),
                                                style: const TextStyle(
                                                    color: Colors.black),
                                                inputFormatters: <TextInputFormatter>[
                                                  FilteringTextInputFormatter.allow(
                                                    RegExp(r'[0-9]'),
                                                  ),
                                                  FilteringTextInputFormatter.deny(
                                                    RegExp(
                                                        r'^0+'), //users can't type 0 at 1st position
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            const Text(
                                              'Months',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ))),
                              ),
                            ),
                          ),
                          const Divider(
                            color: AppColors.themeColor,
                            height: 24,
                            indent: 16,
                            endIndent: 16,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: AppColors.themeColor,
                        ),
                        child: TextButton(
                            onPressed: () {


                            _repeatController.saveData();
                            },
                            child: const Text(
                              Strings.save,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ))),
                  ),
                ],
              ),
            ),
            Obx(
              () => Center(
                child: Visibility(
                  visible: _repeatController.showProgress.value,
                  child: const SpinKitFadingCircle(
                    color: Color(0xFF3A4FBF),
                    size: 50.0,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
