// ignore_for_file: prefer_typing_uninitialized_variables

class MessageModel {
  String message;
  var id;
  MessageModel(this.message, this.id);

  factory MessageModel.fromjson(jsonData) {
    return MessageModel(jsonData['message'], jsonData['id']);
  }
}
