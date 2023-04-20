import 'package:expenso_31/ui_helper.dart';
import 'package:flutter/material.dart';

class CustomRoundedBtn extends StatelessWidget {
  var title;
  VoidCallback action;
  var mWidth;
  Color mColor;
  Color textColor;
  bool isLoading;

  CustomRoundedBtn(
      {required this.title, required this.action, required this.mWidth, required this.mColor, required this.textColor, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: mWidth,
        height: 50,
        child: ElevatedButton(
          onPressed: action,
          style: ElevatedButton.styleFrom(
              primary: mColor, shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(21)
          )),
          child: isLoading ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircularProgressIndicator(),
              Text(title, style: mTextStyle25(mColor: textColor))
            ],
          ) : Text(title, style: mTextStyle25(mColor: textColor)),
        ));
  }
}
