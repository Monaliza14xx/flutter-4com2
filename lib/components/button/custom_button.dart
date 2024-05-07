
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.btnFunc,
      required this.btnColor,
      required this.btnText})
      : super(key: key);
  final Function() btnFunc;
  final Color btnColor;
  final String btnText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: btnFunc,
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: btnColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        child: Text(btnText));
  }
}