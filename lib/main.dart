import 'package:chatbox/chatScreen.dart';
import 'package:chatbox/loginScreen.dart';
import 'package:chatbox/registrationScreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'homeScreen.dart';
import 'package:firebase_core/firebase_core.dart';

void main()async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id:(context) => HomeScreen(),
        LoginScreen.id:(context) => LoginScreen(),
        RegistrationScreen.id:(context) => RegistrationScreen(),
        ChatScreen.id:(context) => ChatScreen(),
      },
    );
  }
}

