import 'package:flutter/material.dart';

class SizedSpacer extends StatelessWidget {
  final double width;
  final double height;

  const SizedSpacer({Key? key, this.width = 0, this.height = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size(width, height),
    );
  }
}
