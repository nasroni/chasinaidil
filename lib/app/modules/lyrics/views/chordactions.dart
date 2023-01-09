import 'package:chasinaidil/app/modules/lyrics/controllers/lyrics_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChordActions extends StatelessWidget {
  ChordActions({super.key});

  final LyricsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CupertinoButton(
            color: Colors.black26,
            padding: const EdgeInsets.all(0),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(8),
            ),
            onPressed: () => controller.increaseTranspose(),
            child: const Icon(Icons.add),
          ),
          CupertinoButton(
            color: Colors.black26,
            padding: const EdgeInsets.all(0),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            onPressed: () => controller.decreaseTranspose(),
            child: const Icon(Icons.remove),
          )
        ],
      ),
    );
  }
}
