import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'SecondRoute.dart';

//ImageCache get imageCache => PaintingBinding.instance.imageCache;

void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: SecondRoute()));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //SizedBox(height: 50,),
            Container(
              height: 115.00,
              width: 384.00,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/signature.png"),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //SizedBox(width: 75.0,),
                Container(
                  width: 275.0,
                  child: TextField(
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      labelText: 'Username',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 275.0,
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(hintText: 'Password'),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 100.0,
            ),
            Container(
              height: 66.00,
              width: 223.00,
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                border: Border.all(
                  width: 1.00,
                  color: Color(0xff707070),
                ),
                borderRadius: BorderRadius.circular(33.00),
              ),
              child: FlatButton(
                onPressed: () {

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SecondRoute()));
                },
                child: Text('Login'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
