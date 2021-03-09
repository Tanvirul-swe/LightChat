import 'package:chatbox/chatScreen.dart';
import 'package:chatbox/constants.dart';
import 'package:chatbox/roundedButton.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'homeScreen.dart';
import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';
import 'package:toast/toast.dart';


class LoginScreen extends StatefulWidget {
  static const String id = 'LoginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;
 bool showspinner=false;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showspinner,
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
                    height: 30.0,
                  ),
                  TextField(
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    onChanged: (value){
                      email =value;

                    },
                    decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
                  ),
                   SizedBox(
                     height: 10.0,
                   ),
                  TextField(
                    obscureText: true,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    onChanged: (value){
                      password = value;

                    },
                    decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your password'),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                   RoundedButton(
                     title: 'Log In',colour: Colors.green,
                   onPressed: ()async{
                       setState(() {
                         showspinner=true;
                       });


                       try {

                         UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
                       }
                         on FirebaseAuthException catch (e) {

                         if (e.code == 'user-not-found') {
                           // print('No user found for that email.');
                           setState(() {
                             Toast.show("Wrong Email", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                             showspinner=false;
                           });
                         } else if (e.code == 'wrong-password') {
                           // print('Wrong password provided for that user.');
                           setState(() {

                            Toast.show("Wrong Password", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                             showspinner=false;
                           });
                         }

                       }
                        final user = await auth.signInWithEmailAndPassword(
                            email: email, password: password);

                       if(user!=null){
                              Navigator.pushNamed(context, ChatScreen.id);
                             Toast.show("Login Successful", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                       }

                        setState(() {
                          showspinner=false;
                        });

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
