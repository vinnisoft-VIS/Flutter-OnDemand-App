import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:insta_jamaica_provider/config/app_colors.dart';
import 'package:insta_jamaica_provider/consts/app_consts.dart';
import 'package:insta_jamaica_provider/consts/app_icons.dart';

class CommonSearchField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final String hint;
  Widget? leading;
  Widget? trailing;
  RxBool? isShowTrailing;
  final border = InputBorder.none;
  double? height;

  CommonSearchField(
      {Key? key,
      required this.controller,
      required this.onChanged,
      required this.hint,
      this.leading,
      this.trailing,
      this.isShowTrailing,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.color_F5,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: SizedBox(
        child: Obx(
          () => TextField(
            controller: controller,
            decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                floatingLabelAlignment: FloatingLabelAlignment.center,
                alignLabelWithHint: true,
                hintText: hint,
                hintStyle: Theme.of(context).textTheme.headline4?.copyWith(
                    color: Colors.black.withOpacity(0.3),
                    fontSize: AppConsts.commonFontSizeFactor * 12),
                prefixIcon: leading ??
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: SvgPicture.asset(
                        AppIcons.ic_search,
                        color: AppColors.color_BD,
                        width: 12,
                      ),
                    ),
                suffixIcon: isShowTrailing?.value ?? RxBool(false).value
                    ? trailing
                    : null,
                border: border,
                focusedBorder: border,
                enabledBorder: border,
                focusedErrorBorder: border,
                errorBorder: border,
                disabledBorder: border),
            cursorColor: AppColors.kPrimaryDarkColor,
            keyboardType: TextInputType.text,
            style: Theme.of(context).textTheme.headline4?.copyWith(
                  color: Colors.black,
                  fontSize: AppConsts.commonFontSizeFactor * 14,
                ),
            onChanged: (text) {
              isShowTrailing?.value = text.isNotEmpty;
              onChanged(text);
            },
          ),
        ),
      ),
    );
  }
}
