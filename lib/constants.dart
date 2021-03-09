import 'package:flutter/material.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);
const KMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
  hintText: 'Type your message here',
  border: InputBorder.none,
);
const KMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent,width: 2.0),
  ),
);

const kTextFieldDecoration = InputDecoration(
    hintStyle: TextStyle(
      color: Colors.lightBlueAccent,
    ),
    hintText: '',
    contentPadding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(40.0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.lightBlueAccent,width: 3.0),
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
    ),
  );
