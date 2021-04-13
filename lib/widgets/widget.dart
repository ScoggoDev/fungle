import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
  );
}

//FunButton
class FunButton extends StatelessWidget {
  FunButton(
      {
      @required this.text,
      @required this.width,
      @required this.height,
      @required this.radius,
      @required this.toExecute
      });

  final GestureTapCallback onPressed = null;

  final String text;
  final double width;
  final double height;
  final double radius;
  final VoidCallback toExecute;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: new RawMaterialButton(
          fillColor: Colors.orange[200],
          splashColor: Colors.yellow,
          highlightColor: Colors.yellow,
          onPressed: toExecute,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontFamily: 'Montserrat Alternates',
              fontSize: 18
            ),           
        ),
      ),
          
    );
  }
}
