import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  static getUserByUsername(String username) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .where("name", isEqualTo: username)
        .get();
  }

  static void uploadUserInfo(userInfo) {
    FirebaseFirestore.instance
        .collection('users')
        .add(userInfo)
        .catchError((e) {
      print("Exception: ${e.toString()}");
    });
  }

  // ignore: missing_return
  static Future<bool> addChatRoom(chatRoom, chatRoomId)  {
    FirebaseFirestore.instance
        .collection("chat_room")
        .doc(chatRoomId)
        .set(chatRoom)
        .catchError((e) {
      print(e);
    });
  }

  static getChats(String chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }

  static Future<void> addMessage(String chatRoomId, chatMessageData) {
    FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(chatMessageData)
        .catchError((e) {
      print(e.toString());
    });
  }

  static getUserChats(String itIsMyName) async {
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .where('users', arrayContains: itIsMyName)
        .snapshots();
  }
}
