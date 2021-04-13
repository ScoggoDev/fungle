import 'package:flutter/material.dart';
import 'package:sandbox/helper/constants.dart';
import 'package:sandbox/services/database.dart';
import 'package:sandbox/views/tab_layout.dart';

// ignore: must_be_immutable
class ConversationScreen extends StatefulWidget {
  final String chatRoomId;
  ConversationScreen(this.chatRoomId);

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController messageController = new TextEditingController();

  Stream chatMessagesStream;

  // ignore: non_constant_identifier_names
  Widget ChatMessageList() {
    return StreamBuilder(
      stream: chatMessagesStream,
      builder: (context,snapshot) {
        return snapshot.hasData ? ListView.builder(
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            return MessageTile(snapshot.data.docs[index].data()["message"],
            snapshot.data.docs[index].data()["sentBy"] == Constants.myName);
          },
          ) : Container();
      }
    );
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String,dynamic> messageMap = {
        "message" : messageController.text,
        "sentBy" : Constants.myName,
        "time" : DateTime.now().millisecondsSinceEpoch
      };
      databaseMethods.addConversationMessages(widget.chatRoomId, messageMap);
      messageController.text = "";
    }

  }

  @override
  void initState() {
    Constants.openedOnce = true;
    databaseMethods.getConversationMessages(widget.chatRoomId).then((value){
      setState(() {
        chatMessagesStream = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return 
      Scaffold(
      appBar: AppBar(
            title:
            Text('Fungle', style: TextStyle(color: Colors.black, fontFamily: 'Montserrat'),),
            leading: 
              GestureDetector(
              child: Icon(Icons.arrow_back_rounded, color: Colors.black,),
              onTap: () {
                Constants.isChatOpened = false;
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainLayout()));
                },
              ),
            backgroundColor: Colors.white,
          ),
      body: Container(
        child: Stack(
        children: [
              ChatMessageList(),
              Container(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                  padding: EdgeInsets.symmetric(horizontal:24, vertical:16), 
                  color: Color(0xFFFFF176),
                  child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        decoration: InputDecoration(
                          hintText: "Send message", 
                          hintStyle: TextStyle(color: Colors.black), 
                          border:InputBorder.none), 
                      ),),
                      GestureDetector(
                          onTap: (){
                            print(Constants.myName);
                            sendMessage();
                          },
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
                            ),
                    ],
                  ),
                 ),
              ),  
              ]
            ),
          ),
       );
    }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSentByMe;

  MessageTile(this.message, this.isSentByMe);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.only(left: isSentByMe ? 0 : 24, right: isSentByMe ? 24 : 0),
      width: MediaQuery.of(context).size.width,
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(gradient: LinearGradient(
        colors: isSentByMe ? [
          const Color(0xFFFFF176),
          const Color(0xFFFFCC80)
          ] : [
          Colors.white,
          Colors.white10
          ]
         ),
        borderRadius: isSentByMe ?
          BorderRadius.only(
            topLeft: Radius.circular(23),
            topRight: Radius.circular(23),
            bottomLeft: Radius.circular(23)
          )
          :
          BorderRadius.only(
            topLeft: Radius.circular(23),
            topRight: Radius.circular(23),
            bottomRight: Radius.circular(23)
          )
        ),
      child: Text(message, style: TextStyle(fontSize:17 )),
      ),
    );
  }
}