import 'package:flutter/material.dart';
import 'package:sandbox/helper/constants.dart';
import 'package:sandbox/helper/shared_preferences_functions.dart';
import 'package:sandbox/services/authMethods.dart';
import 'package:sandbox/services/database.dart';
import 'package:sandbox/views/tab_layout.dart';

class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp(this.toggle);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  bool isLoading = false;

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  //SharedPreferencesFunctions sharedPreferencesFunctions = new SharedPreferencesFunctions();

  final formKey = GlobalKey<FormState>();
  TextEditingController usernameTextEdittingController = new TextEditingController();
  TextEditingController emailTextEdittingController = new TextEditingController();
  TextEditingController passwordTextEdittingController = new TextEditingController();  
  TextEditingController animalTextEdittingController = new TextEditingController();  


    getUserInfo() async {
    Constants.myName = await SharedPreferencesFunctions.getUserNameSharedPreference();
    
  }

  signMeUp() {

    if (formKey.currentState.validate()) {
      Map<String, String> userInfoMap = {
        "email": emailTextEdittingController.text, 
        "name" : usernameTextEdittingController.text,
        "animal" : animalTextEdittingController.text
        }; 

      SharedPreferencesFunctions.saveUserEmailSharedPreference(emailTextEdittingController.text);
      SharedPreferencesFunctions.saveUserNameSharedPreference(usernameTextEdittingController.text);
      SharedPreferencesFunctions.saveUserAnimalSharedPreference(animalTextEdittingController.text);

      setState(() {
        isLoading = true;
      });
      
      authMethods.signUpWithEmailAndPassword(emailTextEdittingController.text,
       passwordTextEdittingController.text).then((val){
        //print("${val.uid}");

        databaseMethods.uploadUserInfo(userInfoMap);
        SharedPreferencesFunctions.saveUserLoggedInSharedPreference(true);
        Navigator.push(context, MaterialPageRoute(builder: (context) => MainLayout()));
      });

    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading ? Container (child: Center( child: CircularProgressIndicator()),)
        : //ternary false
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column( mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Form(key: formKey,
              child: Column(children: [
                TextFormField(
                  validator: (val) {
                    return val.isEmpty || val.length <2 ? "Username can't be empty" : null;
                  },
                  controller: usernameTextEdittingController,
                  decoration: InputDecoration(
                    hintText: "username"
                  ),
                ),
                   TextFormField(
                  validator: (val) {
                    if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val)) {
                      return null;
                    } else {
                      return "Please enter a valid email";
                    }
                  },
                  controller: emailTextEdittingController,
                  decoration: InputDecoration(
                    hintText: "email"
                  ),
                ),
                TextFormField(
                  obscureText: true,
                  validator: (val) {
                    return val.length > 6 ? null : "Password must have at least 6 characters";
                  },
                  controller: passwordTextEdittingController,
                  decoration: InputDecoration(
                    hintText: "password"
                  ),
                ),
                TextFormField(
                  validator: (val) {
                    return val.isEmpty || val.length <2 ? "Animal can't be empty" : null;
                  },
                  controller: animalTextEdittingController,
                  decoration: InputDecoration(
                    hintText: "animal"
                  ),
                ),
                ],),),

            SizedBox(height: 12,),

            Container(
              alignment: Alignment.centerRight,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal:16, vertical:8),
                child: Text("Forgot Password?"),),
            ),

            SizedBox(height: 12,),

            GestureDetector(
                onTap: () {
                  getUserInfo();
                  signMeUp();
                  print(Constants.myName);
                },
                child: 
                Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFFFFF176),
                      const Color(0xFFFFCC80)
                    ]
                  ),
                  borderRadius: BorderRadius.circular(30)
                ),
                child: 
              Text("Sign Up", ),),
            ),

            SizedBox(height: 16,),

            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(30)
              ),
              child: 
            Text("Sign Up with Google", ),),

            SizedBox(height: 12,),
            
            Row( 
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account? "),
                GestureDetector(
                  onTap: () {
                      widget.toggle();
                    },
                  child: 
                   Container(
                  child:
                    Text("Sign in now", style: TextStyle(decoration: TextDecoration.underline, fontSize: 15)),
                ),
              ),
               
              ],
            )

          ],),
        ),

    );
        
     
  }
}
