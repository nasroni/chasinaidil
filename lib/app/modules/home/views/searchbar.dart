import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class SearchBar extends StatelessWidget {
  SearchBar({
    Key? key,
  }) : super(key: key);

  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              vertical: Platform.isAndroid ? 15 : 10,
              horizontal: controller.isSearchActive.value ? 10 : 15),
          width: controller.isSearchActive.value ? Get.width - 70 : Get.width,
          child: CupertinoSearchTextField(
            autocorrect: false,
            placeholder: 'Ҷустуҷӯ',
            onTap: () {
              controller.openSearch();
            },
            onSubmitted: (value) {
              controller.closeSearch();
              FocusScope.of(context).requestFocus();
            },
          ),
        ),
        controller.isSearchActive.value
            ? TextButton(
                onPressed: () {
                  controller.closeSearch();
                  FocusScope.of(context).unfocus();
                },
                child: const Text("Қатъ"),
              )
            : Container(),
      ],
    );
  }
}
