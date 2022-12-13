// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:insta_jamaica_provider/config/app_colors.dart';
//
// class CommonButton extends StatelessWidget {
//   String text;
//   Color? backgroundColor;
//   Color? textColor;
//   VoidCallback clickAction;
//   RxBool? isEnable = false.obs;
//   double? borderRadius;
//
//   CommonButton(
//       {Key? key,
//       required this.text,
//       this.textColor,
//       this.backgroundColor,
//       required this.clickAction,
//       this.isEnable,
//       this.borderRadius,
//       })
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 51,
//       margin: const EdgeInsets.symmetric(
//         horizontal: 16,
//       ),
//       width: double.infinity,
//       decoration: const BoxDecoration(),
//       child: Obx(
//         () => ElevatedButton(
//           onPressed: isEnable?.value??RxBool(true).value ? clickAction: null,
//           style: ButtonStyle(
//               backgroundColor: MaterialStateProperty.all(
//                   isEnable?.value ?? RxBool(true).value
//                       ? backgroundColor ?? AppColors.kPrimaryColor
//                       : backgroundColor ??
//                           AppColors.kPrimaryDarkColor.withOpacity(0.29)),
//           shape: MaterialStateProperty.all(RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(borderRadius??10)
//           ))),
//           child: Center(
//             child: Text(
//               text.tr,
//               style: Theme.of(context)
//                   .textTheme
//                   .button
//                   ?.copyWith(color: textColor ?? Colors.white),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../config/app_colors.dart';

class CommonButton extends StatelessWidget {
  String text;
  Color? backgroundColor;
  Color? textColor;
  VoidCallback clickAction;
  RxBool? isEnable = false.obs;
  double? borderRadius;
  double? elevation;
  double? marginHorizontal;
  double? height;

  CommonButton(
      {Key? key,
        required this.text,
        this.textColor,
        this.backgroundColor,
        required this.clickAction,
        this.isEnable,
        this.borderRadius,
        this.elevation,
        this.marginHorizontal,
        this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 51,
      margin: EdgeInsets.symmetric(
        horizontal: marginHorizontal ?? 16,
      ),
      width: double.infinity,
      child: Obx(
            () => ElevatedButton(
          onPressed: isEnable?.value ?? RxBool(true).value ? clickAction : null,
          style: ButtonStyle(
              elevation: MaterialStateProperty.all(elevation),
              backgroundColor: MaterialStateProperty.all(
                  isEnable?.value ?? RxBool(true).value
                      ? backgroundColor ?? AppColors.kPrimaryColor
                      : backgroundColor ??
                      AppColors.kPrimaryDarkColor.withOpacity(0.29)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 10)))),
          child: Center(
            child: Text(
              text.tr,
              style: Theme.of(context)
                  .textTheme
                  .button
                  ?.copyWith(color: textColor ?? Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
