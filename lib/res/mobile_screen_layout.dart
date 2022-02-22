// ignore_for_file: prefer_const_constructors, annotate_overrides
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clone/res/HomeUI.dart';
import 'package:flutter_clone/res/feed_screen.dart';
import 'package:flutter_clone/screens/profile_screen.dart';
import 'package:flutter_clone/screens/search_screen.dart';
import 'package:flutter_clone/util/colors.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({ Key? key }) : super(key: key);

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
   
  // ignore: unused_field
  int _page = 0;
  late PageController controller1;

  @override
  void initState(){
    super.initState();
    controller1 = PageController();
  }
  /*
  @override
  void dispose(){
    super.dispose();
    controller1.dispose();
  }*/

  // ignore: non_constant_identifier_names
  void Navigation(int page){
    controller1.jumpToPage(page);
  }

  void colorChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
  // User1 user1 = Provider.of<Provider1>(context).getUser;
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          FeedScreen(),
          SearchScreen(),
          HomeUI(),
          Text('NOTIFICATIONS'),
          ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid)
        ],
        controller: controller1,
        onPageChanged: colorChanged,
      ),
        bottomNavigationBar: CupertinoTabBar(
          // ignore: prefer_const_literals_to_create_immutables
          items: [
            BottomNavigationBarItem(
            icon: Icon(Icons.home,
            color: _page == 0 ? primaryColor : secondaryColor,
            ),
            backgroundColor: primaryColor,
            label: ""
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.search,
            color: _page == 1 ? primaryColor : secondaryColor,
            ),
            backgroundColor: primaryColor,
            label: ""
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.add_circle,
            color: _page == 2 ? primaryColor : secondaryColor,
            ),
            backgroundColor: primaryColor,
            label: ""
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.favorite,
            color: _page == 3 ? primaryColor : secondaryColor,
            ),
            backgroundColor: primaryColor,
            label: ""
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.person,
            color: _page == 4 ? primaryColor : secondaryColor
            ),
            backgroundColor: primaryColor,
            label: ""
            )
          ],
          onTap: Navigation,
        )
    );
  }
}