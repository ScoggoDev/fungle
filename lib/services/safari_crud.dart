import 'package:cloud_firestore/cloud_firestore.dart';
//aasd
class CrudMethods {

  Future <void> addData(safariData) async {
    FirebaseFirestore.instance.collection("safaris").add(safariData)
    .catchError((e){
      print(e);
    });
  }

  getData() async {
    return await FirebaseFirestore.instance.collection("safaris").snapshots();
  }

}