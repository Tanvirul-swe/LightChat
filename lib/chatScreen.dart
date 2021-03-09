import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'registrationScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toast/toast.dart';

final firestore = FirebaseFirestore.instance;
User loggedInUser;

class ChatScreen extends StatefulWidget {
  static const String id = 'ChatScreen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  String messageText;
  final messageTextControlar = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;


   @override
  void initState() {
    super.initState();
    getCurrentUser();
    getMessages();
  }

   void getCurrentUser(){
     try{
       final user =  auth.currentUser;
       if(user!=null){
         loggedInUser = user;
         print(loggedInUser.email);
       }
     }
     catch (t){
       print(t);
     }

  }

  void getMessages()async{
   await for(var snapshot in firestore.collection('messages').snapshots()){
        for(var messages in snapshot.docs)
          {
            print(messages.data());
          }

   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                auth.signOut();
                Navigator.pop(context);
                Toast.show('Logout Successful', context,duration:Toast.LENGTH_LONG, gravity:Toast.BOTTOM);
                // getMessages();
              }),
        ],
        title: Text('Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(),
            Container(
              decoration: KMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextControlar,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: KMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      messageTextControlar.clear();
                      firestore.collection('messages').add(
                        {
                         'text':messageText,
                         'sender':loggedInUser.email,
                        }
                      );
                    },
                    child: IconButton(
                     icon: Icon(Icons.send,
                     color: Colors.redAccent,
                       size: 30.0,
                     ),
                    ),
                    // child: Text(
                    //   'Send',
                    //   style: kSendButtonTextStyle,
                    // ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class MessageStyle extends StatelessWidget {
  MessageStyle({this.sender,this.text,this.isMe});

  final String sender;
  final String text;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start ,
        children: [
          Text(sender,
          style: TextStyle(
            fontSize: 15.0,
            color:Colors.black54,
          ),
          ),
          Material(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0),bottomRight: Radius.circular(25.0)),
            elevation: 10.0,
            color: isMe ? Colors.blueAccent : Colors.white,
            child: Padding(
              padding:  EdgeInsets.symmetric(vertical: 10.0,horizontal: 20),
              child: Text(
                    text,
                style: TextStyle(
                  color: isMe ? Colors.white:Colors.black54,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('messages').snapshots(),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }
          final messages = snapshot.data.docs;
          List<MessageStyle> messageWidgets = [];
          for(var message in messages){
            final messageText = message.data()['text'];
            final messageSender = message.data()['sender'];

            final currentUser = loggedInUser.email;
            if(currentUser==messageSender){
            }

            final messageWidget = MessageStyle(
              sender: messageSender,
              text: messageText,
              isMe: currentUser==messageSender,
            );
            messageWidgets.add(messageWidget);
          }

          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
              children: messageWidgets,
            ),
          );
        },
      );
  }
}


