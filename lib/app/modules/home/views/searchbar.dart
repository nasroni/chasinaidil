import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class SearchBar extends StatelessWidget {
  SearchBar({
    Key? key,
  }) : super(key: key);

  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              vertical: Platform.isAndroid ? 15 : 10,
              horizontal: _homeController.isSearchActive.value ? 10 : 15),
          width: _homeController.isSearchActive.value
              ? context.width - 70
              : context.width,
          child: CupertinoSearchTextField(
            autocorrect: false,
            placeholder: 'Ҷустуҷӯ',
            onTap: () {
              _homeController.openSearch();
            },
            onChanged: (value) => _homeController.searchValue.value = value,
            controller: _homeController.searchEditingController,
            /*onSubmitted: (value) {
              _homeController.closeSearch();
              FocusScope.of(context).requestFocus();
            },*/
          ),
        ),
        _homeController.isSearchActive.value
            ? TextButton(
                onPressed: () {
                  _homeController.closeSearch();
                  FocusScope.of(context).unfocus();
                },
                child: const Text("Қатъ"),
              )
            : Container(),
      ],
    );
  }
}
