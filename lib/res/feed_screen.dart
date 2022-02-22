// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clone/util/colors.dart';
import 'package:flutter_clone/widgets/post_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({ Key? key }) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: SvgPicture.asset("assets/ic_instagram.svg",
        color: Colors.white,
        ),
        actions: [
          IconButton(
           onPressed: () {},
           icon: const Icon(
             Icons.send,
             color: Colors.white
           )
           )
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
            }
         
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => PostScreen(
                snap: snapshot.data!.docs[index].data()    
                )
              );
        }
        ),
    );
  }
}