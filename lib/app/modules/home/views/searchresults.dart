import 'dart:developer';

import 'package:chasinaidil/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class SearchResultView extends StatelessWidget {
  SearchResultView({super.key});

  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.separated(
        separatorBuilder: (context, index) {
          if (index != _homeController.searchResultLyricsBeginPosition.value) {
            return const Divider(
              thickness: 0.5,
              indent: 6,
              endIndent: 6,
            );
          } else {
            return Column(
              children: [
                Divider(
                  indent: Get.width / 4.5,
                  endIndent: Get.width / 4.5,
                  thickness: 2,
                ),
                Container(
                  //color: Colors.black12,
                  padding: const EdgeInsets.fromLTRB(0, 3, 0, 8),
                  child: const Text(
                    "Дар матн",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black45),
                  ),
                ),
              ],
            );
          }
        },
        padding: const EdgeInsets.all(0),
        itemCount: _homeController.searchResults.length,
        itemBuilder: ((context, index) {
          final currentResult = _homeController.searchResults[index];

          return Row(
            children: [
              Container(
                height: 55,
                padding: const EdgeInsets.fromLTRB(6, 4, 12, 4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    currentResult.coverAsset,
                  ),
                ),
              ),
              Flexible(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "${currentResult.songNumber}・",
                        ),
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.only(right: 15),
                            child: Text(
                              currentResult.title,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          currentResult.book,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black54),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
