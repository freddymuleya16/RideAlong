import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ride_along/constants/colors.dart';
import 'package:ride_along/constants/is_dark.dart';
import 'package:ride_along/global-widgets/layout.dart';
import 'package:ride_along/screens/chat/chat_screen.dart';
import 'package:ride_along/screens/chat/widgets/message_list_item.dart';

import '../../models/user/user.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final chatQuery = FirebaseFirestore.instance.collection('chats');

  String? chatId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool _isDark = isDark(context);
    return Layout(children: [
      Expanded(
        child: StreamBuilder<List<Message>>(
          stream: getMessages(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  color: _isDark ? kTextColorLight : kBackgroundColorDark,
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(0),
              reverse: false,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final doc = snapshot.data![index];

                return MessageListItem(
                    userId: FirebaseAuth.instance.currentUser!.uid,
                    senderID: doc.senderID,
                    friend: doc.sender,
                    isDark: _isDark,
                    messageText: doc.text,
                    messageTimestamp: doc.timestamp);

                ListTile(
                  title: Text(doc.sender),
                  subtitle: Text(doc.text),
                  leading: CircleAvatar(),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => ChatScreen(
                              userUid: FirebaseAuth.instance.currentUser!.uid,
                              friendUid: doc.senderID))),
                );
              },
            );
          },
        ),
      ),
    ]);
  }

  Stream<List<Message>> getMessages() async* {
    CollectionReference messagesCollection = chatQuery;

    QuerySnapshot querySnapshot = await messagesCollection
        .where("users", arrayContains: FirebaseAuth.instance.currentUser!.uid)
        .get();

    List<Message> messages = [];

    for (var element in querySnapshot.docs) {
      var lastMessage = await chatQuery
          .doc(element.id)
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .limit(1)
          .get();

      lastMessage.docs[0]['message'];

      List<String> users = List<String>.from(element['users']);
      String friend = users.firstWhere(
        (element) => element != FirebaseAuth.instance.currentUser?.uid,
      );

      // print({lastMessage.docs[0]['message'], "GGGG"});
      var userFriend = await FirebaseFirestore.instance
          .collection('users')
          .doc(friend)
          .get();

      var model = AppUser.fromFirebase(
          Map<String, dynamic>.from(userFriend.data() as Map), userFriend.id);

      messages = [
        ...messages,
        (Message(
            senderID: friend,
            sender: '${model.firstname} ${model.lastname}',
            text: lastMessage.docs[0]['message'],
            timestamp: lastMessage.docs[0]['timestamp']))
      ];
    }

    print({messages, "GGGG1"});

    yield messages;
  }
}

class Message {
  String sender;
  String senderID;
  String text;
  Timestamp timestamp;

  Message({
    required this.sender,
    required this.senderID,
    required this.text,
    required this.timestamp,
  });
}
