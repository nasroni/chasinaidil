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
        separatorBuilder: (context, index) => Divider(),
        padding: const EdgeInsets.all(0),
        itemCount: _homeController.searchResults.length,
        itemBuilder: ((context, index) {
          final currentResult = _homeController.searchResults[index];
          return Row(
            children: [
              Flexible(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "${currentResult.songNumber}) ",
                          //style: TextStyle(fontFamily: 'UbuntuMono'),
                        ),
                        Flexible(
                          child: Text(
                            currentResult.title,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        /*const Text(
                          "     ",
                          style: TextStyle(fontFamily: 'UbuntuMono'),
                        ),*/
                        Text(
                          currentResult.book,
                          style: TextStyle(fontSize: 18),
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
