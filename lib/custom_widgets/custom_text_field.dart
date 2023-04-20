import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  var controller;
  Color borderColor;
  Color fillColor;
  IconData mIcon;

  CustomTextField({required this.controller,
    required this.borderColor,
    required this.fillColor,
    required this.mIcon
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        prefixIcon: Icon(mIcon),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: BorderSide(
            color: borderColor.withOpacity(0.2),
            width: 0
          )
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
            borderSide: BorderSide(
                color: borderColor,
                width: 0
            )
    )
      ),
    );
  }
}
