import 'package:flutter/material.dart';

class BlueHeaderBar extends StatelessWidget {
  final double height;
  final BorderRadius? borderRadius;

  const BlueHeaderBar({super.key, this.height = 8.0, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: Colors.blue.shade300,
        borderRadius: borderRadius,
      ),
    );
  }
}
