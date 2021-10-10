import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'Services/Database.dart';

class DetailCard extends StatefulWidget {
  final String docId;
  final String name;
  DetailCard({this.docId, this.name});
  @override
  _DetailCardState createState() => _DetailCardState(docId: docId, name: name);
}

class _DetailCardState extends State<DetailCard> {
  String docId;
  String name;
  _DetailCardState({this.docId, this.name});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('$name'),
        actions: <Widget>[
          FlatButton(
            child: Text('Pay Advance',
                style: TextStyle(
                  color: Colors.white,
                )),
            onPressed: () {
              _askAdvanceAmount(context, docId);
            },
          )
        ],
      ),
      body: detailCard(docId),
      floatingActionButton: FloatingActionButton.extended(
        label: Row(
          children: <Widget>[
            Text('Clear Total Balance'),
          ],
        ),
        backgroundColor: Colors.lightBlue,
        splashColor: Colors.greenAccent,
        onPressed: () {
          _askTotalAmount(context, docId);
          //Navigator.pop(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

Widget detailCard(String docId) {
  return Column(
    children: <Widget>[
      StreamBuilder(
          stream: Firestore.instance
              .collection('attendance')
              .document(docId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return new Text("Loading");
            }
            var userDocument = snapshot.data;
            return Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 15,
                      ),
                      FlatButton(
                        color: Colors.lightBlue,
                        textColor: Colors.white,
                        splashColor: Colors.blueAccent,
                        onPressed: () {
                          _askAddRecord(context, docId);
                        },
                        child: Text('Add Record'),
                      ),
                    ],
                  )),
                  Text(
                    'Total Amount: ₹${userDocument["total amount"]}    ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  )
                ],
              ),
            );
          }),
      Container(
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '*Note: Long press on record to delete',
              style: TextStyle(color: Colors.grey),
            )),
      ),
      StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('attendance')
            .document(docId)
            .collection('history').orderBy("dateTimeStamp", descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Text('Loading ...');
            default:
              return Container(
                height: MediaQuery.of(context).size.height - 150,
                child: ListView(
                  children:
                      snapshot.data.documents.map((DocumentSnapshot document) {
                    return GestureDetector(
                      child: Card(
                        child: Container(
                          height: 35,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    ' ' + document['date'].toString(),
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  Text(
                                    '₹' + document['amount'].toString() + '   ',
                                    style: TextStyle(fontSize: 17),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      onLongPress: () {
                        _askDeleteRecord(context, docId, document.documentID);
                      },
                    );
                  }).toList(),
                ),
              );
          }
        },
      )
    ],
  );
}

Future<void> _askAdvanceAmount(BuildContext context, String docId) async {
  String amount;
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          children: <Widget>[
            Text('Enter Amount  '),
            Container(
              height: 25,
              width: 70,
              child: TextField(
                autofocus: true,
                onChanged: (s) {
                  amount = s;
                },
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly,
                ],
              ),
            ),
          ],
        ),
        actions: <Widget>[
          FlatButton(
            color: Colors.green,
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            padding: EdgeInsets.all(8.0),
            splashColor: Colors.greenAccent,
            onPressed: () {
              payAdvance(docId, int.parse('-' + amount));
              Navigator.of(context).pop();
            },
            child: Text(
              "Submit",
              style: TextStyle(fontSize: 15.0),
            ),
          )
        ],
      );
    },
  );
}

Future<void> _askTotalAmount(BuildContext context, String docId) async {
  String amount;
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: StreamBuilder(
            stream: Firestore.instance
                .collection('attendance')
                .document(docId)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return new Text("Loading");
              }
              var userDocument = snapshot.data;
              return Text(
                'Pay ₹${userDocument["total amount"]}?',
              );
            }),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.black,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            padding: EdgeInsets.all(8.0),
            splashColor: Colors.lightBlue,
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Cancel",
              style: TextStyle(fontSize: 15.0),
            ),
          ),
          FlatButton(
            color: Colors.green,
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            padding: EdgeInsets.all(8.0),
            splashColor: Colors.greenAccent,
            onPressed: () {
              clearTotalBalance(docId);
              Navigator.of(context).pop();
            },
            child: Text(
              "Pay",
              style: TextStyle(fontSize: 15.0),
            ),
          )
        ],
      );
    },
  );
}

Future<void> _askDeleteRecord(
    BuildContext context, String docId, String RdocId) async {
  String amount;
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: StreamBuilder(
            stream: Firestore.instance
                .collection('attendance')
                .document(docId)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return new Text("Loading");
              }
              var userDocument = snapshot.data;
              return Text('Delete record?');
            }),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.black,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            padding: EdgeInsets.all(8.0),
            splashColor: Colors.lightBlue,
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Cancel",
              style: TextStyle(fontSize: 15.0),
            ),
          ),
          FlatButton(
            color: Colors.green,
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            padding: EdgeInsets.all(8.0),
            splashColor: Colors.greenAccent,
            onPressed: () {
              deleteRecord(docId, RdocId);
              Navigator.of(context).pop();
            },
            child: Text(
              "Yes",
              style: TextStyle(fontSize: 15.0),
            ),
          )
        ],
      );
    },
  );
}

Future<void> _askAddRecord(BuildContext context, String docId) async {

  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (context) {
      DateTime _dateTime =  DateTime.now();
      String amount;
      return StatefulBuilder(
        builder: (context, setState){
          return AlertDialog(
            title: Text('Enter details:'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('Amount:    '),
                      Container(
                          height: 30,
                          width: 100,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              WhitelistingTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (s){
                              amount = s;
                            },
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Text('    Date:       '),
                      GestureDetector(
                        child: Container(
                            color: Colors.white70,
                            width: 100,
                            child: Text(DateFormat.yMMMMd().format(_dateTime).toString())
                        ),
                        onTap: (){
                          showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2020), lastDate: DateTime.now()).then((date){
                             setState(() {
                          _dateTime =  date;
                        });
                            print(_dateTime);
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                textColor: Colors.black,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.all(8.0),
                splashColor: Colors.lightBlue,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.all(8.0),
                splashColor: Colors.greenAccent,
                onPressed: () {
                  addManualRecord(docId,int.parse(amount),_dateTime);

                  Navigator.of(context).pop();
                },
                child: Text(
                  "Submit",
                  style: TextStyle(fontSize: 15.0),
                ),
              )
            ],
          );

        }
      );


    },
  );
}
