import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_jamaica_provider/config/app_colors.dart';
import 'package:insta_jamaica_provider/consts/app_consts.dart';
import 'package:insta_jamaica_provider/controller/setup_business_profile/search_address_controller.dart';
import 'package:insta_jamaica_provider/views/common/widgets/common_app_bar.dart';
import 'package:insta_jamaica_provider/views/common/widgets/common_search_field.dart';
import 'package:insta_jamaica_provider/views/common/widgets/search_address_widget.dart';

class SearchAddressScreen extends StatelessWidget {
  SearchAddressScreen({Key? key}) : super(key: key);

  final _searchAddressController = Get.put(SearchAddressController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      appBar: CommonAppBar(
          title: 'enter_your_address'.tr,
          onBackTap: () {
            Get.back();
          }),
      body:
      Column(
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
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16),
            child: CommonSearchField(
              controller: _searchAddressController.searchEditingController,
              onChanged: _searchAddressController.searchKeyword,
              hint: 'what_is_your_address'.tr,
              isShowTrailing: _searchAddressController.isShowTrailing,
              trailing: IconButton(
                  onPressed: () {
                    _searchAddressController.clearSearchField();
                  },
                  icon: Icon(Icons.cancel)),
            ),
          ),
          Obx(
            () => Expanded(
              child: _searchAddressController.isEmptyList.value ||
                      _searchAddressController.isLoadingPlaces.value
                  ? Center(
                      child: Text(
                      _searchAddressController.isLoadingPlaces.value
                          ? 'message_loading_places'.tr
                          : _searchAddressController.isEmptyList.value
                              ? 'message_no_location_found_try_searching'.tr
                              : '',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                          color: AppColors.color_B8,
                          fontSize: AppConsts.commonFontSizeFactor * 15),
                    ))
                  : ListView.separated(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return SearchAddressWidget(
                          place: _searchAddressController.places[index],
                          onClick: (){
                            FocusManager.instance.primaryFocus?.unfocus();
                            _searchAddressController.pickAddress(index);
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: _searchAddressController.places.length),
            ),
          )
        ],
      ),
    );
  }
}
