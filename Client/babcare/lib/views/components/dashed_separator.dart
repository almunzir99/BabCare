import 'package:flutter/material.dart';

class DashSeparator extends StatelessWidget {
  const DashSeparator(
      {Key? key,
      this.height = 0,
      this.color,
      this.dashHeight = 2,
      this.gaps = 2})
      : super(key: key);
  final double height;
  final Color? color;
  final double dashHeight;
  final double gaps;

  @override
  Widget build(BuildContext context) {
    int count = (height / (dashHeight + gaps)).floor();
    return SizedBox(
      height: height,
      child: Column(
        children: List.generate(count, (index) => index)
            .map((e) => Container(
                  height: dashHeight,
                  width: 2.0,
                  margin: EdgeInsets.only(bottom: gaps),
                  decoration: BoxDecoration(
                      color: color ?? Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(2)),
                ))
            .toList(),
      ),
    );
  }
}
