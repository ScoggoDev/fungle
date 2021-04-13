import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:sandbox/helper/constants.dart';
import 'package:sandbox/services/safari_crud.dart';

class CreateSafari extends StatefulWidget {
  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateSafari> {
  String title, description;

  CrudMethods crudMethods = new CrudMethods();

  File selectedImage;
  bool isLoading = false;
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      selectedImage = image;
    });
  }

  uploadSafari () async{
    setState(() {
      isLoading = true;
    });
    if ( selectedImage!=null) {
      StorageReference firebaseStorageRef = FirebaseStorage.instance.ref()
        .child("safariImage").child("${randomAlphaNumeric(5)}${DateTime.now().millisecondsSinceEpoch}.jpg");
      
      final StorageUploadTask task = firebaseStorageRef.putFile(selectedImage);

      var downloadUrl = await (await task.onComplete).ref.getDownloadURL();
      print("this is url $downloadUrl");
      Map<String, String> safariMap = {
        "imgUrl": downloadUrl,
        "owner": Constants.myName,
        "title": title,
        "desc": description
      };

      crudMethods.addData(safariMap).then((result){
        Navigator.pop(context);
      });
    }
    else {

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: isLoading ? 
        Container(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        )
          :
        Column(
          children: <Widget>[
            SizedBox(height: 10),
            GestureDetector(
              onTap: (){
                getImage();
              },
              child: 
                selectedImage == null ?
                Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                height: 150, 
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6)),
                child: 
                  Icon(Icons.add_a_photo)
                )
                  :
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  height: 150, 
                  width: MediaQuery.of(context).size.width,
                  child:
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.file(selectedImage, fit: BoxFit.cover),
                        )
                      ),
              ),
            SizedBox(height : 8),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(hintText: "Safari name"),
                    onChanged: (val){
                      title = val;
                    },
                    ),
                    TextField(
                    decoration: InputDecoration(hintText: "Description"),
                    onChanged: (val){
                      description = val;
                    },
                    ),
                    TextField(
                    decoration: InputDecoration(hintText: "Location"),
                    onChanged: (val){
                      title = val;
                    },
                    ),
                    SizedBox(height: 100,),
                    GestureDetector(
                      onTap: () {
                        uploadSafari();
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
                    Text("Create Safari", ),
                      ),
                    ), 
                  ]
                )
              )
          ],
        ),
    );
  }
}