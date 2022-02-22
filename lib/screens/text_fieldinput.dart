// ignore_for_file: prefer_const_constructors, unused_local_variable
import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {

  final TextEditingController textEditingController;
  final bool isPass;
  final String hinttext;
  final TextInputType textInputType;

  const TextFieldInput({ Key? key,
  required this.textEditingController,
  this.isPass = false,
  required this.hinttext,
  required this.textInputType
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputText = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hinttext,
        border: inputText,
        enabledBorder: inputText,
        focusedBorder: inputText,
        filled: true,
        contentPadding: const EdgeInsets.all(8.0)
      ),
      obscureText: isPass,
      keyboardType: textInputType
    );
  }
}