import 'package:babcare/theme/style.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final bool isLoading;
  final double width;
  final Color? color;
  final double borderRadius;
  final void Function()? onTap;
  final double fontSize;
  final double iconSize;
  final double height;
  const CustomButton(
      {Key? key,
      required this.text,
      this.icon,
      required this.width,
      this.isLoading = false,
      this.borderRadius = 20.0,
      this.onTap,
      this.fontSize = 17.0,
      this.iconSize = 24.0,
      this.height = 50.0,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null && !isLoading) onTap!();
      },
      child: Ink(
        decoration: BoxDecoration(
            color: color != null
                ? color!.withOpacity(isLoading ? .6 : 1)
                : primaryColor.withOpacity(isLoading ? .6 : 1),
            borderRadius: BorderRadius.circular(borderRadius)),
        child: SizedBox(
          width: width,
          height: height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isLoading ? "الرجاء الانتظار ..." : text,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: fontSize),
              ),
              SizedBox(
                width: isLoading || icon != null ? 10.0 : 0,
              ),
              Visibility(
                visible: isLoading,
                child: const SizedBox(
                  height: 20.0,
                  width: 20.0,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.0,
                  ),
                ),
              ),
              Visibility(
                visible: !isLoading && icon != null,
                child: Icon(icon, color: Colors.white, size: iconSize),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
