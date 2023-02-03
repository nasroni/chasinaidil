import 'package:chasinaidil/app/data/types/song.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SongTitle extends StatelessWidget {
  const SongTitle({
    super.key,
    required this.song,
  });

  final Song song;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          // Title display
          child: Text(
            "${song.songNumber}. ${song.title}",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: context.theme.primaryColor,
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        // indicate there is more to see
        Icon(
          Icons.keyboard_arrow_down_sharp,
          color: context.theme.primaryColor,
        )
      ],
    );
  }
}
