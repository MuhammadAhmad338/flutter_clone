// ignore_for_file: prefer_const_constructors, avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clone/screens/profile_screen.dart';
import 'package:flutter_clone/util/colors.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({ Key? key }) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  final TextEditingController _searchController = TextEditingController();
  bool isSearchFilled = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: TextFormField(
          controller: _searchController,
          decoration: InputDecoration(
            labelText: 'Search here'
          ),
          onFieldSubmitted: (_){
            setState(() {
              isSearchFilled = true;
            });
           // print(_controller007.text);
          },
        ),
      ),
      body: isSearchFilled ? FutureBuilder(
        future: FirebaseFirestore.instance.collection('users')
        .where('username', isGreaterThanOrEqualTo: _searchController.text)
        .get(),
        builder: (context,  snapshot) {
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
              );
          }
          return ListView.builder(
            itemCount: (snapshot.data! as dynamic).docs.length,
            itemBuilder: (context, index){
              return InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileScreen(uid: (snapshot.data! as dynamic).docs[index]['email']))),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      (snapshot.data! as dynamic).docs[index]['photos']          
                    ),
                  ),
                  title: Text((snapshot.data! as dynamic).docs[index]['username']),
                ),
              );
            }
            );
        }) : FutureBuilder(
              future: FirebaseFirestore.instance.collection('posts').get(),
              builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot){
              if(!snapshot.hasData){
                return Center(
                  child: CircularProgressIndicator()
                );  
              }
              return StaggeredGridView.countBuilder(
               crossAxisCount: 3,
               itemCount: snapshot.data!.docs.length,
               itemBuilder: (context, index) => Image.network(
                  snapshot.data!.docs[index]['postUrl']
               ), 
               staggeredTileBuilder: (index) => StaggeredTile.count(
                 (index % 7 == 0) ? 2 : 1,
                 (index % 7 == 0) ? 2 : 1
                ),
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 5.0,             
              );     
              }         
              ),
    );
  }
}