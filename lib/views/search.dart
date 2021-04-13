import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sandbox/helper/constants.dart';
import 'package:sandbox/services/database.dart';
import 'package:sandbox/views/chatroom/conversation_screen.dart';

class SearchUser extends StatefulWidget {
  String get myName => null;

  @override
  _SearchUserState createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  String myName;
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchTextEdittingController = new TextEditingController();
  
  QuerySnapshot searchSnapshot;

   Widget searchList() {
    return searchSnapshot != null ?ListView.builder(shrinkWrap: true, itemCount: searchSnapshot.docs.length,
     itemBuilder: (context,index) {
      return searchTile(
        userName: searchSnapshot.docs[index].data()["name"],
        userEmail: searchSnapshot.docs[index].data()["email"]
        );
      })  : Container();

   }

    initiateSearch() {
      databaseMethods.getUserByUsername(searchTextEdittingController.text)
      .then((val){
        setState((){
         searchSnapshot = val;
        });
      });
    }

    createChatroomAndStartConversation({String username}) {
      if (username != Constants.myName) {
        String chatRoomId = getChatRoomId(username, Constants.myName);

        List<String> users = [username, Constants.myName];
        Map<String,dynamic> chatRoomMap = {
        "users" : users,
        "chatroomId" : chatRoomId
      };

      DatabaseMethods().createChatRoom(chatRoomId, chatRoomMap);
      Navigator.push(context, MaterialPageRoute(builder: (context) => ConversationScreen(
        chatRoomId
      )));
      }
    }

    Widget searchTile({String userName, String userEmail}) {
      return Container(
      padding: EdgeInsets.symmetric(horizontal:24, vertical: 16),
      child: Row(children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(userName),
          Text(userEmail),
        ],),
        Spacer(),
        GestureDetector(
               onTap: () {
                          createChatroomAndStartConversation(username: userName);
                        },
              child: Container(padding: EdgeInsets.symmetric(horizontal:24, vertical: 16), decoration: BoxDecoration(gradient: LinearGradient(colors: [
              const Color(0xFFFFF176),
              const Color(0xFFFFCC80)
            ]
            ),borderRadius: BorderRadius.circular(40)), child: Text("Message"),),
        )
      ],)
    );
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal:24, vertical:16), 
              color: Color(0xFFFFF176),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchTextEdittingController,
                      decoration: InputDecoration(
                        hintText: "Search Username...", 
                        hintStyle: TextStyle(color: Colors.black), 
                        border:InputBorder.none), 
                    ),),
                    GestureDetector(
                        child: Container(
                          height: 40, 
                          width: 40, 
                          padding: EdgeInsets.all(10), 
                          decoration: BoxDecoration(gradient: LinearGradient(colors: [
                            Colors.white, 
                            Colors.white10,
                      ]),
                      borderRadius: BorderRadius.circular(40)),
                      child: Image.asset("assets/send.png", height: 50, width: 50,),
                       ),
                          onTap:
                          initiateSearch(),),
                      
              ],
            ),
          )
            ,searchList()],)
      ),
    );
  }
}

class SearchTile extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return null;
  }
}
//esto hace que no existan dos chatrooms con el mismo ID, si nose entiende buscar video tutorial parte 3 en minuto 29
getChatRoomId(String username, String myname)
{
  if((username.compareTo(myname)>0)) {
    return "$myname\_$username";
  }
  else {
    return"$username\_$myname";
  }
}
