// ignore_for_file: unused_import, unused_field, avoid_types_as_parameter_names, unused_local_variable

import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clone/models/user.dart';
import 'package:flutter_clone/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class Storage{

   final FirebaseStorage _storage = FirebaseStorage.instance;
   final FirebaseAuth _auth = FirebaseAuth.instance;

   Future<String> storageThing(String childname,  Uint8List profileFile, bool isPost) async {
      
      Reference ref =  _storage.ref().child(childname).child(_auth.currentUser!.uid);
      
      if(isPost){
        String uid = const Uuid().v1();
        ref = ref.child(uid);
      }
      
      UploadTask  uploadTask = ref.putData(profileFile);
      
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      return downloadUrl;
   }
}