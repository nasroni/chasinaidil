import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/lyrics_controller.dart';
import 'popupcustommenuitem.dart';

class TransposeButtons extends StatelessWidget {
  TransposeButtons({super.key});

  final LyricsController controller = Get.find();

  final squareButtonSize = const MaterialStatePropertyAll(Size.square(10));

  @override
  Widget build(BuildContext context) {
    // without sized box, everything does what it wants to
    return SizedBox(
      height: kMinInteractiveDimensionCupertino,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // decrease transpose level
          SizedBox(
            width: kMinInteractiveDimensionCupertino,
            height: kMinInteractiveDimensionCupertino,
            child: TextButton(
              style: buttonMyCustomStyle(),
              onPressed: () => controller.decreaseTranspose(),
              child: const Icon(
                Icons.remove,
                color: Colors.black,
              ),
            ),
          ),
          const VerticalDivider(
            width: 0,
          ),
          // indicate that this line is for transposing and for resetting transposing
          Expanded(
            child: TextButton(
              style: buttonMyCustomStyle(),
              onPressed: () => controller.resetTranspose(),
              child: Container(
                height: kMinInteractiveDimensionCupertino,
                padding: const EdgeInsets.only(left: 15, right: 15),
                alignment: Alignment.center,
                child: RichText(
                  text: const TextSpan(
                      text: 'Интиқол\n',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      children: [
                        TextSpan(
                          text: '(Транспозиция)',
                          style: TextStyle(
                              fontSize: 11, fontStyle: FontStyle.italic),
                        )
                      ]),
                  maxLines: 2,
                  textScaleFactor: 0.92,
                  textAlign: TextAlign.center,
                  /*style: TextStyle(
                    color: Colors.black,
                  ),*/
                ),
              ),
            ),
          ),
          const VerticalDivider(
            width: 0,
          ),
          // increase transpose level
          SizedBox(
            width: kMinInteractiveDimensionCupertino,
            height: kMinInteractiveDimensionCupertino,
            child: TextButton(
              onPressed: () => controller.increaseTranspose(),
              style: buttonMyCustomStyle(),
              child: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // button settings as well as click animation via materialstateproperty
  ButtonStyle buttonMyCustomStyle() {
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
      shape: const MaterialStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero))),
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
