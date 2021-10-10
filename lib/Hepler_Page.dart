import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp1/HelperDetail.dart';
import 'package:flutterapp1/SecondRoute.dart';
import 'package:intl/intl.dart';
import 'Services/Database.dart';

class Helper_Page extends StatefulWidget {
  @override
  _Helper_PageState createState() => _Helper_PageState();
}

class _Helper_PageState extends State<Helper_Page> {

  @override
  void initState(){
    super.initState();
    getTotalHelperAmount();
    print('Init State Called');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keshav Industries'),
        backgroundColor: Colors.blue,
        leading: Icon(Icons.menu),
        actions: <Widget>[
      StreamBuilder(
      stream: Firestore.instance
          .collection('Total Amount')
          .document('total helper amount')
          .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Text("Loading");
          }
          var userDocument = snapshot.data;
          return Center(child: Container(child: Text('Total: ₹${userDocument['amount']}')));
        }),
          IconButton(
            icon: Icon(
              Icons.add_circle_outline,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddHelper()));
            },
          )
        ],
      ),
      body: HelperPageBody(),
    );
  }
}

//Widget _getTotalAmt() {
//  getTotalHelperAmount();
//
//  StreamBuilder(
//      stream: Firestore.instance
//          .collection('Total Amount')
//          .document('total helper amount')
//          .snapshots(),
//      builder: (context, snapshot) {
//        if (!snapshot.hasData) {
//          return new Text("Loading");
//        }
//        var userDocument = snapshot.data;
//        return Center(child: Container(child: Text('₹${userDocument['amount']}')));
//      });
//}



class AddHelper extends StatefulWidget {
  @override
  _AddHelperState createState() => _AddHelperState();
}

class _AddHelperState extends State<AddHelper> {
  String Name;
  String amount='0';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Helper'),
      ),
      body: Container(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Container(
                    width: ((MediaQuery.of(context).size.width) / 2) + 20,
                    child: TextField(
                      autofocus: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Name*',
                      ),
                      onChanged: (String name) {
                        Name = name;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Container(
                    width: ((MediaQuery.of(context).size.width) / 2) - 60,
                    child: TextField(
                      keyboardType:
                      TextInputType.number,
                      inputFormatters: <
                          TextInputFormatter>[
                        WhitelistingTextInputFormatter
                            .digitsOnly,
                      ],
                      autofocus: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'initial amount',
                      ),
                      onChanged: (String amt) {
                        amount = amt;
                      },
                    ),
                  ),
                ),
              ],
            ),
            FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: () {
                if (Name.length > 1) {
                  //Adding new helper name to database
                    DatabaseServices().addHelperName(Name, int.parse(amount));


                  print('Pressed Add Button, added Name:" $Name "to FireStore');
                  Navigator.pop(context);
                } else {
                  print("Name Found Null When pressed added button");
                }
              },
              child: Text(
                "Add",
                style: TextStyle(fontSize: 15.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget HelperPageBody() {
  return StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance.collection('attendance').snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
      switch (snapshot.connectionState) {
        case ConnectionState.waiting:
          return new Text('Loading ...');
        default:
          return new ListView(
            children: snapshot.data.documents.map((DocumentSnapshot document) {
              return Column(
                children: <Widget>[
                  Card(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: CircleAvatar(
                            child: Image(
                                image: AssetImage(
                                    "assets/images/Helper_icon.png")),
                            backgroundColor: Colors.transparent,
                            radius: 35,
                          ),
                          title: Row(
                            children: <Widget>[
                              Text(
                                '${document['name'].toString()}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(' (₹${document['total amount']})',),
                            ],
                          ),
                          subtitle: RichText(
                            text: TextSpan(
                                style: TextStyle(color: Colors.grey[700]),
                                text: 'Present today: ',
                                children: <TextSpan>[
                                  TextSpan(
                                    text: document['last attendance'] == null
                                        ? 'No record Found'
                                        : document['last attendance'] ==
                                                DateFormat.yMMMMd()
                                                    .format(DateTime.now())
                                            ? 'Yes'
                                            : document['last attendance'] ==
                                                    ('No' +
                                                        DateFormat.yMMMMd()
                                                            .format(
                                                                DateTime.now())
                                                            .toString())
                                                ? 'No'
                                                : 'Pending', //This logic needs to be changed afterwards
                                    style: TextStyle(
                                        color: document['last attendance'] ==
                                                null
                                            ? Colors.yellow[800]
                                            : document['last attendance'] ==
                                                    DateFormat.yMMMMd()
                                                        .format(DateTime.now())
                                                ? Colors.green
                                                : document['last attendance'] ==
                                                        ('No' +
                                                            DateFormat.yMMMMd()
                                                                .format(DateTime
                                                                    .now())
                                                                .toString())
                                                    ? Colors.red
                                                    : Colors.yellow[900]),
                                  ),
                                ]),
                          ),
                          trailing: IconButton(
                            icon:
                                Icon(Icons.delete_outline, color: Colors.black),
                            onPressed: () {
                              _neverSatisfied(
                                  context, document.documentID.toString());
                            },
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailCard(
                                          docId: document.documentID.toString(),
                                          name: document['name'].toString(),
                                        )));
                            print(
                                'Prrrrrrreeeeeeeessssssssssssssseeeeeeeeddddddddd');
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }).toList(),
          );
      }
    },
  );
}

Future<void> _neverSatisfied(BuildContext context, String docId) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Do you want to delete?'),
        content: Text('This can\'t be undone'),
        actions: <Widget>[
          FlatButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('Delete'),
            onPressed: () {
              _deleteCard(docId);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future _deleteCard(String docId) async {
  //for deleting subcollection
  await Firestore.instance
      .collection('attendance')
      .document(docId)
      .collection('history')
      .getDocuments()
      .then((snapshot) {
    for (DocumentSnapshot doc in snapshot.documents) {
      doc.reference.delete();
    }
  });
  //for deleting that particular document
  await Firestore.instance.collection('attendance').document(docId).delete();
}
