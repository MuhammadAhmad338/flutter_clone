// ignore_for_file: unused_import, unused_field, unused_local_variable
import 'package:flutter/material.dart';
import 'package:flutter_clone/models/user.dart';
import 'package:flutter_clone/resources/authentication.dart';

class Provider1 with ChangeNotifier{
       
  User1? _user1;
  
  final Authentication _authentication = Authentication();

  User1 get getUser => _user1!;
       
  Future<void> refreshUser() async {
    User1 authentication1 =  await _authentication.getUserdetails();
    _user1 = authentication1;
    notifyListeners();
  }
  
}