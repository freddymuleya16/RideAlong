import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants/colors.dart';
import '../chat_screen.dart';
import 'package:intl/intl.dart' show DateFormat;

class MessageListItem extends StatelessWidget {
  final String userId;

  final String senderID;

  final String friend;

  final bool isDark;

  final String messageText;

  final Timestamp messageTimestamp;

  const MessageListItem(
      {super.key,
      required this.userId,
      required this.senderID,
      required this.friend,
      required this.isDark,
      required this.messageText,
      required this.messageTimestamp});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (builder) =>
                    ChatScreen(userUid: userId, friendUid: senderID))),
        child: SizedBox(
          //decoration: BoxDecoration(color: Colors.white),
          height: 60,
          child: Container(
            //color: Colors.red.shade400,
            padding: const EdgeInsets.symmetric(vertical: 0),
            child: Column(
              children: <Widget>[
                Divider(
                  height: 0.2,
                  indent: 90,
                  thickness: 0.2,
                  color: !isDark
                      ? kDarkBackgroundColor.withOpacity(0.75)
                      : Colors.white.withOpacity(0.75),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/default_profile.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  friend,
                                  style: GoogleFonts.ubuntu(
                                      color: isDark
                                          ? Colors.white
                                          : kSecondaryColor,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 15),
                                ),
                              ),
                              const SizedBox(
                                height: 0,
                              ),
                              Expanded(
                                  child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      messageText,
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.ubuntu(
                                          color: isDark
                                              ? Colors.white
                                              : kSecondaryColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12),
                                    ),
                                  ),
                                  Text(
                                    formatDate(messageTimestamp.toDate()),
                                    textAlign: TextAlign.end,
                                    style: GoogleFonts.ubuntu(
                                        color: isDark
                                            ? Colors.white
                                            : kSecondaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12),
                                  ),
                                ],
                              )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(
                  indent: 90,
                  height: 0.2,
                  thickness: 0.2,
                  color: !isDark
                      ? kDarkBackgroundColor.withOpacity(0.75)
                      : Colors.white.withOpacity(0.75),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String formatDate(DateTime d) {
    var date = DateTime(d.year, d.month, d.day);
    var now = DateTime.now();
    var today = DateTime(now.year, now.month, now.day);
    var yesterday = today.subtract(const Duration(days: 1));
    var format = DateFormat.Hm();
    if (date.compareTo(today) == 0) {
      return "${format.format(d)}";
    } else if (date.compareTo(yesterday) == 0) {
      return "Yesterday";
    }
    return DateFormat('dd MMM yyy').format(date);
  }
}
