import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sandbox/helper/constants.dart';
import 'package:sandbox/services/safari_crud.dart';
import 'package:sandbox/views/create_event.dart';

class MainHub extends StatefulWidget {
  @override
  _MainHubState createState() => _MainHubState();
}

class _MainHubState extends State<MainHub> {
  CrudMethods crudMethods = new CrudMethods();
  Stream safariStream;

  @override
  void initState() {
    super.initState();

    crudMethods.getData().then((result){
      setState(() {
        safariStream = result;
      });
    });
  }

   Widget SafariList() {
    return SingleChildScrollView(
      child: safariStream != null
          ? Column(
              children: <Widget>[
                StreamBuilder(
                  stream: safariStream,
                  builder: (context, snapshot) {
                    if(snapshot.data == null) return CircularProgressIndicator(); //Removes called documents on null error
                    return ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        itemCount: snapshot.data.docs.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return SafarisTile(
                            owner: snapshot.data.docs[index].data()['owner'],
                            title: snapshot.data.docs[index].data()["title"],
                            desc: snapshot.data.docs[index].data()['desc'],
                            imgUrl: snapshot.data.docs[index].data()['imgUrl'],
                          );
                        });
                  },
                )
              ],
            )
          : Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Container(
        child:
          Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //Text
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Hello, " + Constants.myName, style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize:21
                        ),),

                        Text("Let's explore what's happening nearby", style: TextStyle(
                          fontSize:16
                        ),),
                        ],),

                    //Categories
                    Container(
                      height: 132,
                      child:
                        ListView(
                            // This next line does the trick.
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                            Container(
                              child: 
                                Column(
                                  children: <Widget>[
                                    SizedBox(height: 16),
                                    Image.asset("assets/sports-black.png", height: 30),
                                    SizedBox(height: 8),
                                    Text("Sports", style: TextStyle(fontSize: 15, color: Colors.black),)
                                  ],
                                ), 
                              margin: EdgeInsets.only(right: 8, top: 24, bottom: 24),
                              width: 80.0,
                              decoration: BoxDecoration(
                                color: Color(0xFFFFCC80),
                                borderRadius: BorderRadius.circular(12)
                              ),
                            ),
                            Container(
                              child: 
                                Column(
                                  children: <Widget>[
                                    SizedBox(height: 16),
                                    Image.asset("assets/speaker.png", height: 30),
                                    SizedBox(height: 8),
                                    Text("Party", style: TextStyle(fontSize: 15, color: Colors.black),)
                                  ],
                                ), 
                              margin: EdgeInsets.only(right: 6, left: 6, top: 24, bottom: 24),
                              width: 80.0,
                              decoration: BoxDecoration(
                                color: Color(0xFFFFCC80),
                                borderRadius: BorderRadius.circular(12)
                              ),
                            ),
                            Container(
                              child: 
                                Column(
                                  children: <Widget>[
                                    SizedBox(height: 16),
                                    Image.asset("assets/persons.png", height: 30),
                                    SizedBox(height: 8),
                                    Text("Just chill", style: TextStyle(fontSize: 15, color: Colors.black),)
                                  ],
                                ), 
                              margin: EdgeInsets.only(right: 6, left: 6, top: 24, bottom: 24),
                              width: 80.0,
                              decoration: BoxDecoration(
                                color: Color(0xFFFFCC80),
                                borderRadius: BorderRadius.circular(12)
                              ),
                            ),
                            Container(
                              child: 
                                Column(
                                  children: <Widget>[
                                    SizedBox(height: 16),
                                    Image.asset("assets/beer.png", height: 30),
                                    SizedBox(height: 8),
                                    Text("Drinks", style: TextStyle(fontSize: 15, color: Colors.black),)
                                  ],
                                ), 
                              margin: EdgeInsets.only(right: 6, left: 6, top: 24, bottom: 24),
                              width: 80.0,
                              decoration: BoxDecoration(
                                color: Color(0xFFFFCC80),
                                borderRadius: BorderRadius.circular(12)
                              ),
                            ),
                            Container(
                                child: 
                                  Column(
                                    children: <Widget>[
                                      SizedBox(height: 16),
                                      Image.asset("assets/games.png", height: 30),
                                      SizedBox(height: 8),
                                      Text("Games", style: TextStyle(fontSize: 15, color: Colors.black),)
                                    ],
                                  ), 
                                margin: EdgeInsets.only(right: 6, left: 6, top: 24, bottom: 24),
                                width: 80.0,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFCC80),
                                  borderRadius: BorderRadius.circular(12)
                                ),
                              ),
                        ],
                      ),
                    )
                    ,
                    //Events
                    Text("Popular Events", style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Montserrat"
                      ),
                    ),
                    SizedBox(height: 8)
                    ,
                    Expanded(child: 
                      SafariList()
                    )
                    
                  ],
                ), 
              ),
              
            ],)
      ),
      
      floatingActionButton: 
      Container(
        child: 
          Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            FloatingActionButton(
              backgroundColor: Color(0xFFFFCC80),
              onPressed: () {
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CreateSafari()));
              },
              child: Icon(Icons.add)
            )
          ]
        ),
      )
    );
  }
}

//CONSTRUCTOR
class SafarisTile extends StatelessWidget {
  String imgUrl, title, owner, desc;
  SafarisTile({@required this.imgUrl, 
               @required this.title,
               @required this.owner,
               @required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      margin: EdgeInsets.only(bottom: 16),
      child: Stack(
        children: <Widget> [
              Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(imgUrl),
                ),
              ),
            ),
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: Colors.black45.withOpacity(0.3),
              borderRadius: BorderRadius.circular(6)),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 6),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(title, textAlign: TextAlign.center, style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w500),),
                SizedBox(height: 4),
                Text(desc, textAlign: TextAlign.center, style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400)),
                SizedBox(height: 4),
                Text(owner, textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
              ],
            ),
          )
        ],
      ), 
    );
  }
}