import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:schoolar_chat/models/message_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  sendMessage({required String message, required String email}) async {
    messages.add({
      'message': message,
      'createdat': DateTime.now(),
      'id': email,
    });
  }

  getsMessage() {
    messages.orderBy('createdat', descending: true).snapshots().listen((event) {
      List<MessageModel> messages = [];
      for (var doc in event.docs) {
        messages.add(MessageModel.fromjson(doc));
      }
      emit(ChatSuccess(messagesList: messages));
    });
  }
}
