// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field, prefer_typing_uninitialized_variables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clone/Comments/comment_card.dart';
import 'package:flutter_clone/FirebaseMethods/firestoremethods.dart';
import 'package:flutter_clone/models/user.dart';
import 'package:flutter_clone/provider/provider.dart';
import 'package:flutter_clone/util/colors.dart';
import 'package:provider/provider.dart';

class CommentScreen extends StatefulWidget {

  final snap123;
  const CommentScreen({ Key? key, required this.snap123 }) : super(key: key);

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  
 final TextEditingController _controller = TextEditingController();
  
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User1 user = Provider.of<Provider1>(context).getUser;
    return  Scaffold(
          appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          title: Text("Comments"),
          centerTitle: false,
          actions: [
            IconButton(
            onPressed: () {},
            icon: Icon(Icons.send))
          ],
          ),
          body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('posts')
            .doc(widget.snap123['postId'])
            .collection('comments')
            .orderBy('datePublished', descending: true)
            .snapshots(),
            builder:(context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                 return const Center(
                  child: CircularProgressIndicator(),
                 );
            }      
            return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) => CommentCard(
                      snap: snapshot.data!.docs[index].data()
                    ));         
            }
            ),
          bottomNavigationBar: SafeArea(
          child: Container(
            height: kToolbarHeight,
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom
            ),
            padding: EdgeInsets.only(left: 12, right: 12),
            child: Row(
              children: [
                CircleAvatar(backgroundImage: NetworkImage(widget.snap123['postUrl'])),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Post the Comments',
                        border: InputBorder.none
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await FireStoreMethods().uploadComment(widget.snap123['postId'],
                   _controller.text,
                    user.username,
                    user.bio,
                    user.photoUrl);
                    setState(() {
                      _controller.text = "";
                    });
                   },
                  child: Container(padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                  child: const Text('POST',
                  style: TextStyle(
                    color: blueColor,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                  )
                )
              ],
            ),
          )),
      ); 
  }
}