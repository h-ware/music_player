import 'package:flutter/material.dart';

class Scrubber extends StatelessWidget {
  final double position;

  const Scrubber({Key? key, required this.position}) : super(key: key);

  static const double TIMELINE_HEIGHT = 4;
  static const double SCRUBBER_DIAMETER = 10;

  @override
  Widget build(BuildContext context) {
    const double timelineInset = SCRUBBER_DIAMETER / 2 - TIMELINE_HEIGHT / 2;
    final double width = MediaQuery
        .of(context)
        .size
        .width;
    final double progress = width * position;
    final double scrubberLeft = progress - (SCRUBBER_DIAMETER / 2);
    return Container(
      height: SCRUBBER_DIAMETER,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: timelineInset),
            width: width,
            height: TIMELINE_HEIGHT,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.white.withOpacity(.18),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: timelineInset),
            width: progress,
            height: TIMELINE_HEIGHT,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.white,
            ),
          ),
          Positioned(
            left: scrubberLeft,
            child: Container(
              width: SCRUBBER_DIAMETER,
              height: SCRUBBER_DIAMETER,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
