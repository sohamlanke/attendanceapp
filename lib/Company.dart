import 'package:flutter/material.dart';

class Company extends StatefulWidget {
  @override
  _CompanyState createState() => _CompanyState();
}

class _CompanyState extends State<Company> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keshav Industries'),
        backgroundColor: Colors.blue,
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
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Container(
                    //color: Colors.lightGreen,
                    width: 10,
                    decoration: BoxDecoration(
                      color: Colors.blue[300],
                      borderRadius: BorderRadius.circular(5.00),
                    ),
                  ),
                  title: Text(
                    '₹30000 - Raw Material',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Date: 23rd May 2020',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                  trailing: Icon(
                    Icons.delete,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 350,),
          Center(
            child: Container(
              transform: new Matrix4.identity()
                ..rotateZ(0),
              child: Text('Under Development!!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red[300]),),
            ),
          )
        ],
      ),

    );
  }
}
