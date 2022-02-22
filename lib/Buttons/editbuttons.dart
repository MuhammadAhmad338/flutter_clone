// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class EditButton extends StatelessWidget {
  final Function()? function;
  final Color backgroundColor;
  final Color borderColor;
  final String text;
  final Color textColor;

  const EditButton(
      {Key? key,
      this.function,
      required this.backgroundColor,
      required this.borderColor,
      required this.text,
      required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 2),
      child: TextButton(
        onPressed: function,
        child: Container(
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: borderColor, width: 2)
          ),
          alignment: Alignment.center,
          child: Text('Edit Profile',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: 20         
          ),
          ),
          width: 250,
          height: 25
          ),
        )
        );
  }
}