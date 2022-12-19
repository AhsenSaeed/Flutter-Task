import 'package:flutter/material.dart';
import 'package:fvrt_task/extension/context_extension.dart';
import 'package:fvrt_task/utils/app_strings.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget leadingWidget;
  final Widget middleTitleWidget;
  final Widget trailingWidget;
  final double preferredSizeHeight;
  final Function onPressed;

  const CustomAppBar(
      {required this.leadingWidget,
      required this.middleTitleWidget,
      required this.onPressed,
      required this.trailingWidget,
      required this.preferredSizeHeight});

  @override
  Size get preferredSize => Size.fromHeight(preferredSizeHeight);

  @override
  Widget build(BuildContext context) => PopupMenuButton(
      elevation: 20,
      constraints: BoxConstraints(maxWidth: context.screenSize.width),
      enabled: true,
      position: PopupMenuPosition.over,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      offset: const Offset(0, kToolbarHeight + 25),
      tooltip: '',
      splashRadius: 0,
      onSelected: (value) {
        onPressed(value);
      },
      itemBuilder: (context) {
        return [AppStrings.ALL, AppStrings.FAVOURITE]
            .map((String choice) => PopupMenuItem(
                textStyle: const TextStyle(color: Colors.black),
                value: choice,
                child: SizedBox(
                    width: context.screenSize.width, child: Text(choice))))
            .toList();
      },
      child:
          AppBar(centerTitle: true, title: middleTitleWidget, actions: const [
        Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(Icons.keyboard_arrow_down_outlined))
      ]));
}
