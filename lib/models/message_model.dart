class MessageModel {
  String message;
  String id;
  MessageModel(this.message, this.id);

  factory MessageModel.fromjson(jsonData) {
    return MessageModel(jsonData['message'], jsonData['id']);
  }
}
