// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, prefer_typing_uninitialized_variables, avoid_unnecessary_containers, prefer_const_constructors_in_immutables, unnecessary_brace_in_string_interps
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clone/Comments/comments.dart';
import 'package:flutter_clone/FirebaseMethods/firestoremethods.dart';
import 'package:flutter_clone/animations/animations.dart';
import 'package:flutter_clone/models/user.dart';
import 'package:flutter_clone/provider/provider.dart';
import 'package:flutter_clone/util/colors.dart';
import 'package:flutter_clone/util/extras.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostScreen extends StatefulWidget {
  
  final snap;
  PostScreen({ Key? key,
    required this.snap }) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  
  bool isLikeAnimating = false;
  int commentsLength = 0;    
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    comments();
  }

  void comments() async {
   try{
    QuerySnapshot snaps =  await FirebaseFirestore.instance.collection('posts').doc(widget.snap['postId']).collection('comments').get();
    commentsLength = snaps.docs.length;
   }
   catch(e){
     showSnackBar(e.toString(), context);
   }
   setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    final User1 user = Provider.of<Provider1>(context).getUser;

    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 4.0,
              horizontal: 16.0
            ).copyWith(right: 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                  widget.snap['postUrl']
                  ),
                ),
                Expanded(
                 child: Padding(
                   padding: EdgeInsets.only(
                     left: 8.0
                   ),
                   child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.snap['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold), 
                      )],
                   ),
                   ),
                ),
                IconButton(
                 onPressed: () => showDialog(context: context, builder: (context) => Dialog(
                 child: ListView(
                 padding: const EdgeInsets.symmetric(vertical: 16),
                 shrinkWrap: true,
                 children: [
                   "Delete",
                 ].map((e) => InkWell(
                   onTap: () async { 
                    FireStoreMethods().deletePost(widget.snap['postId']);
                    Navigator.of(context).pop();
                    },
                   child: Container(
                     padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                     child: Text(e)
                   ),
                 )
                 ).toList()
                 ),  
                 )                 
                 ),
                 icon: const Icon(Icons.more_vert)
                 ),
              ],
            ),
          ),
          GestureDetector(
            onDoubleTap: () async {
              await FireStoreMethods().likePost(     
                widget.snap['postId'],   
                user.username,
                widget.snap['likes']
              );
              setState(() {
                isLikeAnimating = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                width: double.infinity,
                child: Image.network(widget.snap['postUrl'],
                fit: BoxFit.fill
                ),
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 175),
                opacity: isLikeAnimating ? 1 : 0,
                child: LikeAnimation(
                 child: const Icon(Icons.favorite, color: Colors.white, size: 117),
                 isAnimating: isLikeAnimating,
                 time: const Duration(milliseconds: 175),
                 onEnd: () {
                   setState(() {
                     isLikeAnimating = false;
                   });
                 }
                ),
              )
            ]
            ),
          ),
          Row(
            children: [
               LikeAnimation( 
                 isAnimating: widget.snap['likes'].contains(user.username),
                 smallikes: true,
                 child: IconButton(
                   onPressed: () async {
                     await FireStoreMethods().likePost(
                        widget.snap['postId'],
                        user.username,
                        widget.snap['likes']
                      );
                   },
                   icon: widget.snap['likes'].contains(user.username) ? const Icon(Icons.favorite,
                    color: Colors.red,
                   ) : const Icon(Icons.favorite_border)
                  ),
               ),
              IconButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CommentScreen(
                  snap123: widget.snap,
              ))
              ),
              icon: Icon(Icons.comment_outlined,
                color: Colors.white
              )
              ),
              IconButton(
              onPressed: () {},
              icon: Icon(Icons.send,
                color: Colors.white
               )
              ),
              Expanded(
              child: Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
              onPressed: () {}, 
              icon: Icon(Icons.bookmark_border)
              ),)
              )
            ],
          ),
          Container(
            width: double.infinity,
             padding: const EdgeInsets.symmetric(vertical: 8.0),
             child: Column(
               mainAxisSize: MainAxisSize.min,
               //mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 DefaultTextStyle(
                   style: Theme.of(context).textTheme.subtitle1!.copyWith(
                     fontWeight: FontWeight.w800
                   ),
                   child: Text('${widget.snap['likes'].length} likes',
                   style: Theme.of(context).textTheme.bodyText2
                   ),
                 ),
                 Container(
                 //  width: double.infinity,
                   padding: EdgeInsets.only(
                     top: 6.0
                   ),
                  child: RichText(
                    text: TextSpan(
                    style:  const TextStyle(color: primaryColor),
                    children: [
                      TextSpan(
                        text: widget.snap['username'],
                        style: TextStyle(fontWeight: FontWeight.bold)
                      ),
                      TextSpan(
                        text: "  ${widget.snap['description']}",
                        //style: TextStyle(fontWeight: FontWeight.bold)
                      )
                    ]
                  ))
                 ),
                 InkWell(
                   onTap: () {},
                   child: Container(
                    padding: EdgeInsets.symmetric(vertical: 6.0),
                    child: Text("View all ${commentsLength} comments",
                    style: TextStyle(
                    fontSize: 16.0, 
                    color: secondaryColor
                    ))
                   ),
                 ),
                 Container(
                   padding: const EdgeInsets.symmetric(vertical: 3),
                   child: Text(DateFormat.yMMMd().format(widget.snap['datePublished'].toDate()),
                   style: TextStyle(
                    fontSize: 14.0,
                    color: secondaryColor
                   ),
                  )
                 )
               ],
             )
          )
          ],
      ),
    );
  }
}