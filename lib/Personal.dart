import 'package:flutter/material.dart';
import 'package:flutterapp1/Custom_Widgets/PersonalPage_Card.dart';

class Personal extends StatefulWidget {
  @override
  _PersonalState createState() => _PersonalState();
}

class _PersonalState extends State<Personal> {
  int num =1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keshav Industries'),
        backgroundColor: Colors.blue,
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          Container(
              height: 20,
              color: Colors.blue[600],
              child: Row(
                children: <Widget>[
                  Text(
                    '      RECENT RECORDS',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white),
                  ),
                ],
              )
          ),
          PersonalCard(title: 'Petrol',amount: 765,),
         SizedBox(height: 250,),
          Center(
            child: Container(
              transform: new Matrix4.identity()
                ..rotateZ(100),
              child: Text('Under Development!!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange[300]),),
            ),
          )


        ],
      ),
    );
  }
}

/*
Widget GetList(){
  var listView= ListView(
    children: <Widget>[
      PersonalCard(title: 'Changed Petrol',amount: 765,),
      PersonalCard(title: 'Machine Part',amount: 9000,),
     
    ],
  );
  return listView;
}
*/

