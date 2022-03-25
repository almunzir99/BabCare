import 'package:babcare/theme/style.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final Color? fillColor;
  final String? label;
  final IconData? icon;
  final String? value;
  final String? Function(String?)? validator;
  final void Function(String?)? onChange;
  final bool isObscure;
  final EdgeInsets padding;
  final TextInputType inputType;
  final int? maxLines;
  const CustomTextFormField(
      {Key? key,
      @required this.label,
      this.icon,
      this.controller,
      this.fillColor,
      this.value,
      this.validator,
      this.onChange,
      this.isObscure = false,
      this.inputType = TextInputType.text,
      this.padding =
          const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
      this.maxLines = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextFormField(
          obscureText: isObscure,
          controller: controller,
          maxLines: maxLines,
          initialValue: value,
          keyboardType: inputType,
          decoration: InputDecoration(
            focusColor: primaryColor,
            fillColor: (fillColor == null) ? Colors.grey.shade200 : fillColor,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            labelText: "$label",
            hintText: "$label",
            prefixIcon: Icon(icon),
          ),
          onChanged: onChange,
          validator: validator),
    );
  }
}
