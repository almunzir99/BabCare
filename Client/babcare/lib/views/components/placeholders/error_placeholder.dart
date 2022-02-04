import 'package:babcare/theme/style.dart';
import 'package:babcare/views/components/customer_button.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class ErrorPlaceHolder extends StatelessWidget {
  final void Function()? onTap;
  const ErrorPlaceHolder({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            LineIcons.plug,
            color: primaryColor,
            size: 34.0,
          ),
          const SizedBox(
            height: 15.0,
          ),
          // ignore: prefer_const_constructors
          Text("فشل تحميل البيانات"),
          const SizedBox(
            height: 15.0,
          ),
          CustomButton(
            onTap: onTap,
            text: "اعد المحاولة",
            width: 130.0,
            fontSize: 13.0,
            iconSize: 20.0,
            borderRadius: 15.0,
            icon: LineIcons.alternateRedo,
          )
        ],
      ),
    );
  }
}
