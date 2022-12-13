import 'package:flutter/material.dart';
import 'package:insta_jamaica_customer/config/app_colors.dart';
import 'package:insta_jamaica_customer/consts/app_consts.dart';
import 'package:insta_jamaica_customer/views/widgets/business/business_widget.dart';
import 'package:get/get.dart';
import '../../../../controller/home/home_controller.dart';
import '../../../../model/business_res_model.dart';
import '../../../widgets/business/business_widget_shimmer.dart';

class HomeBusinessesWidget extends StatelessWidget {
  HomeBusinessesWidget({
    Key? key,
    required this.title,
    required this.seeAllClick,
    required this.businesses,
    required this.isLoading,
  }) : super(key: key);

  final _homeController = Get.find<HomeController>();

  String title;
  Function(String title) seeAllClick;
  List<Business> businesses;
  RxBool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 8,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 16)]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 8,
                height: 20,
                decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(24)),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(
                  title.tr,
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                      fontSize: AppConsts.commonFontSizeFactor * 20,
                      color: AppColors.textColorPrimary),
                ),
              ),

                    GestureDetector(
                  onTap: () {
                    seeAllClick(title);
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.fromBorderSide(
                            BorderSide(color: Colors.grey.shade200))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'see_all'.tr,
                          style: Theme.of(context).textTheme.headline4?.copyWith(
                              fontSize: AppConsts.commonFontSizeFactor * 12,
                              color: Colors.black.withOpacity(0.4)),
                        ),
                        Icon(
                          Icons.navigate_next,
                          color: Colors.black.withOpacity(0.4),
                          size: 16,
                        )
                      ],
                    ),
                  ),
                ),

            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Expanded(
              child: Obx(
            () => ListView.separated(
              itemBuilder: (context, index) {
                return isLoading.value
                    ? BusinessWidgetShimmer()
                    : BusinessWidget(
                        toggleFav:
                            _homeController.toggleFavStatusRemote,
                        business: businesses[index],
                      );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  width: 16,
                );
              },
              itemCount: isLoading.value
                  ? 2
                  : (businesses.length > 2 ? 2 : businesses.length),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
            ),
          ))
        ],
      ),
    );
  }
}
