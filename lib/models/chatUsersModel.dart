

class ChatUsers {
  String name;
  String messageText;
  String imageURL;
  String time;
  String email;
  bool isRead;

  ChatUsers(
      {required this.name,
      required this.messageText,
      required this.imageURL,
      required this.isRead,
      required this.email,
      required this.time});
}