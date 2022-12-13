import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_jamaica_provider/config/app_colors.dart';
import 'package:insta_jamaica_provider/views/common/widgets/common_button.dart';
import 'package:insta_jamaica_provider/views/common/widgets/common_button_outline.dart';




class TakeImageBottomSheet {
  static show(BuildContext context, {required Function(ImageSource) imageSource}) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return TakeImageBottomSheetContent(imageSource: imageSource,);
          },
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24), topRight: Radius.circular(24))));
  }
}

class TakeImageBottomSheetContent extends StatelessWidget {



   TakeImageBottomSheetContent({
     Key? key,
    required this.imageSource
   }) : super(key: key);

   Function(ImageSource source) imageSource;


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 32,
          ),

          CommonButton(text: 'take_a_photo'.tr, clickAction: () {

            imageSource(ImageSource.camera);
          }),
          const SizedBox(
            height: 8,
          ),
          CommonButton(text: 'choose_from_gallery'.tr, clickAction: () {
            imageSource(ImageSource.gallery);
          }),

          const SizedBox(
            height: 24,
          ),
          CommonButtonOutline(text: 'cancel'.tr, clickAction: () {},
            borderColor: Colors.grey.shade400,
            textColor: AppColors.textColorPrimary,
            elevation: 0,),

          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}
