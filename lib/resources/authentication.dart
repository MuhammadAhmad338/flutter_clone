// ignore_for_file: unused_field, unused_import, non_constant_identifier_names, unused_local_variable, avoid_print, unused_element, unnecessary_null_comparison
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_clone/resources/storage.dart';
import 'package:flutter_clone/screens/signup_screen.dart';
import 'package:flutter_clone/models/user.dart' as model;

class Authentication{
   
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User1> getUserdetails() async {
      User currentUser = _auth.currentUser!;

      DocumentSnapshot documentSnapshot = await _firestore.collection('users').doc(currentUser.uid).get();
      return model.User1.fromJson(documentSnapshot); 
  }
  
  Future<String> signUp({
  required String email,
  required String password,
  required String username,
  required String bio,
  required Uint8List file 
  }) async {
 
     String res = "Some error Occured";
     try{
      if(email.isNotEmpty || password.isNotEmpty || username.isNotEmpty || bio.isNotEmpty || file!=null){
        UserCredential  creds = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        print(creds.user!.uid);
        
          //Add file to the firebase storage
        String imageUrl = await Storage().storageThing("Profile", file, false);

        model.User1 user = model.User1(
          email: email,
          password: password,
          username: username,
          bio: bio,
          followers: [],
          following: [],
          photoUrl: imageUrl);
        
        //Add data to our firestore database
        await _firestore.collection('users').doc(creds.user!.uid).set(user.toJson());
        res = "Success";
      }
     }
     catch(error){
        res = error.toString();
     }
     return res;
  }
 
  Future<String?> loginScreen({
  required String email,
  required String password
  }) async {

  String res1 = "Some error Occured!";
  try{
  if(email.isNotEmpty != null || password.isNotEmpty){  
  UserCredential logInCred = await _auth.signInWithEmailAndPassword(email: email, password: password);
  res1 = "success";
  }
  else{
      res1 = "Please fill all the fields";
  }
  }
  catch(err){
     res1 = err.toString();
  }
    return res1;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }  
  
}

