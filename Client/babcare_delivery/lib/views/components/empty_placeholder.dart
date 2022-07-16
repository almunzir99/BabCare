import 'package:babcare_delivery/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class EmptyPlaceholder extends StatelessWidget {
  const EmptyPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            LineIcons.wind,
            color: accentColor,
            size: 44.0,
          ),
          const SizedBox(
            height: 15.0,
          ),
          // ignore: prefer_const_constructors
          Text("لا توجد عناصر"),
          const SizedBox(
            height: 15.0,
          ),
        ],
      ),
    );
  }
}
