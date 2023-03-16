import 'dart:math';

import 'package:chasinaidil/app/data/services/isar_service.dart';
import 'package:chasinaidil/app/data/types/album.dart';
import 'package:chasinaidil/app/data/types/song.dart';
import 'package:chasinaidil/app/modules/album/controllers/exchangedialog_controller.dart';
import 'package:chasinaidil/app/modules/app_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class ExchangeDialog extends StatelessWidget {
  ExchangeDialog({
    super.key,
    required this.album,
    //required this.viewController,
  });

  final Album album;
  final ExchangeDialogController exchangeDialogController =
      Get.put(ExchangeDialogController());

  //final LyricsController viewController;

  @override
  Widget build(BuildContext context) {
    /*appc.player.open(
      viewController.song.audio,
      autoStart: false,
      showNotification: true,
    );*/

    return AlertDialog(
      alignment: Alignment.topRight,
      insetPadding: const EdgeInsets.only(top: 55, right: 10, left: 10),
      elevation: 30,
      actionsPadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      //contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      iconPadding: EdgeInsets.zero,
      backgroundColor: context.theme.dialogBackgroundColor,
      scrollable: true,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      content: ExchangeView(
        album: album,
      ),
    );
  }
}

class ExchangeView extends StatelessWidget {
  ExchangeView({
    super.key,
    required this.album,
  });

  final Album album;
  final ExchangeDialogController exchangeDialogController = Get.find();

  @override
  Widget build(BuildContext context) {
    final AppController appc = Get.find();
    return Column(
      children: [
        if (album.albumId != 17)
          Obx(
            () {
              if (!appc.isSending.value) {
                return CupertinoButton(
                  onPressed: () {
                    appc.sendSongs(album);
                  },
                  color: context.theme.secondaryHeaderColor,
                  padding: const EdgeInsets.all(11),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        CupertinoIcons.share_up,
                        //color: context.theme.scaffoldBackgroundColor,
                      ),
                      Text(
                        "  равон кардан",
                      )
                    ],
                  ),
                );
              }
              return StreamBuilder(
                stream: appc.sendingPercentage,
                builder: (_, snapshot) {
                  double progress = snapshot.data?.toDouble() ?? 0.0;
                  return SizedBox(
                    height: 44,
                    child: LiquidLinearProgressIndicator(
                      backgroundColor: context.theme.scaffoldBackgroundColor,
                      borderRadius: 4,
                      value: progress / 100,
                      valueColor: AlwaysStoppedAnimation(
                        context.theme.secondaryHeaderColor,
                      ),
                      center: Text(
                        "${progress.round()} %",
                        style: context.theme.textTheme.bodyLarge,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        const SizedBox(
          height: 20,
        ),
        Obx(
          () {
            if (!appc.isReceiving.value) {
              return CupertinoButton(
                onPressed: () => appc.receiveSongs(),
                color: context.theme.secondaryHeaderColor,
                padding: const EdgeInsets.all(11),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      CupertinoIcons.arrow_down_square,
                      //color: context.theme.scaffoldBackgroundColor,
                    ),
                    Text(
                      "  қабул кардан",
                    )
                  ],
                ),
              );
            }
            return StreamBuilder(
              stream: appc.receivingPercentage,
              builder: (_, snapshot) {
                double progress = snapshot.data?.toDouble() ?? 0.0;
                return CupertinoButton(
                  onPressed: () => appc.receiveSongs(),
                  padding: EdgeInsets.zero,
                  child: SizedBox(
                    height: 44,
                    child: LiquidLinearProgressIndicator(
                      backgroundColor: context.theme.scaffoldBackgroundColor,
                      borderRadius: 4,
                      value: progress / 100,
                      valueColor: AlwaysStoppedAnimation(
                        context.theme.secondaryHeaderColor,
                      ),
                      center: Text(
                        "${progress.round()} %",
                        style: context.theme.textTheme.bodyLarge,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
        const SizedBox(
          height: 13,
        ),
        CupertinoButton(
          onPressed: () => exchangeDialogController.isExplainOpen.value =
              !exchangeDialogController.isExplainOpen.value,
          padding: EdgeInsets.zero,
          child: Row(
            children: [
              Obx(
                () => Icon(
                  CupertinoIcons.chevron_right,
                  color: context.theme.primaryColor,
                  size: 15,
                )
                    .animate(
                      target:
                          exchangeDialogController.isExplainOpen.value ? 1 : 0,
                    )
                    .custom(
                      begin: 0,
                      end: pi / 2,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.ease,
                      builder: (context, value, child) {
                        return Transform.rotate(
                          angle: value,
                          child: child,
                        );
                      },
                    ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Ин чист?',
                style: TextStyle(
                  color: context.theme.primaryColor,
                  //fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
        ),
        Obx(() {
          if (exchangeDialogController.isExplainOpen.value) {
            return const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                  'Шумо метавонед (ҳам бе интернет) аудиои сурудҳоро равон ё қабул кунед. Барои ин шумо тугмаи "равон кардан"-ро зер кунед, дар онҷо метавонед сурудҳоро ҳамчун "файл" ба дигар телефон гузаронед (мисол бо ShareMe ё Bluetooth).\nДар телефони дигар онро бо воситаи тугмаи "қабул кардан" кушоед.\n\nМутаассифона ҳар албомро алоҳида равон карда лозим аст. Шумо фақат сурудҳоеро равон карда метавонед, ки худатон боргирӣ кардааед.'),
            );
          }
          return Container();
        }),
      ],
    );
  }
}
