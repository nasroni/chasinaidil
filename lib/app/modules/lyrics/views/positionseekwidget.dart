import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class PositionSeekWidget extends StatefulWidget {
  final Duration currentPosition;
  final Duration duration;
  final Function(Duration) seekTo;

  const PositionSeekWidget({
    super.key,
    required this.currentPosition,
    required this.duration,
    required this.seekTo,
  });

  @override
  PositionSeekWidgetState createState() => PositionSeekWidgetState();
}

class PositionSeekWidgetState extends State<PositionSeekWidget> {
  late Duration _visibleValue;
  bool listenOnlyUserInterraction = false;
  double get percent => widget.duration.inMilliseconds == 0
      ? 0
      : _visibleValue.inMilliseconds / widget.duration.inMilliseconds;

  @override
  void initState() {
    super.initState();
    _visibleValue = widget.currentPosition;
  }

  @override
  void didUpdateWidget(PositionSeekWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listenOnlyUserInterraction) {
      _visibleValue = widget.currentPosition;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 38,
          child: Text(
            durationToString(widget.currentPosition),
            style: context.theme.textTheme.labelSmall,
          ),
        ),
        Expanded(
          child: SliderTheme(
            data: SliderThemeData(
              thumbShape: SliderComponentShape.noThumb,
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 10),
              trackHeight: 4,
              overlayColor: Colors.transparent,
              activeTrackColor: context.isDarkMode
                  ? Colors.grey.shade400
                  : Colors.grey.shade500,
              inactiveTrackColor: context.isDarkMode
                  ? Colors.grey.shade800
                  : Colors.grey.shade300,
            ),
            child: Slider(
              min: 0,
              max: widget.duration.inMilliseconds.toDouble(),
              value: percent * widget.duration.inMilliseconds.toDouble(),

              /*style:
                    SliderStyle(variant: Colors.grey, accent: Colors.grey[500]),*/
              onChangeEnd: (newValue) {
                setState(() {
                  listenOnlyUserInterraction = false;
                  widget.seekTo(_visibleValue);
                });
              },
              onChangeStart: (_) {
                setState(() {
                  listenOnlyUserInterraction = true;
                });
              },
              onChanged: (newValue) {
                setState(() {
                  final to = Duration(milliseconds: newValue.floor());
                  _visibleValue = to;
                });
              },
            ),
          ),
        ),
        SizedBox(
          width: 38,
          child: Text(
            durationToString(widget.duration),
            style: context.theme.textTheme.labelSmall,
          ),
        ),
      ],
    );
  }
}

String durationToString(Duration duration) {
  if (duration == const Duration(minutes: 61)) return '';
  String twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }

  final twoDigitMinutes =
      twoDigits(duration.inMinutes.remainder(Duration.minutesPerHour));
  final twoDigitSeconds =
      twoDigits(duration.inSeconds.remainder(Duration.secondsPerMinute));
  return '$twoDigitMinutes:$twoDigitSeconds';
}
