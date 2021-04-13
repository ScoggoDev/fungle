import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUserByUsername(String username) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .get();
  }

  getUserByUserEmail(String userEmail) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: userEmail)
        .get();
  }

  uploadUserInfo(userMap) {
    FirebaseFirestore.instance.collection("users").add(userMap);
  }

  createChatRoom(String chatRoomId, chatRoomMap) {
    FirebaseFirestore.instance
        .collection("ChatRooms")
        .doc(chatRoomId)
        .set(chatRoomMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  addConversationMessages(String chatRoomId, messageMap) {
    FirebaseFirestore.instance
        .collection("ChatRooms")
        .doc(chatRoomId)
        .collection("Chats")
        .add(messageMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  getConversationMessages(String chatRoomId) async {
    // ignore: await_only_futures
    return await FirebaseFirestore.instance
        .collection("ChatRooms")
        .doc(chatRoomId)
        .collection("Chats")
        .orderBy("time", descending: false)
        .snapshots();
  }

  getChatRooms(String userName) async {
    // ignore: await_only_futures
    return await FirebaseFirestore.instance
        .collection("ChatRooms")
        .where("users", arrayContains: userName)
        .snapshots();
  }

  getQuestions() async {
    return await FirebaseFirestore.instance
        .collection("questionsandanswers")
        .doc("questions")
        .get();
  }
}
