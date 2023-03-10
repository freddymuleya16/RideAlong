import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final bool read;
  final String time;

  const MessageBubble(
      {super.key,
      required this.message,
      required this.isMe,
      required this.read,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: !isMe
              ? const EdgeInsets.fromLTRB(0, 0, 50, 0)
              : const EdgeInsets.fromLTRB(50, 0, 0, 0),
          child: Material(
            borderRadius: isMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0))
                : const BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
            elevation: 5.0,
            color: !isMe ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Wrap(
                  alignment: WrapAlignment.end,
                  crossAxisAlignment: WrapCrossAlignment.end,
                  children: [
                    Text(
                      message,
                      style: TextStyle(
                        color: !isMe ? Colors.white : Colors.black54,
                        fontSize: 15.0,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      time,
                      style: TextStyle(
                        color: !isMe ? Colors.white : Colors.black54,
                        fontSize: 9.0,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    isMe
                        ? read
                            ? SizedBox(
                                height: 15,
                                child: Icon(
                                  FontAwesomeIcons.checkDouble,
                                  color: Colors.blue.withOpacity(0.40),
                                  size: 10,
                                ),
                              )
                            : SizedBox(
                                height: 15,
                                child: Icon(
                                  FontAwesomeIcons.check,
                                  color: Colors.grey.withOpacity(0.40),
                                  size: 10,
                                ),
                              )
                        : const SizedBox(),
                  ]),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        )
      ],
    );
  }
}
