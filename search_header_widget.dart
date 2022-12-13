

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:insta_jamaica_customer/config/app_colors.dart';
import 'package:insta_jamaica_customer/config/app_routes.dart';
import 'package:insta_jamaica_customer/consts/app_consts.dart';
import 'package:insta_jamaica_customer/consts/app_icons.dart';
import 'package:insta_jamaica_customer/controller/home/home_controller.dart';
import 'package:insta_jamaica_customer/views/widgets/common_search_field.dart';

class SearchHeaderWidget extends StatelessWidget {

  final _homeController = Get.find<HomeController>();

  TextEditingController searchController;
  Function(String) onChange;
   SearchHeaderWidget({
     Key? key,
   required this.searchController,
     required this.onChange
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.only(left: 16,right: 16,bottom: 24,top: 16),
      margin: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 8,
      ),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.grey.shade200,
                blurRadius: 16)
          ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
              ()=> RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: 'Hello',
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                          fontSize: AppConsts.commonFontSizeFactor * 18,
                          color: Colors.black.withOpacity(0.6))),
                  const WidgetSpan(
                      child: SizedBox(
                        width: 4,
                      )),
                  TextSpan(
                      text: _homeController.profileController.userName.value,
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                          fontSize: AppConsts.commonFontSizeFactor * 18,
                          color: Colors.black.withOpacity(0.6))),
                  const TextSpan(text: ' 👋')
                ])),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'what_are_you_looking_today'.tr,
            style: Theme.of(context).textTheme.headline2?.copyWith(
                fontSize: AppConsts.commonFontSizeFactor * 30,
                color: Colors.black),
          ),
          const  SizedBox(height: 16,),


          Container(
            margin: EdgeInsets.only(top:10),
            height: 45,
            width: double.infinity,
            child: ElevatedButton.icon(onPressed: (){
              Get.toNamed(AppRoutes.routeSearchScreen);
            },
                icon: SvgPicture.asset(AppIcons.ic_search,color: Colors.black.withOpacity(0.4),),
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                    alignment:Alignment.centerLeft,
                    backgroundColor: MaterialStateProperty.all(AppColors.color_F5),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)
                  ))
                ),
                label: Text('search'.tr,style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: Colors.black.withOpacity(0.4),
                    fontSize: AppConsts.commonFontSizeFactor *12,
                    fontWeight: FontWeight.w300
                ),)),
          )
        ],
      ),
    );
  }
}
