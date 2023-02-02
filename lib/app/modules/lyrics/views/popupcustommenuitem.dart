import 'dart:developer';

import 'package:chasinaidil/app/modules/lyrics/controllers/lyrics_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopupCustomMenuItem extends StatelessWidget {
  final String text;
  final IconData? icon;
  final bool width;
  final bool bold;
  final int position;
  final ViewModes? newViewMode;
  final void Function(BuildContext context)? onTapFunction;

  const PopupCustomMenuItem(
      {super.key,
      required this.text,
      required this.icon,
      this.width = true,
      this.bold = false,
      this.position = 0,
      this.newViewMode,
      this.onTapFunction});

  @override
  Widget build(BuildContext context) {
    LyricsController controller = Get.find();
    var newViewMode = this.newViewMode;

    return Builder(builder: (context) {
      return SizedBox(
        height: kMinInteractiveDimensionCupertino,
        child: TextButton(
          onPressed: () {
            if (newViewMode != null) {
              controller.setViewMode(newViewMode);
              Get.back();
            } else if (onTapFunction != null) {
              onTapFunction!(context);
            }
          },
          style: buttonMyCustomStyle(position),
          child: Container(
            width: width ? context.width / 1.33 : null,
            height: kMinInteractiveDimensionCupertino,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  // name of item / action, that is current line and button
                  text,
                  style: TextStyle(
                    color: Colors.black,
                    // mark for example when currently selected mode is
                    fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                // optical explanation of 'text'
                Icon(
                  icon,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  ButtonStyle buttonMyCustomStyle(int position) {
    //const MaterialStateProperty<Size?>? size = null;

    return ButtonStyle(
      splashFactory: NoSplash.splashFactory,
      padding: const MaterialStatePropertyAll(EdgeInsets.zero),
      elevation: const MaterialStatePropertyAll(0),
      /*fixedSize: size,
      minimumSize: size,
      maximumSize: size,*/
      textStyle:
          MaterialStatePropertyAll(Get.theme.primaryTextTheme.bodyMedium),
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: position == 1 ? const Radius.circular(10) : Radius.zero,
            bottom: position == -1 ? const Radius.circular(10) : Radius.zero,
          ),
        ),
      ),
      overlayColor: const MaterialStatePropertyAll(Colors.transparent),
      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return const Color.fromRGBO(209, 209, 209, 1);
        }
        return null;
      }),
    );
  }
}
