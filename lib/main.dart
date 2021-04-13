import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sandbox/helper/authenticate.dart';
import 'package:sandbox/helper/shared_preferences_functions.dart';
import 'package:sandbox/views/animalQuiz.dart';
import 'package:sandbox/views/create_event.dart';
import 'package:sandbox/views/signin.dart';
import 'package:sandbox/views/tab_layout.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  runApp(MaterialApp(
      home: 
      //email == null || email == "" ? Authenticate() : MainLayout()
      AnimalQuiz()
      ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn = false;

  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await SharedPreferencesFunctions.getUserLoggedInSharedPreference()
        .then((value) {
      userIsLoggedIn = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp();
  }
}

class IamBlank extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
