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
  const CustomButton(
      {Key? key,
      required this.text,
      this.icon,
      required this.width,
      this.isLoading = false,
      this.borderRadius = 20.0,
      this.onTap,
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
        child: Container(
          width: width,
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isLoading ? "الرجاء الانتظار ..." : text,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 17.0),
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
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
