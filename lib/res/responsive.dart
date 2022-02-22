import 'package:flutter/material.dart';
import 'package:flutter_clone/provider/provider.dart';
import 'package:flutter_clone/util/dimensions.dart';
import 'package:provider/provider.dart';

class Responsive extends StatefulWidget {

  final Widget mobileScreenLayout;
  final Widget webScreenLayout;

  const Responsive({ Key? key,
   required this.mobileScreenLayout,
   required this.webScreenLayout}) : super(key: key);

  @override
  State<Responsive> createState() => _ResponsiveState();
}

class _ResponsiveState extends State<Responsive> {

  void addData() async {
    Provider1 provider1 = Provider.of(context, listen: false);
    await provider1.refreshUser();
  }

  @override
  void initState() {
    super.initState();
    addData();
  }

  @override
  Widget build(BuildContext context) {
    
    return LayoutBuilder(
      builder: (context, contraints){
        if(contraints.maxWidth > maxScreenSize){
           return widget.webScreenLayout;
        }
        else{
           return widget.mobileScreenLayout; 
        }
      } 
      );
  }
}