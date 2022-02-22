// ignore: unused_import
// ignore_for_file: empty_constructor_bodies
import 'package:cloud_firestore/cloud_firestore.dart';

class User1{
  
  final String email;
  final String password;
  final String username;
  final String bio;
  final String photoUrl;
  final List followers;
  final List following;


  const User1({
    required this.email,
    required this.password,
    required this.username,
    required this.bio,
    required this.photoUrl,
    required this.followers,
    required this.following,
    
  }); 
  
  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'username': username,
    'bio': bio,
    'photos': photoUrl,
    'followers': followers,
    'following': following
  };
 
    static User1 fromJson(DocumentSnapshot snapshot){
     // ignore: unused_local_variable
     var snaps = snapshot.data() as Map<String, dynamic>;
     return User1(
      email: snapshot['email'],
      password: snapshot['password'],
      username: snapshot['username'],
      bio: snapshot['bio'],
      followers: snapshot['followers'],
      following: snapshot['following'],
      photoUrl: snapshot['photos']
      );
   }
}