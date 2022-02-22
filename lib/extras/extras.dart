// ignore_for_file: unused_import, prefer_equal_for_default_values, prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clone/models/user.dart';
import 'package:flutter_clone/res/mobile_screen_layout.dart';
import 'package:flutter_clone/res/responsive.dart';
import 'package:flutter_clone/res/web_screen_layout.dart';
import 'package:flutter_clone/screens/login_screen.dart';
import 'package:flutter_clone/util/colors.dart';

class FlutterStreamBuilder{
   StreamBuilder<User?> helloWorld() {
     return  StreamBuilder(
      stream:  FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.active){
          if(snapshot.hasData){
            return const Responsive(
            mobileScreenLayout: MobileScreen(),
            webScreenLayout: WebScreen()
            );
          }
          else if(snapshot.hasError){
            return Center(
              child: Text("${snapshot.error}"),);
          }
        }
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(
               color: primaryColor,
              ),
            );   
          }      
           return LogIn();  
        }
   );
   } 
}