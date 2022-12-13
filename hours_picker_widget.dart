import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_jamaica_provider/config/app_colors.dart';
import 'package:insta_jamaica_provider/consts/app_consts.dart';
import 'package:insta_jamaica_provider/controller/common/hours_picker_controller.dart';
import 'package:insta_jamaica_provider/utils/helpers.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';


class HoursPickerWidget extends StatefulWidget {

  TimeOfDay startTime;
  TimeOfDay endTime;
  TimeOfDay selectedStartTime;
  TimeOfDay selectedEndTime;
  Duration step;
  Function(TimeOfDay startTime ,TimeOfDay endTime) onTimeSelected;



  HoursPickerWidget({
    Key? key,
    required this.startTime,
    required this.endTime,
    required this.selectedStartTime,
    required this.selectedEndTime,
    required this.step,
    required this.onTimeSelected
  }) : super(key: key);








  @override
  State<HoursPickerWidget> createState() => _HoursPickerWidgetState();
}

class _HoursPickerWidgetState extends State<HoursPickerWidget> {
  /*late final _hoursPickerController = Get.put(HoursPickerController(
      startTime: widget.startTime,
      endTime: widget.endTime,
      selectedStartTime: widget.selectedStartTime,
      selectedEndTime: widget.selectedEndTime,
      step: widget.step
  ));*/


  var startHoursList = <TimeOfDay>[];
  var endHoursList = <TimeOfDay>[];
  var filteredEndList = <TimeOfDay>[];

  int startSelectedItemIndex = 0;
  int endSelectedItemIndex = 0;
  TimeOfDay? endSelectedItemValue;

  late final startScrollController = ScrollController(
      initialScrollOffset: (50 * startSelectedItemIndex).toDouble(),
      keepScrollOffset: true);
  late final endScrollController = ScrollController(
      initialScrollOffset: (50 * endSelectedItemIndex).toDouble(),
      keepScrollOffset: true);



  List<TimeOfDay> getSelectedTime(){
    var result = <TimeOfDay>[];
    result.add(startHoursList[startSelectedItemIndex]);
    result.add(filteredEndList[endSelectedItemIndex]);

    return result;

  }














  populateHoursList() {
    Helpers.printLog(screenName: "PopulateList", message: "message");
    startHoursList = getTimes(widget.startTime, widget.endTime, widget.step).toList();
    endHoursList = getTimes(widget.startTime, widget.endTime, widget.step).toList();
    startHoursList.removeAt(startHoursList.length - 1);
    endHoursList.removeAt(0);
    filteredEndList.assignAll(endHoursList);
    startSelectedItemIndex =
        startHoursList.indexWhere((element) => element.hour == widget.selectedStartTime.hour);
    endSelectedItemIndex =
        filteredEndList.indexWhere((element) => element.hour == widget.selectedEndTime.hour);
    endSelectedItemValue = filteredEndList[endSelectedItemIndex];

    Helpers.printLog(screenName: "startSelectedIndex", message: startSelectedItemIndex.toString());
    Helpers.printLog(screenName: "endSelectedIndex", message: endSelectedItemIndex.toString());

    setState(() {});


    //  startSelectedItem.value = startHoursList.length ~/ 2;
  }


  Iterable<TimeOfDay> getTimes(
      TimeOfDay startTime, TimeOfDay endTime, Duration step) sync* {
    var hour = startTime.hour;
    var minute = startTime.minute;

    do {
      yield TimeOfDay(hour: hour, minute: minute);

      if (hour == endTime.hour - 1 && minute == step.inMinutes) {
        minute += step.inMinutes - 1;
      } else {
        minute += step.inMinutes;
      }

      // minute += step.inMinutes;
      while (minute >= 60) {
        minute -= 60;
        if (hour != endTime.hour) {
          hour++;
        }
      }
    } while (hour < endTime.hour ||
        (hour == endTime.hour && minute <= endTime.minute));
  }


  void onStartItemFocus(int value) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      startSelectedItemIndex = value;
      debugPrint("On Item focus  === $value");
      filterEndList();
      setState(() {});


    });
  }

  void onEndItemFocus(int value) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      endSelectedItemIndex = value;
      endSelectedItemValue = filteredEndList[value];
      debugPrint("end_selected_item_value  =  $endSelectedItemValue");



      setState(() {});

      selectTimings();

    });



  }



  void filterEndList() {
    var result =
    endHoursList.sublist(startSelectedItemIndex, endHoursList.length);
    filteredEndList.assignAll(result);

    debugPrint("result = ${filteredEndList.length}");
    refreshEndSelectedItem();
  }

  void refreshEndSelectedItem() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      debugPrint("EndSeletedItem = $endSelectedItemValue");
      var itemPosition = filteredEndList
          .indexOf(endSelectedItemValue ?? const TimeOfDay(hour: 0, minute: 0));
      debugPrint("item_position = $itemPosition");

      if (itemPosition > 0) {
        endSelectedItemIndex = itemPosition;
      } else {
        endSelectedItemIndex = 0;
      }

      // endScrollController.position.restoreOffset(50 * endSelectedItemIndex.value.toDouble());



      endScrollController.position
          .restoreOffset(50 * endSelectedItemIndex.toDouble());
      setState(() {});
      selectTimings();

    });
  }


  void selectTimings(){
    Future.delayed(Duration.zero, () {

      widget.onTimeSelected(startHoursList[startSelectedItemIndex],filteredEndList[endSelectedItemIndex]);
      /* endScrollController.animateTo(50 * endSelectedItemIndex.toDouble(),
            duration: const Duration(milliseconds:5),
            curve: Curves.ease);*/
    });
  }












  @override
  void initState() {
    super.initState();
    Helpers.printLog(screenName: "selectedStartTime", message: widget.selectedStartTime.toString());
    Helpers.printLog(screenName: "selectedEndTime", message: widget.selectedEndTime.toString());
    populateHoursList();

  }

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 260,
      width: double.infinity,
      child:
            Stack(
          children: [

            Center(
              child:
                    Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: const Border.fromBorderSide(
                                BorderSide(color: Colors.black)),
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: const Border.fromBorderSide(
                                BorderSide(color: Colors.black)),
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    )
                  ],
                ),

            ),

                Row
                  (
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Expanded(
                      child: ScrollSnapList(
                        listController:
                            startScrollController,
                        scrollDirection: Axis.vertical,
                        onItemFocus: onStartItemFocus,
                        itemSize: 50,
                        focusOnItemTap: false,
                        dispatchScrollNotifications: false,
                        itemCount: startHoursList.length,
                        reverse: false,
                        itemBuilder: (context, index) {
                          return SizedBox(
                              height: 50,
                              child: Center(
                                child: Text(
                                  startHoursList[index]
                                        .format(context),
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        ?.copyWith(
                                        fontSize: (
                                            startSelectedItemIndex ==
                                            index)
                                            ? (AppConsts.commonFontSizeFactor *
                                            18)
                                            : (AppConsts.commonFontSizeFactor *
                                            15),
                                        color:
                                            startSelectedItemIndex ==
                                            index
                                            ? Colors.black
                                            : AppColors.color_93),
                                ),
                              ),
                            );


                        },

                      ),
                    ),

                  const SizedBox(
                    width: 16,
                  ),

                        Expanded(
                      child: ScrollSnapList(
                        listController: endScrollController,
                        scrollDirection: Axis.vertical,
                        onItemFocus: onEndItemFocus,
                        itemSize: 50,
                        focusOnItemTap: false,
                        dispatchScrollNotifications: false,
                        itemCount: filteredEndList.length,
                        reverse: false,
                        itemBuilder:  (context, index)  {
                          return SizedBox(
                                  height: 50,
                                  child: Center(
                                    child: Text(
                                      index <filteredEndList.length ? filteredEndList[index].format(context) : '',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4
                                          ?.copyWith(
                                          fontSize: endSelectedItemIndex ==
                                              index
                                              ? AppConsts.commonFontSizeFactor * 18
                                              : AppConsts.commonFontSizeFactor * 15,
                                          color: endSelectedItemIndex ==
                                              index
                                              ? Colors.black
                                              : AppColors.color_93),
                                    ),
                                  ),
                                );




                        },
                      ),
                    ),

                ],
              ),



            Row(
              children: [
                Expanded(
                  child: Container(
                    padding:const EdgeInsets.only(bottom:50),
                    child:  Container(
                      decoration: BoxDecoration(
                          color: AppColors.appBackgroundColor,
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.appBackgroundColor,
                                blurRadius: 24
                            )]
                      ),
                      child: Icon(Icons.keyboard_arrow_up_rounded,color: AppColors.color_B8,

                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(bottom:50),
                    child:  Container(
                      decoration: BoxDecoration(
                          color: AppColors.appBackgroundColor,
                          boxShadow: [BoxShadow(
                              color: AppColors.appBackgroundColor,
                              blurRadius: 24
                          )]
                      ),
                      child: Icon(Icons.keyboard_arrow_up_rounded,color: AppColors.color_B8,
                      ),
                    ),
                  ),
                )
              ],
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(top:50),
                      child:
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.appBackgroundColor,
                            boxShadow: [BoxShadow(
                                color: AppColors.appBackgroundColor,
                                blurRadius: 24
                            )]
                        ),
                        child: Icon(Icons.keyboard_arrow_down_rounded,color: AppColors.color_B8,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(top:50),
                      child:  Container(
                        decoration: BoxDecoration(
                            color: AppColors.appBackgroundColor,
                          boxShadow: [BoxShadow(
                            color: AppColors.appBackgroundColor,
                            blurRadius: 24
                          )]
                        ),
                        child: Icon(Icons.keyboard_arrow_down_rounded,color: AppColors.color_B8,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),

    );
  }







/* Obx(
                    () => Expanded(
                      child: ListView.builder(
                        controller: _hoursPickerController.startScrollController,
                        shrinkWrap: true,
                          itemCount: _hoursPickerController.startHoursList.length,
                          itemBuilder: (context, index) {
                        return SizedBox(
                          height: 50,
                          child: Center(
                            child: Text(
                              _hoursPickerController.startHoursList[index]
                                  .format(context),
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  ?.copyWith(
                                      fontSize: (_hoursPickerController
                                                  .startSelectedItemIndex.value ==
                                              index)
                                          ? (AppConsts.commonFontSizeFactor * 18)
                                          : (AppConsts.commonFontSizeFactor * 15),
                                      color: _hoursPickerController
                                                  .startSelectedItemIndex.value ==
                                              index
                                          ? Colors.black
                                          : AppColors.color_93),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),*/





}
