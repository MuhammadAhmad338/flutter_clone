// ignore_for_file: unused_import, prefer_final_fields, empty_catches, prefer_void_to_null, avoid_types_as_parameter_names, non_constant_identifier_names, prefer_const_constructors, unused_local_variable, null_check_always_fails, avoid_print
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clone/models/post.dart';
import 'package:flutter_clone/resources/storage.dart';
import 'package:flutter_clone/util/extras.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods{  
    // ignore: unused_field
    final FirebaseFirestore _firestore = FirebaseFirestore.instance; 
     //uploading post
    Future<String> postImage(
      String description,
      Uint8List file,
      String username,
      String uid,
      String profImage      
    ) async {
     
      String postId = Uuid().v1();
      String res = "Some error Occured!";
       try{

        String photoUrl =  await Storage().storageThing('posts', file, true);
 
        Post post = Post(
        description: description,
        uid: uid,
        username: username, 
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        profImage: profImage,
        likes: [] 
        );
      
       _firestore.collection('posts').doc(postId).set(post.toJson());

       res = 'Success!';

       }
       catch(err){
          res = err.toString();
       }
       return res;
    }

    Future<void> likePost(String postId, String uid, List likes) async{
    try{
       if(likes.contains(uid)){
         await _firestore.collection('posts').doc(postId).update({
           'likes': FieldValue.arrayRemove([uid])
         });
       }
       else{
         await _firestore.collection('posts').doc(postId).update({
           'likes': FieldValue.arrayUnion([uid])
         });
       }
    }
    catch(e){
      print(e.toString());
    }}

    Future<void> uploadComment(String postId, String comments, String uid, String text, String username) async {
     try{
       if(comments.isNotEmpty){
       String commentId = const Uuid().v1();
       await  _firestore.collection('posts').doc(postId).collection('comments').doc(commentId).set(
        {
          'postId': postId,
          'comments': comments,
          'uid': uid,
          'username': text,
          'commentId': commentId,
          'datePublished': DateTime.now()
        }
      );
       }
       else{ 
        print('Text is Empty!');
       }
     }
     catch(e){
      print(e.toString());
     }
    }

    Future<void> deletePost(String postId) async {
    try{
      await _firestore.collection('posts').doc(postId).delete();
    }
    catch(err){
      print(err.toString());
     }   
    }
   
}