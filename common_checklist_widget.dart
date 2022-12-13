

import 'package:flutter/material.dart';
import 'package:insta_jamaica_provider/config/app_colors.dart';
import 'package:insta_jamaica_provider/consts/app_consts.dart';

class CommonChecklistWidget extends StatelessWidget {
   CommonChecklistWidget({
    Key? key,
    required this.title,
    required this.isChecked,
    required this.onChangeValue
  }) : super(key: key);


  String title;
  bool isChecked;
  Function(bool) onChangeValue;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Checkbox(value: isChecked,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
            side: BorderSide(color: AppColors.color_C8)
          ),
          materialTapTargetSize: MaterialTapTargetSize.padded,
          onChanged: (value){

        onChangeValue(value??false);
      }),

      Text(title,style: Theme.of(context).textTheme.headline5?.copyWith(
        fontSize: AppConsts.commonFontSizeFactor *15,
        color: Colors.black
      ),)
    ],);
  }
}
