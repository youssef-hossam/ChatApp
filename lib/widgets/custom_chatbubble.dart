import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolar_chat/models/message_model.dart';

import '../consttants.dart';

class ChatBubble extends StatelessWidget {
  MessageModel messagetext;
  ChatBubble({super.key, required this.messagetext});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 32, bottom: 16, top: 16),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
                topRight: Radius.circular(15))),
        child: Text(
          messagetext.message,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
