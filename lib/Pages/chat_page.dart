import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolar_chat/consttants.dart';
import 'package:schoolar_chat/cubits/chat/chat_cubit.dart';
import 'package:schoolar_chat/widgets/chat_bubble_friend.dart';
import '../models/message_model.dart';
import '../widgets/custom_chatbubble.dart';

class ChatPage extends StatefulWidget {
  ChatPage({super.key});
  static String id = "chatpage";

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  TextEditingController message = TextEditingController();

  GlobalKey<FormState> formstate = GlobalKey();

  final ScrollController _controller = ScrollController();

  List<MessageModel> messageList = [];
  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<ChatCubit>(context).getsMessage();
  }

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
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
          actions: [
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                icon: Icon(Icons.logout))
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocConsumer<ChatCubit, ChatState>(
                listener: (context, state) {
                  if (state is ChatSuccess) {
                    messageList = state.messagesList;
                  }
                },
                builder: (context, state) {
                  return ListView.builder(
                    controller: _controller,
                    reverse: true,
                    // itemCount: snapshot.data!.size,
                    itemCount: messageList.length,
                    itemBuilder: (context, index) {
                      return messageList[index].id == email
                          ? ChatBubble(messagetext: messageList[index])
                          : FriendChatBubble(
                              messagetext: messageList[index],
                            );
                      // return ChatBubble(
                      //     messagetext:
                      //         "${snapshot.data!.docs[index]['message']}");
                    },
                  );
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
                      borderSide: const BorderSide(color: kPrimaryColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () async {
                        if (formstate.currentState!.validate()) {
                          // messages.add({
                          //   'message': message.text,
                          //   'createdat': DateTime.now(),
                          //   'id': email,
                          // });
                          BlocProvider.of<ChatCubit>(context).sendMessage(
                              message: message.text, email: email.toString());
                          message.clear();
                          _controller.animateTo(
                            0,
                            duration: const Duration(seconds: 2),
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
        ));
  }
}
