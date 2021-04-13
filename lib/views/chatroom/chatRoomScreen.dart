import 'package:flutter/material.dart';
import 'package:sandbox/helper/constants.dart';
import 'package:sandbox/helper/shared_preferences_functions.dart';
import 'package:sandbox/services/authMethods.dart';
import 'package:sandbox/services/database.dart';
import 'package:sandbox/views/chatroom/conversation_screen.dart';
import 'package:sandbox/views/search.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Stream chatRoomStream;

  Widget chatRoomList() {
   return StreamBuilder(
     builder: (context,snapshot){
       return snapshot.hasData ? ListView.builder (
         itemCount: snapshot.data.docs.length,
         itemBuilder: (context, index) {
           return ChatRoomsTile(
            snapshot.data.docs[index].data()["chatroomId"]
           .toString().replaceAll("_", "")
           .replaceAll(Constants.myName, ""),
           snapshot.data.docs[index].data()["chatroomId"]
           );
         },) : Container();
     },
     stream: chatRoomStream
   );
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    Constants.myName = await SharedPreferencesFunctions.getUserNameSharedPreference();

    databaseMethods.getChatRooms(Constants.myName)
    .then((value){
      setState(() {
        chatRoomStream = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: chatRoomList(),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.search), 
        onPressed:() {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SearchUser()));
        },) 
      
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;
  ChatRoomsTile(this.userName, this.chatRoomId);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Constants.isChatOpened = true;
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ConversationScreen(chatRoomId)
        ));
      },
      child: Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF176),
              borderRadius: BorderRadius.circular(40)
              ),
            child: Text("${userName.substring(0,1).toUpperCase()}"),
          ),
          SizedBox(width: 8,),
          Text (userName),
        ],)
    )
    );
  }
}