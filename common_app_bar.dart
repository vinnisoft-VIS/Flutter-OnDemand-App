import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta_jamaica_provider/consts/app_icons.dart';

class CommonAppBar extends StatelessWidget with PreferredSizeWidget {
   CommonAppBar({
    Key? key, required this.title,
     this.onBackTap,
     this.actions,

     this.leading
  })
      : super(key: key);

  final String title;
  final List<Widget>?  actions;
  final Function()? onBackTap;
  Widget? leading;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(

      leading: leading??IconButton(
        onPressed: () {
          if(onBackTap !=null){
            onBackTap!();
          }

        },
        icon: SvgPicture.asset(
          AppIcons.ic_back,
          height: 22,
        ),
      ),
      title: Text(title),
      titleTextStyle
      :Theme.of(context).appBarTheme.titleTextStyle,
      backgroundColor: Colors.white,
      centerTitle: true,
      titleSpacing: 0,
      actions: actions,

    );
  }
}
