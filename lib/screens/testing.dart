import 'package:flutter/material.dart';

class Flutter extends StatelessWidget {
  const Flutter({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter')
      ),
      body: Center(
        child: Text('Hello World!'),
      ),
    );
  }
}