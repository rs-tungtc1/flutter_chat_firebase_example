import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  static getUserByEmail(String email) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .where("email", isEqualTo: email)
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

  static searchByName(String searchField) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where('name', isEqualTo: searchField)
        .get();
  }

  static Future<bool> addChatRoom(chatRoom, chatRoomId) {
    FirebaseFirestore.instance
        .collection("chat_room")
        .doc(chatRoomId)
        .set(chatRoom)
        .catchError((e) {
      print('Exception123: ${e.toString()}');
    });
  }

  static getChats(String chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chat_room")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }

  static Future<void> addMessage(String chatRoomId, chatMessageData) {
    FirebaseFirestore.instance
        .collection("chat_room")
        .doc(chatRoomId)
        .collection("chats")
        .add(chatMessageData)
        .catchError((e) {
      print(e.toString());
    });
  }

  static getUserChats(String itIsMyName) async {
    print('data123: ${FirebaseFirestore.instance
        .collection("chat_room")
        .where('users', arrayContains: itIsMyName)
        .snapshots()}');
    return FirebaseFirestore.instance
        .collection("chat_room")
        .where('users', arrayContains: itIsMyName)
        .snapshots();
  }
}
