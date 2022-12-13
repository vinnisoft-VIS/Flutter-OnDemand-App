import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:insta_jamaica_provider/config/app_colors.dart';
import 'package:insta_jamaica_provider/config/app_routes.dart';
import 'package:insta_jamaica_provider/consts/app_consts.dart';
import 'package:insta_jamaica_provider/consts/app_icons.dart';
import 'package:insta_jamaica_provider/controller/setup_business_profile/pick_address_map_controller.dart';
import 'package:insta_jamaica_provider/views/common/widgets/common_app_bar.dart';
import 'package:insta_jamaica_provider/views/common/widgets/common_button.dart';

class PickAddressMapScreen extends StatelessWidget {
  PickAddressMapScreen({Key? key}) : super(key: key);
  final _pickAddressMapController = Get.put(PickAddressMapController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      appBar: CommonAppBar(title: 'your_address'.tr, onBackTap: () {
        Get.back();
      }),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Text(
              'where_can_clients_find_you'.tr,
              style: Theme.of(context).textTheme.headline5?.copyWith(
                  fontSize: AppConsts.commonFontSizeFactor * 15,
                  color: AppColors.color_B8),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Obx(
                  () => GoogleMap(
                    initialCameraPosition: CameraPosition(
                        target: _pickAddressMapController.currentPosition.value,
                        tilt: AppConsts.mapCameraTilt,
                        zoom: AppConsts.mapCameraZoom),
                    onMapCreated: (GoogleMapController controller) {
                      _pickAddressMapController.mapControllerCompleter
                          .complete(controller);
                    },
                    zoomControlsEnabled: false,
                    onCameraMoveStarted: () {
                      _pickAddressMapController.currentAddress.value =
                          'getting_address'.tr;
                    },
                    onCameraIdle: () {
                      _pickAddressMapController.getAddress();
                    },
                    onCameraMove: (CameraPosition position) {
                      debugPrint("Camera move Position = $position");
                      _pickAddressMapController.currentPosition.value =
                          position.target;
                    },
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 16),
                      child: GestureDetector(
                        onTap: (){

                          Get.toNamed(AppRoutes.routeSearchAddressScreen);
                        },
                        child: Container(
                          constraints:
                          const BoxConstraints(maxHeight: 70, minHeight: 51),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 16),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.fromBorderSide(
                                  BorderSide(color: AppColors.kPrimaryColor))),
                          child:
                          Row(
                            children: [
                              SvgPicture.asset(AppIcons.ic_location_pin),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: VerticalDivider(
                                  width: 1,
                                  thickness: 1,
                                ),
                              ),
                              Expanded(
                                child: Obx(
                                      () => Text(
                                    _pickAddressMapController.currentAddress.value.tr,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        ?.copyWith(
                                        fontSize:
                                        AppConsts.commonFontSizeFactor * 15,
                                        color: AppColors.color_B8),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)
                      ),
                        child: IconButton(onPressed: (){
                          _pickAddressMapController.getCurrentLocation();
                        },
                        icon: Icon(Icons.gps_fixed,color: AppColors.kPrimaryColor,)))
                  ],
                ),

                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        AppIcons.ic_marker,
                        width: 70,
                      ),
                      const SizedBox(
                        height: 45,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top:16,bottom: Platform.isIOS ? 32 : 16),
            child: CommonButton(text: 'continue'.tr, clickAction: () {
             _pickAddressMapController.validateLocationCoordinates();
            }),
          )
        ],
      ),
    );
  }
}
