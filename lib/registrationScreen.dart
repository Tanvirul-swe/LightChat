import 'package:chatbox/chatScreen.dart';
import 'package:chatbox/constants.dart';
import 'package:flutter/material.dart';
import 'roundedButton.dart';
import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';


class RegistrationScreen extends StatefulWidget {
  static const String id = 'RegistrationScreen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool showspinner = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showspinner,
        color: Colors.pink,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/charging.png'),
                  ),
                ),
                SizedBox(
                  height: 45.0,
                ),
                TextField(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  onChanged: (value){
                     email = value;
                  },
                  decoration:kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextField(
                  obscureText: true,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  onChanged: (value){
                      password =value;
                  },
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your password'),
                ),

               RoundedButton(title: 'Register',colour: Colors.grey,
                  onPressed: () async {
                 setState(() {
                   showspinner = true;
                 });
                 try{
                   final newUser= await _auth.createUserWithEmailAndPassword(email: email, password: password);
                       if(newUser!=null){
                         Toast.show("Registration Successful", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                         Navigator.pushNamed(context, ChatScreen.id);
                       }
                       setState(() {
                         showspinner=false;
                       });
                   }
                  catch (t){
                   print(t);
                  }
                  },
               ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
