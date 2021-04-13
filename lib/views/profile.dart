import 'package:flutter/material.dart';
import 'package:sandbox/helper/constants.dart';
import '../widgets/widget.dart';

ProfileLayout profile = new ProfileLayout();

class ProfileLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Align(
                alignment: Alignment.center,
                child: Column(children: [
                  SizedBox(height:20),
                  Container(
                    width: 300,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.orange[200],),
                      child: Column(
                      children: [
                        SizedBox(height: 20),
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage('https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg')
                        ),
                        SizedBox(height: 20),
                        Text("Usuario", style: TextStyle(color: Colors.black)),
                        SizedBox(height: 20),
                      ],
                  ),
                    ),
                  ),
                  Container(
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Row(
                        children: [
                          Container(
                            width: 140,
                            child: TextField(
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                    hintText: "4 amigos",
                                    hintStyle: TextStyle(color: Colors.black),
                                  enabled: false,
                                )),
                          ),
                          Container(
                            width: 160,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: TextField(
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: DateTime.now().toString(),
                                    hintStyle: TextStyle(color: Colors.black),
                                    enabled: false,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: FunButton(
                      text: "grupo",
                      width: 300.0,
                      height: 30.0,
                      radius: 90,
                      toExecute: () {},
                    ),
                  ),
                  Container(
                    width: 300,
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Descripción dada por el usuario",
                        hintStyle: TextStyle(color: Colors.black),
                        enabled: false,
                      ),
                    ),
                  ),
                  Container(
                      width: 300,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: FunButton(
                              text: "eventos pendientes",
                              width: 300.0,
                              height: 55.0,
                              radius: 90,
                              toExecute: () {},
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: FunButton(
                              text: "mis eventos",
                              width: 300.0,
                              height: 55.0,
                              radius: 90,
                              toExecute: () {},
                            ),
                          ),
                        ],
                      ))
                ]))));
  }
}
