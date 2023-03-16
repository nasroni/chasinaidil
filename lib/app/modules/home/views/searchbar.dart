import 'dart:io';

import 'package:chasinaidil/app/modules/app_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class SearchBar extends StatelessWidget {
  SearchBar({
    Key? key,
  }) : super(key: key);

  final HomeController _homeController = Get.find();
  final AppController appc = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _homeController.closeSearch();
        FocusScope.of(context).unfocus();
        _homeController.searchEditingController.clear();
        return Future.value(false);
      },
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Platform.isAndroid ? 15 : 10,
                horizontal: _homeController.isSearchActive.value ? 10 : 15),
            width: _homeController.isSearchActive.value
                ? context.width - 70
                : context.width,
            child: CupertinoSearchTextField(
              style: TextStyle(color: context.theme.primaryColor),
              autocorrect: false,
              placeholder: 'Ҷустуҷӯ',
              placeholderStyle: TextStyle(
                color: context.theme.primaryColor.withAlpha(130),
              ),
              onTap: () {
                _homeController.openSearch();
              },
              onChanged: (value) => _homeController.searchValue.value = value,
              controller: _homeController.searchEditingController,
              keyboardType: TextInputType.name,
              backgroundColor: context.theme.dividerColor,
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
      ),
    );
  }
}
