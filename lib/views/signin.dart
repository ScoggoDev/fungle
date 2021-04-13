import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sandbox/helper/constants.dart';
import 'package:sandbox/services/authMethods.dart';
import 'package:sandbox/services/database.dart';
import 'package:sandbox/views/signup.dart';
import 'package:sandbox/views/tab_layout.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/shared_preferences_functions.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);
  @override _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  //Objetos
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  //Controladores de texto
  TextEditingController emailTextEdittingController =
      new TextEditingController();
  TextEditingController passwordTextEdittingController =
      new TextEditingController();

  //Vars
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  QuerySnapshot snapshotUserInfo;

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    Constants.myName =
        await SharedPreferencesFunctions.getUserNameSharedPreference();
    
      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setString('email', emailTextEdittingController.text);
  }


  signIn() {
    if (formKey.currentState.validate()) {
      SharedPreferencesFunctions.saveUserNameSharedPreference(
          emailTextEdittingController.text);
      //SharedPreferencesFunctions.saveUserEmailSharedPreference(usernameTextEdittingController.text);

      databaseMethods
          .getUserByUserEmail(emailTextEdittingController.text)
          .then((val) {
        snapshotUserInfo = val;
        SharedPreferencesFunctions.saveUserNameSharedPreference(
            snapshotUserInfo.docs[0].data()["name"]);
      });

      setState(() {
        isLoading = true;
      });

      authMethods
          .signInWithEmailAndPassword(emailTextEdittingController.text,
              passwordTextEdittingController.text)
          .then((val) {
        //el then(val) retorna un valor siempre que la llamada sea correcta
        if (val != null) {
          SharedPreferencesFunctions.saveUserLoggedInSharedPreference(true);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MainLayout()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [],
              ),
            ),
            TextFormField(
              validator: (val) {
                if (RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(val)) {
                  return null;
                } else {
                  return "Please enter a valid email";
                }
              },
              controller: emailTextEdittingController,
              decoration: InputDecoration(hintText: "E-mail"),
            ),
            TextFormField(
              obscureText: true,
              validator: (val) {
                return val.length > 6
                    ? null
                    : "Password must have at least 6 characters";
              },
              controller: passwordTextEdittingController,
              decoration: InputDecoration(hintText: "password"),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text("Forgot Password?"),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            GestureDetector(
              onTap: () {
                getUserInfo();
                signIn();
                print(Constants.myName);
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      const Color(0xFFFFF176),
                      const Color(0xFFFFCC80)
                    ]),
                    borderRadius: BorderRadius.circular(30)),
                child: Text(
                  "Sign In",
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(30)),
              child: Text(
                "Sign in with Google",
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account? "),
                GestureDetector(
                  onTap: () {
                    widget.toggle();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text("Register now",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 15)),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
