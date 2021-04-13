import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sandbox/helper/authenticate.dart';
import 'package:sandbox/helper/constants.dart';
import 'package:sandbox/views/profile.dart';
import 'package:sandbox/views/main_hub.dart';
import 'package:sandbox/services/authMethods.dart';
import 'package:sandbox/views/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'chatroom/chatRoomScreen.dart';


// ignore: must_be_immutable
class MainLayout extends StatelessWidget {
  
  AuthMethods authMethods = new AuthMethods();
 @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child:
        MaterialApp(
          debugShowCheckedModeBanner: false,
          home: DefaultTabController(
            initialIndex: Constants.openedOnce ? 2 : 0,
            length: 3,
          child: Scaffold(
            appBar: AppBar(
              title:
              Text( 'Fungle', style: TextStyle(color: Colors.black, fontFamily: 'Montserrat'),),
              actions: [
                GestureDetector(
                child: Icon(Icons.exit_to_app, color: Colors.black,),
                onTap: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.remove('email');
                  authMethods.signOut();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Authenticate()));
                },),
                
                ],
              backgroundColor: Colors.white,
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.person, color: Colors.black,)),
                  Tab(icon: Icon(Icons.map, color: Colors.black)),
                  Tab(icon: Icon(Icons.message, color: Colors.black)),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                ProfileLayout(),
                MainHub(),
                ChatRoom(),
              ],
            )
          ),
        )
      ),
      
      // ignore: missing_return
      onWillPop: () {
        if (Constants.isChatOpened) {Navigator.push(
              context, MaterialPageRoute(builder: (context) => MainLayout()));
              Constants.isChatOpened = false;}
        else { 
          SystemNavigator.pop();
        }
      }
      );
  }   
}  