// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_import, sized_box_for_whitespace, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ElevatedButtons extends StatelessWidget {
  double? width;
  double? height;
  void Function()? onPressed;
  String? text;
  Color? textcolor;
  FontWeight? fontWeight;
  String? fontFamily;
  IconData? iconName;
  double? iconsize;
  Color? iconcolor;
  WidgetStateProperty<Color?>? backgroundColor;
  ElevatedButtons(
      {super.key,
      this.width,
      this.height,
      this.onPressed,
      this.text,
      this.textcolor,
      this.fontWeight,
      this.fontFamily,
      this.iconName,
      this.iconsize,
      this.iconcolor,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: backgroundColor,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(
              iconName,
              color: iconcolor,
              size: iconsize,
            ),
            SizedBox(
              width: 10,
            ),
            Center(
              child: Text(
                '$text',
                style: TextStyle(
                  fontFamily: '$fontFamily',
                  color: textcolor,
                  letterSpacing: 0,
                  fontWeight: fontWeight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
