import 'package:babcare/theme/style.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final bool isLoading;
  final double width;
  final double? height;
  final Color? color;
  final Color? foreColor;
  final double borderRadius;
  final void Function()? onTap;
  final double? fontSize;
  final double? iconSize;
  const CustomButton(
      {Key? key,
      required this.text,
      this.icon,
      required this.width,
      this.isLoading = false,
      this.borderRadius = 15.0,
      this.onTap,
      this.fontSize = 17.0,
      this.iconSize = 24.0,
      this.color,
      this.height,
      this.foreColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          if (onTap != null && !isLoading) onTap!();
        },
        child: Ink(
          decoration: BoxDecoration(
              color: color != null
                  ? color!.withOpacity(isLoading ? .6 : color!.opacity)
                  : primaryColor.withOpacity(isLoading ? .6 : 1),
              borderRadius: BorderRadius.circular(borderRadius)),
          child: Container(
            width: width,
            height: height,
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isLoading ? "الرجاء الانتظار ..." : text,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: foreColor,
                      fontSize: fontSize),
                ),
                SizedBox(
                  width: isLoading || icon != null ? 10.0 : 0,
                ),
                Visibility(
                  visible: isLoading,
                  child: SizedBox(
                    height: 20.0,
                    width: 20.0,
                    child: CircularProgressIndicator(
                      color: foreColor,
                      strokeWidth: 2.0,
                    ),
                  ),
                ),
                Visibility(
                  visible: !isLoading && icon != null,
                  child: Icon(icon, color: foreColor, size: iconSize),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
