import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolar_chat/consttants.dart';
import 'package:schoolar_chat/widgets/chat_bubble_friend.dart';
import '../models/message_model.dart';
import '../widgets/custom_chatbubble.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  static String id = "chatpage";
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  TextEditingController message = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey();
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kPrimaryColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                kLogo,
                width: 60.w,
              ),
              const Text("Chat"),
            ],
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: messages.orderBy('createdat', descending: true).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<MessageModel> messageList = [];
                for (var i = 0; i < snapshot.data!.docs.length; i++) {
                  messageList
                      .add(MessageModel.fromjson(snapshot.data!.docs[i]));
                }
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        controller: _controller,
                        reverse: true,
                        // itemCount: snapshot.data!.size,
                        itemCount: messageList.length,
                        itemBuilder: (context, index) {
                          return messageList[index].id == email
                              ? ChatBubble(messagetext: messageList[index])
                              : FriendChatBubble(
                                  messagetext: messageList[index]);
                          // return ChatBubble(
                          //     messagetext:
                          //         "${snapshot.data!.docs[index]['message']}");
                        },
                      ),
                    ),
                    Form(
                      key: formstate,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "write your message";
                            }
                          },
                          controller: message,
                          decoration: InputDecoration(
                            hintText: "send message",
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: kPrimaryColor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () async {
                                if (formstate.currentState!.validate()) {
                                  messages.add({
                                    'message': message.text,
                                    'createdat': DateTime.now(),
                                    'id': email,
                                  });
                                  message.clear();
                                  _controller.animateTo(
                                    0,
                                    duration: Duration(seconds: 2),
                                    curve: Curves.fastOutSlowIn,
                                  );
                                }
                              },
                              icon: const Icon(
                                Icons.send,
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return const Text("loading");
              }
            }));
  }
}
