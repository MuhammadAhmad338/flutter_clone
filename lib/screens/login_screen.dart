// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unused_field, annotate_overrides, sized_box_for_whitespace, avoid_unnecessary_containers
import 'package:flutter/material.dart';
import 'package:flutter_clone/res/mobile_screen_layout.dart';
import 'package:flutter_clone/res/responsive.dart';
import 'package:flutter_clone/res/web_screen_layout.dart';
import 'package:flutter_clone/resources/authentication.dart';
import 'package:flutter_clone/screens/signup_screen.dart';
import 'package:flutter_clone/screens/text_fieldinput.dart';
import 'package:flutter_clone/util/colors.dart';
import 'package:flutter_clone/util/extras.dart';
import 'package:flutter_svg/svg.dart';

class LogIn extends StatefulWidget {
  const LogIn({ Key? key }) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  final TextEditingController _textEditingController1 = TextEditingController();
  final TextEditingController _passwordEditingController1 = TextEditingController(); 
  bool _isloading = false;

  void dispose(){
    super.dispose();
    _textEditingController1.dispose();
    _passwordEditingController1.dispose();
  }

  void logIn() async {
    
    setState(() {
      _isloading = true;
    });
    
    String? res = await Authentication().loginScreen(
    email: _textEditingController1.text,
    password: _passwordEditingController1.text
    );

    if(res == 'success'){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Responsive(
              mobileScreenLayout: MobileScreen(),
              webScreenLayout: WebScreen()
      )));
    } 
    else{
        showSnackBar(res, context);
    }
     // ignore: unused_element 
  }
  void onTap() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SignUp()
));
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
             SvgPicture.asset('assets/ic_instagram.svg',
             color: primaryColor,
             height: 64
             ),
             const SizedBox(height: 64),
             TextFieldInput(
              textEditingController: _textEditingController1,
              hinttext: "Enter your Email",
              textInputType: TextInputType.emailAddress
             ),
             const SizedBox(height: 32),
             TextFieldInput(
              textEditingController: _passwordEditingController1,
              hinttext: "Enter your Password",
              textInputType: TextInputType.visiblePassword,
              isPass: true
              ),
              const SizedBox(height: 24),
              InkWell(
                onTap: logIn,
                child: Container(
                  child: _isloading  ? Center(
                    child: CircularProgressIndicator(
                      color: primaryColor
                    ),
                  ): const Text("LOGIN",
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
               Flexible(
                child: Container(),
                flex: 2
                ),
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