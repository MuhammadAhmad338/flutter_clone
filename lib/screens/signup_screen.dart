// ignore_for_file: prefer_const_constructors, annotate_overrides, unused_field, prefer_const_literals_to_create_immutables, avoid_print, await_only_futures, unused_local_variable, prefer_final_fields
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_clone/res/mobile_screen_layout.dart';
import 'package:flutter_clone/res/responsive.dart';
import 'package:flutter_clone/res/web_screen_layout.dart';
import 'package:flutter_clone/resources/authentication.dart';
import 'package:flutter_clone/resources/image.dart';
import 'package:flutter_clone/screens/home_screen.dart';
import 'package:flutter_clone/screens/login_screen.dart';
import 'package:flutter_clone/screens/text_fieldinput.dart';
import 'package:flutter_clone/util/colors.dart';
import 'package:flutter_clone/util/extras.dart';
import 'package:image_picker/image_picker.dart';

class  SignUp extends StatefulWidget {
  const SignUp({ Key? key }) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final TextEditingController _emailEditingController1 = TextEditingController();
  final TextEditingController _passwordEditingController1 = TextEditingController(); 
  final TextEditingController _bioController1 = TextEditingController();
  final TextEditingController _usernameController1 = TextEditingController(); 
  Uint8List? _image;
  bool _isLoading = false; 

  void dispose() {
    super.dispose();
    _emailEditingController1.dispose();
    _passwordEditingController1.dispose();
    _bioController1.dispose();
    _usernameController1.dispose();
  }

  void selectImage() async {

  Uint8List image = await pickImage(ImageSource.gallery);
  setState(() {
    _image = image;
  });

  }
  
  void selected() async {   
    setState(() {
      _isLoading = true;
    });

    String? res = await Authentication().signUp(
      email: _emailEditingController1.text,
      password: _passwordEditingController1.text,
      username: _usernameController1.text,
      bio: _bioController1.text,
      file: _image!,
    );
    if(res != "success"){
      showSnackBar(res, context);
    }

    if(res == "success"){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const  Responsive(
              mobileScreenLayout: MobileScreen(),
              webScreenLayout: WebScreen()
      )));
    }
    else{
      showSnackBar(res, context);
    }
}

void onTap(){
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LogIn()));
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget> [
             Flexible(
             child: Container(),
             flex: 2
             ),
             Image.asset('assets/Coca-Cola_logo.svg.png',
             color: primaryColor,
             height: 64
             ),
             const SizedBox(height: 24),
             Stack(
              children:  [
             _image != null ? CircleAvatar(
               radius: 52,
               backgroundImage: MemoryImage(_image!),
             )
             : CircleAvatar(
                   radius: 52,
                   backgroundImage: NetworkImage(
                      'https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg'
                   )                 
                 ),  
                 Positioned(
                   bottom: -8,
                   left: 70,
                   child: IconButton(
                     icon: Icon(Icons.add),
                     onPressed: selectImage,  
                     ),
                 )
               ]              
             ),
              const SizedBox(height: 24),
             TextFieldInput(
              textEditingController: _emailEditingController1,
              hinttext: "Enter your Email",
              textInputType: TextInputType.emailAddress
             ),
             const SizedBox(height: 24),
             TextFieldInput(
              textEditingController: _passwordEditingController1,
              hinttext: "Enter your Password",
              textInputType: TextInputType.visiblePassword,
              isPass: true
              ),
              const SizedBox(height: 24),
              TextFieldInput(
                textEditingController: _bioController1,
                hinttext: "Enter your bio",
                textInputType: TextInputType.visiblePassword,
                isPass: true
                ),
                const SizedBox(height: 24),
                TextFieldInput(
                textEditingController: _usernameController1,
                hinttext: "Enter your username",
                textInputType: TextInputType.visiblePassword,
                isPass: true
                ),
                const SizedBox(height: 24),
                InkWell(
                  onTap: selected,                   
                  child: Container(
                    child: _isLoading ? HomeScreen() : const Text("LOGUP",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    )
                    ),
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    alignment: Alignment.center,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4)
                        )
                      ),
                      color: blueColor
                    )         
                  ),
                ),
               const SizedBox(height: 24),
               Flexible(child: Container(), flex: 3),  
                  Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: <Widget>[
                    Container(
                     child: Text("Don't have an account?"),
                     padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    GestureDetector(
                      onTap: onTap,
                      child: Container(
                        child: Text("SignUp",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    )
                   ]
                 ),
                          
           ],
          ),
        ),
      )
    ); 
  }
}