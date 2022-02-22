// ignore: file_names
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_element, file_names, duplicate_ignore, unused_local_variable, empty_catches
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_clone/FirebaseMethods/firestoremethods.dart';
import 'package:flutter_clone/models/user.dart';
import 'package:flutter_clone/provider/provider.dart';
import 'package:flutter_clone/resources/image.dart';
import 'package:flutter_clone/util/colors.dart';
import 'package:flutter_clone/util/extras.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class HomeUI extends StatefulWidget {
  const HomeUI({Key? key}) : super(key: key);

  @override
  _HomeUIState createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  // ignore: unused_field
  Uint8List? _file;
  final TextEditingController _descriptionController = TextEditingController();
  bool _isLoading = false;
  

  void postIt(String uid, String username, String profImage) async {
    
    setState(() {
      _isLoading = true;
    });
    String res = "Some error Occured!";
    try {
      String res = await FireStoreMethods().postImage(_descriptionController.text, _file!, username, uid, profImage);
      if(res == 'success'){
        setState(() {
          _isLoading = false;
        });
        showSnackBar('Posted!', context);
        backToScreen();
      }
      else{
        setState(() {
          _isLoading = false;
        });
        showSnackBar(res, context);
      }
    } 
    catch (err) {
      setState(() {
        _isLoading = false;
      });
        showSnackBar(err.toString(), context);
    }
  }
   
  
  _showDialog(BuildContext context) async {
    // ignore: prefer_equal_for_default_values
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text("Create a Post"),
             children: [
            SimpleDialogOption(
              padding: EdgeInsets.all(20),
              child: const Text('Choose from Gallery'),
              onPressed: () async {
                Navigator.of(context).pop();
                // ignore: unused_local_variable
                Uint8List file = await pickImage(ImageSource.gallery);
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: EdgeInsets.all(20),
              child: const Text('Choose from Camera'),
              onPressed: () async {
                Navigator.of(context).pop();
                // ignore: unused_local_variable
                Uint8List file = await pickImage(ImageSource.camera);
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: EdgeInsets.all(20),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
                // ignore: unused_local_variable
              },
            )
          ]);
        });
  }
  
  
  void backToScreen() {
    setState(() {
      _file == null;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final User1 user123 = Provider.of<Provider1>(context).getUser;

    return _file == null
        ? Center(
            child: IconButton(
            icon: const Icon(Icons.upload),
            onPressed: () => _showDialog(context),
          ))
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              leading:
                  IconButton(
                   icon: Icon(Icons.arrow_back),
                   onPressed: () => backToScreen,
                   ),
              title: const Text("Post to"),
              centerTitle: false,
              // ignore: prefer_const_literals_to_create_immutables
              actions: [
                TextButton(
                    onPressed: () => postIt(user123.email, user123.username, user123.photoUrl),
                    child: const Text(
                      'Post',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                          fontSize: 17),
                    ))
              ],
            ),
            body: Column(children: [ 
              _isLoading ? const LinearProgressIndicator() : Container(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(user123.photoUrl),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                          hintText: "Add the Caption...",
                          border: InputBorder.none),
                      maxLines: 8,
                    ),
                  ),
                  SizedBox(
                    height: 45,
                    width: 45,
                    child: AspectRatio(
                      aspectRatio: 2 / 3,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: MemoryImage(_file!),
                              fit: BoxFit.fill,
                              alignment: FractionalOffset.topCenter),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const Divider()
            ]),
          );
  }
}
