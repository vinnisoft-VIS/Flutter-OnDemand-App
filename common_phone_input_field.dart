import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:insta_jamaica_provider/config/app_colors.dart';
import 'package:insta_jamaica_provider/consts/app_consts.dart';

class CommonPhoneInputField extends StatelessWidget {
  String hint;
  Function(String)? onChanged;
  String? Function(String?)? validator;
  TextEditingController controller;
  TextInputType? inputType;
  double? marginLeft;
  double? marginRight;
  double? marginTop;
  double? marginBottom;
  bool? showFloatingLabel;
  List<TextInputFormatter>? inputFormatter;
  VoidCallback countryCodePickerCallback;
  var selectedCountry = Rx<Country?>(null);
  Widget? leading;

  var inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: AppColors.color_DC));

  var errorInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.red));


  CommonPhoneInputField({
    Key? key,
    required this.controller,
    required this.hint,
    this.onChanged,
    this.validator,
    this.inputType,
    this.inputFormatter,
    this.marginLeft,
    this.marginRight,
    this.marginTop,
    this.marginBottom,
    required this.countryCodePickerCallback,
    required this.selectedCountry,
    this.leading,
    this.showFloatingLabel
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: EdgeInsets.only(
          left: marginLeft ?? 16,
          right: marginRight ?? 16,
          top: marginTop ?? 8,
          bottom: marginBottom ?? 8),
      child: Stack(
        children: [
          TextFormField(
            controller: controller,
            style: Theme.of(context)
                .textTheme
                .headline5?.copyWith(
                fontSize: AppConsts.commonFontSizeFactor *16,
                color: Colors.black),
            keyboardType: TextInputType.phone,
            cursorColor: AppColors.kPrimaryDarkColor,
            decoration: InputDecoration(
                hintText: (showFloatingLabel ?? false) ? '' : hint.tr,
                hintStyle: Theme.of(context).textTheme.headline5?.copyWith(
                    fontSize: AppConsts.commonFontSizeFactor * 15,
                    color: Colors.black.withOpacity(0.4)),
                fillColor: Colors.white,
                filled: true,
                label: (showFloatingLabel ?? false)
                    ? Text(hint.tr,
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                        fontSize: AppConsts.commonFontSizeFactor * 15,
                        color: Colors.black.withOpacity(0.4)))
                    : null,
                border: inputBorder,
                errorBorder: inputBorder,
                enabledBorder: inputBorder,
                disabledBorder: inputBorder,
                focusedBorder: inputBorder,
                focusedErrorBorder: inputBorder,
                errorStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontSize: AppConsts.commonFontSizeFactor * 12,
                    fontWeight: FontWeight.w300,
                    color: Colors.red),
                contentPadding: const EdgeInsets.only(left: 120, right: 16)),
            inputFormatters: inputFormatter,
            validator: validator,
            onChanged: onChanged,
          ),
          Obx(
            ()=> Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              const  SizedBox(width: 16,),
                TextButton.icon(
                    onPressed: countryCodePickerCallback,
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(Colors.transparent)
                    ),
                    icon: Text( selectedCountry.value?.flagEmoji??""),
                    label: Text(
                      '+${selectedCountry.value?.phoneCode??''}',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          fontSize: AppConsts.commonFontSizeFactor * 12,
                          color: Colors.black.withOpacity(0.4),
                          fontWeight: FontWeight.w300),
                    )),
                const SizedBox(
                  width: 16,
                ),
                Container(
                  width: 1,
                  height: 46,
                  color: AppColors.color_DC,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
