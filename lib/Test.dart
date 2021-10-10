import 'package:flutter/material.dart';

import 'Custom_Widgets/PersonalPage_Card.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Window'),
      ),
      body: ListView(
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
          PersonalCard(title: 'Changed Petrol',amount: 765,),
          PersonalCard(title: 'Machine Part',amount: 9000,),
          PersonalCard(title: 'Changed Petrol',amount: 765,),
          PersonalCard(title: 'Machine Part',amount: 9000,),
          PersonalCard(title: 'Changed Petrol',amount: 765,),
          PersonalCard(title: 'Machine Part',amount: 9000,),
          PersonalCard(title: 'Changed Petrol',amount: 765,),
          PersonalCard(title: 'Machine Part',amount: 9000,),
          PersonalCard(title: 'Changed Petrol',amount: 765,),
          PersonalCard(title: 'Machine Part',amount: 9000,),
          PersonalCard(title: 'Changed Petrol',amount: 765,),
          PersonalCard(title: 'Machine Part',amount: 9000,),
          PersonalCard(title: 'Changed Petrol',amount: 765,),
          PersonalCard(title: 'Machine Part',amount: 9000,),


        ],
      ),
    );
  }
}
