import 'dart:developer';

import 'package:chasinaidil/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchResultView extends StatelessWidget {
  SearchResultView({super.key});

  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.separated(
        separatorBuilder: (context, index) => const Divider(
          thickness: 0.5,
          indent: 6,
          endIndent: 6,
        ),
        padding: const EdgeInsets.all(0),
        itemCount: _homeController.titelSearchResults.length,
        itemBuilder: ((context, index) {
          final currentResult = _homeController.titelSearchResults[index];
          final albumCoverString =
              "assets/chasinaidil/covers/cd_${currentResult.albumId.toString().padLeft(2, "0")}.jpg";
          return Row(
            children: [
              Container(
                height: 55,
                padding: const EdgeInsets.fromLTRB(6, 4, 12, 4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    albumCoverString,
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
