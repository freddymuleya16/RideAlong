import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ride_along/constants/colors.dart';
import 'package:ride_along/constants/is_dark.dart';
import 'package:ride_along/global-widgets/layout.dart';
import 'package:ride_along/screens/chat/widgets/message_bubble.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  final String userUid;
  final String friendUid;

  ChatScreen({required this.userUid, required this.friendUid});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();
  final chatQuery = FirebaseFirestore.instance.collection('chats');

  String? chatId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    chatQuery
        .where("users", isEqualTo: [widget.friendUid, widget.userUid])
        .limit(1)
        .get()
        .then((value) {
          if (value.docs.isNotEmpty) {
            setState(() {
              chatId = value.docs.single.id;
            });
          } else {
            chatQuery
                .where("users", isEqualTo: [widget.userUid, widget.friendUid])
                .limit(1)
                .get()
                .then((value) {
                  if (value.docs.isNotEmpty) {
                    setState(() {
                      chatId = value.docs.single.id;
                    });
                  } else {
                    chatQuery.add({
                      'users': [widget.userUid, widget.friendUid]
                    }).then((value) {
                      setState(() {
                        chatId = value.id;
                      });
                    });
                  }
                });
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    bool _isDark = isDark(context);

    if (chatId == null) {
      return Center(
        child: CircularProgressIndicator(
          color: _isDark ? Colors.white : kSecondaryColor,
        ),
      );
    }
    return Layout(children: [
      Expanded(
        child: StreamBuilder<QuerySnapshot>(
          stream: chatQuery
              .doc(chatId)
              .collection('messages')
              .orderBy('timestamp', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  color: _isDark ? Colors.white : kSecondaryColor,
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(25),
              reverse: true,
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                final doc = snapshot.data?.docs[index];
                bool read = doc!['readRecipt'];
                if (doc['sender'] != widget.userUid &&
                    doc['readRecipt'] == false) {
                  chatQuery
                      .doc(chatId)
                      .collection('messages')
                      .doc(doc.id)
                      .update({"readRecipt": true});
                }
                Timestamp time = doc['timestamp'];
                String messageTime = formatDate(time.toDate());
                return MessageBubble(
                  time: messageTime,
                  message: doc['message'],
                  isMe: doc['sender'] == widget.userUid,
                  read: read,
                );
              },
            );
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade500),
              borderRadius: BorderRadius.circular(16)),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter message',
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send, color: Colors.grey.shade800),
                onPressed: () async {
                  await chatQuery.doc(chatId).collection('messages').add({
                    'message': _controller.text,
                    'users': {widget.userUid: null, widget.friendUid: null},
                    'sender': widget.userUid,
                    'reciever': widget.friendUid,
                    'readRecipt': false,
                    'userImage': 'https://via.placeholder.com/150',
                    'timestamp': Timestamp.now(),
                  });
                  _controller.clear();
                },
              ),
            ],
          ),
        ),
      ),
    ]);
  }

  String formatDate(DateTime date) {
    var now = DateTime.now();
    var today = DateTime(now.year, now.month, now.day);
    var yesterday = today.subtract(const Duration(days: 1));
    var format = DateFormat.Hm();
    print({DateTime(date.year, date.month, date.day), today});
    if (DateTime(date.year, date.month, date.day).compareTo(today) == 0) {
      return format.format(date);
    } else if (DateTime(date.year, date.month, date.day).compareTo(yesterday) ==
        0) {
      return "Yesterday";
    }
    return DateFormat('dd MMM yyy').format(date);
  }
}
