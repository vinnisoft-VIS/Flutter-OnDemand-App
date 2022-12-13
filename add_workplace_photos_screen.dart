
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:insta_jamaica_provider/config/app_colors.dart';
import 'package:insta_jamaica_provider/config/app_routes.dart';
import 'package:insta_jamaica_provider/consts/app_consts.dart';
import 'package:insta_jamaica_provider/consts/app_icons.dart';
import 'package:insta_jamaica_provider/controller/setup_business_profile/add_workplace_photos_controller.dart';
import 'package:insta_jamaica_provider/views/bottom_sheets/take_image_bottom_sheet.dart';
import 'package:insta_jamaica_provider/views/common/widgets/common_app_bar.dart';
import 'package:insta_jamaica_provider/views/common/widgets/common_button.dart';
import 'package:insta_jamaica_provider/views/common/widgets/common_button_outline.dart';
import 'dart:io';

class AddWorkplacePhotosScreen extends StatelessWidget {
  AddWorkplacePhotosScreen({Key? key}) : super(key: key);
  final _addWorkplacePhotosController = Get.put(AddWorkplacePhotosController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      appBar: CommonAppBar(
          title: 'show_off_your_workplace'.tr,
          onBackTap: () {
            Get.back();
          }),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
              child: Text(
                'show_off_your_workplace_instructions'.tr,
                style: Theme.of(context).textTheme.headline5?.copyWith(
                    fontSize: AppConsts.commonFontSizeFactor * 12,
                    color: AppColors.color_B8),
              ),
            ),


            Obx(
    ()=> ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
                itemCount: _addWorkplacePhotosController.imagePaths.length,
                itemBuilder: (context,index){

              return AspectRatio(
                aspectRatio: 16/9,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
                    child: Image.file(File(_addWorkplacePhotosController.imagePaths[index]!),fit: BoxFit.fitWidth,),
                  ));

            }),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 16.0,right: 16.0,top: 16),
              child: DottedBorder(
                padding: const EdgeInsets.symmetric(horizontal: 58,vertical: 78),
                color: AppColors.color_B8,
                radius: const Radius.circular(16),
                dashPattern: [6],
                borderType: BorderType.RRect,
                child: GestureDetector(
                  onTap: (){
                    TakeImageBottomSheet.show(context,imageSource: (source){
                      Get.back();
                      _addWorkplacePhotosController.picImage(source);
                    });
                  },
                  child: Center(
                    child: Column(
                      children: [

                        SvgPicture.asset(AppIcons.ic_camera,height: 25,),

                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text('add_workspace_photo'.tr,style: Theme.of(context).textTheme.headline6?.copyWith(
                              fontSize: AppConsts.commonFontSizeFactor *12,
                              color: AppColors.color_B8
                          ),),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text('this_is_optional'.tr,
                            textAlign: TextAlign.center,
                            softWrap: true,

                            style: Theme.of(context).textTheme.headline6?.copyWith(
                                fontSize: AppConsts.commonFontSizeFactor *12,
                                color: AppColors.color_B8,
                                letterSpacing: 0.1
                            ),),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),


          ],
        ),
      ),
      
      bottomNavigationBar: Obx(
          ()=> Padding(
          padding:EdgeInsets.only(top: 16,bottom: Platform.isIOS ? 32 : 16),
          child:

              _addWorkplacePhotosController.imagePaths.isEmpty?
              CommonButtonOutline(text: 'skip'.tr, clickAction: (){
            Get.toNamed(AppRoutes.routeStartAddingServiceScreen);
          },backgroundColor: AppColors.appBackgroundColor,
          elevation: 0,)
                  : _addWorkplacePhotosController.isLoadingUpload.value?
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      height: 71,
                      width: 71,
                      margin: EdgeInsets.only(top: 16,bottom: Platform.isIOS ? 32 : 16),
                      padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
                      child: const CircularProgressIndicator()),
                ],
              ):
              Padding(
                padding: EdgeInsets.only(top: 16,bottom: Platform.isIOS ? 32 : 16),
                child: CommonButton(text: 'continue'.tr, clickAction: (){
                  _addWorkplacePhotosController.uploadImages();
                }),
              )


        ),
      ),
    );
  }
}
