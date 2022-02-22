// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommentCard extends StatefulWidget {

  final snap;
  const CommentCard({ Key? key, required this.snap}) : super(key: key);

  @override
  _CommentCardState createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
      child: Row(   
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage('https://images.unsplash.com/photo-1640622299485-7fef00b3dc24?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxNnx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60'),
            radius: 18,
          ),
          Expanded(
            child: Padding(padding: EdgeInsets.only(left: 16.0),
            child: Column(        
              children: [
                RichText(text: TextSpan(
                  children: [
                    TextSpan(
                      text: widget.snap['username'],
                      style: const TextStyle(fontWeight: FontWeight.bold)
                    ),
                    TextSpan(
                      text: widget.snap['comments'])
                  ]
                ),
                ),
                 Padding(padding: EdgeInsets.only(top: 4),
              child: Text((DateFormat.yMMMd().format(widget.snap['datePublished'].toDate())),
              style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold)),
            ),
              ],        
            ) 
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            child: const Icon(Icons.favorite,
            size: 17),
          )
        ],
      ),
      
    );
  }
}