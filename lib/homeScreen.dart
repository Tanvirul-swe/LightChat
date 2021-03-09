import 'package:chatbox/loginScreen.dart';
import 'package:chatbox/registrationScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'loginScreen.dart';
import 'roundedButton.dart';

class HomeScreen extends StatefulWidget {

  static const String id = 'HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{
  AnimationController animationController;
  Animation animation;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    animationController = AnimationController(duration: Duration(seconds: 3), vsync: this,);
    animation = ColorTween(begin: Colors.lightBlueAccent,end: Colors.white).animate(animationController);

    animationController.forward();
    animationController.addListener(() { 
      setState(() {
      });
    });
    
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
                Row(
                  children: [
                    Hero(
                      tag: 'logo',
                      child: Container(
                        child: Image.asset('images/charging.png'),
                        height: 60.0,
                      ),
                    ),
                   TyperAnimatedTextKit(
                       text:[' Light Chat'],
                        speed: Duration(milliseconds: 200),
                       textStyle: TextStyle(
                         fontSize: 45.0,
                         fontWeight: FontWeight.w900,
                         color: Colors.green,
                       ),
                   ),
                  ],
                ),
              SizedBox(
                height: 40.0,
              ),
               RoundedButton(title: 'Log In',colour: Colors.green,
               onPressed:(){
                 Navigator.pushNamed(context, LoginScreen.id);
               },
               ),
              RoundedButton(title: 'Register',colour: Colors.grey,
                onPressed:(){
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
              ),
            ],
          ),
        ),
    );
  }
}
