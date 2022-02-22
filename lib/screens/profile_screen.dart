// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, await_only_futures, unused_local_variable, prefer_typing_uninitialized_variables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clone/Buttons/editbuttons.dart';
import 'package:flutter_clone/resources/authentication.dart';
import 'package:flutter_clone/util/colors.dart';
import 'package:flutter_clone/util/extras.dart';


class ProfileScreen extends StatefulWidget {
  
  final  uid;
  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
 
  var userData = {};
  int postData = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;
  

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() async {
    setState(() {
      isLoading = true;
    });
   try{
      var userSnap = await FirebaseFirestore.instance.collection('users').doc(widget.uid).get();

      //Get posts length
      var post = await FirebaseFirestore.instance.collection('posts').where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
      
      postData = post.docs.length;
      userData = userSnap.data()!;
      followers = userSnap.data()!['followers'].length;
      following = userSnap.data()!['following'].length;
      isFollowing = userSnap.data()!['followers'].contains(FirebaseAuth.instance.currentUser!.uid);

      setState(() {});
   }
   catch(error){
      showSnackBar( error.toString(), context);
   }
   setState(() {
     isLoading = false;
   });
  }

  @override
  Widget build(BuildContext context) {
    
    return isLoading ? Center(child: CircularProgressIndicator()) : Scaffold(
      appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          centerTitle: false,
          title: Text(userData['username']),
          actions: [
            IconButton(
             onPressed: () => Authentication().signOut(),
             icon: Icon(Icons.more_vert)
            ),
            IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0))),
                      content: Text(
                        'Ahmad',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      )));
                },
                icon: Icon(Icons.arrow_drop_down))
          ]),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [ CircleAvatar(
                    radius: 48,
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(
                        userData['photos']),
                  ),              
                Expanded(
                  child: Column(
                    children: [
                    Row(
                      //  mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                      addComment(postData, 'posts'),
                      addComment(followers, 'followers'),
                      addComment(following, 'following')                  
                      ]
                    ),
                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                       FirebaseAuth.instance.currentUser!.uid  == widget.uid ? EditButton(
                       function: () { },
                       backgroundColor: mobileBackgroundColor,
                       borderColor: Colors.grey,
                       text: 'Edit Profile',
                       textColor: primaryColor
                       ) : isFollowing ? EditButton(
                        backgroundColor: Colors.white,
                        borderColor: Colors.grey,
                        text: "Unfollow",
                        textColor: Colors.black,
                        function: () {},
                        ) : EditButton(backgroundColor: Colors.blue,
                        borderColor: Colors.grey,
                        text:  "Follow",
                        textColor: Colors.white,
                        function: () {},
                      )  
                    ],
                    )
                    ]
                  )               
                ),              
                ]
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(userData['username'],
                  style: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 22),
                  )
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 4.0),
                  child: Text(userData['bio'],
                  style: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 14),
                  )
                ),
              ],

            ),
          ),
          const Divider(),

          
          FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('posts')
                        .where('uid', isEqualTo: widget.uid)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return GridView.builder(
                          shrinkWrap: true,
                          itemCount: (snapshot.data! as dynamic).docs.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 1.5,
                                  childAspectRatio: 1),
                          itemBuilder: (context, index) {
                            DocumentSnapshot snap =
                                (snapshot.data! as dynamic).docs[index];
                            return Container(
                                child: Image(
                              image: NetworkImage(
                                snap['postUrl'],
                              ),
                              fit: BoxFit.cover,
                            ));
                          });
                    })
        ],
      ),
    );
}

Column addComment(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(num.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Container(
          margin: EdgeInsets.only(top: 5.0),
          child: Text(label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        ),
      ],
    );
  }
}
