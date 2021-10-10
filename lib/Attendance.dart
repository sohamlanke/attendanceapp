import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp1/Services/Database.dart';
import 'package:intl/intl.dart';
import 'Services/Database.dart';

class Attendance extends StatefulWidget {
  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  List<int> colorRef = [for (int i = 0; i < 50; i++) 0];
  List<int> amount = [for (int i = 0; i < 50; i++) 0];
  List docIds = [for (int i = 0; i < 50; i++) '!'];
  int length = 0;
  List<int> checkUpdating = [for (int i = 0; i < 50; i++) 1];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance'),
        backgroundColor: Colors.pink,
        actions: <Widget>[
          Center(
              child: Text(
            DateFormat.yMMMMd().format(DateTime.now()).toString() + '   ',
            style: TextStyle(fontSize: 15),
          )),
        ],
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection("attendance").snapshots(),
        builder: (context, snapshot) {
          length = snapshot.data.documents.length;
          if (!snapshot.hasData) {
            return Center(
                child: Text(
              'Connecting to Cloud...',
              style: TextStyle(fontSize: 20),
            ));
          } else {
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot docRef = snapshot.data.documents[index];
                  if (docRef['last attendance'].toString() ==
                      DateFormat.yMMMMd().format(DateTime.now()).toString()) {
                    if (checkUpdating[index] == 1) {
                      colorRef[index] = 1;
                    }
                    checkUpdating[index] = 0;
                  }
                  if (docRef['last attendance'].toString() ==
                      'No' +
                          DateFormat.yMMMMd()
                              .format(DateTime.now())
                              .toString()) {
                    if (checkUpdating[index] == 1) {
                      colorRef[index] = 2;
                    }
                    checkUpdating[index] = 0;
                  }
                  if (docRef['last attendance'] ==
                          DateFormat.yMMMMd()
                              .format(DateTime.now())
                              .toString() ||
                      docRef['last attendance'] ==
                          'No' +
                              DateFormat.yMMMMd()
                                  .format(DateTime.now())
                                  .toString()) {
                    return SizedBox.shrink();
                  }
                  return Column(
                    children: <Widget>[
                      Card(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(2, 5, 2, 5),
                              child: ListTile(
                                  leading: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      CircleAvatar(
                                        child: Image(
                                            image: AssetImage(
                                                "assets/images/Helper_icon.png")),
                                        radius: 27,
                                      ),
                                    ],
                                  ),
                                  title: Text(
                                    docRef['name'].toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text('Amount:  '),
                                          Container(
                                            height: 25,
                                            width: 75,
                                            child: TextField(
                                              onChanged: (String s) {
                                                setState(() {
                                                  amount[index] = int.parse(s);
                                                  docIds[index] =
                                                      docRef.documentID;
                                                });
                                              },
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                WhitelistingTextInputFormatter
                                                    .digitsOnly,
                                              ],
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  trailing: Container(
                                    width: 100,
                                    child: Row(
                                      children: <Widget>[
                                        IconButton(
                                          icon: Icon(
                                              colorRef[index] == 1
                                                  ? Icons.check_box
                                                  : Icons.check,
                                              color: colorRef[index] == 1
                                                  ? Colors.green
                                                  : Colors.grey),
                                          onPressed: () {
                                            setState(() {
                                              colorRef[index] = 1;
                                              docIds[index] = docRef.documentID;
                                            });
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.clear,
                                              color: colorRef[index] == 2
                                                  ? Colors.red
                                                  : Colors.grey),
                                          onPressed: () {
                                            setState(() {
                                              colorRef[index] = 2;
                                              docIds[index] = docRef.documentID;
                                            });
                                          },
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                });
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        // icon: Icon(Icons.check),
        label: Row(
          children: <Widget>[
            Text('Done'),
            SizedBox(
              width: 2.5,
            ),
            Icon(Icons.thumb_up)
          ],
        ),

        backgroundColor: Colors.pink,
        onPressed: () async {
          _submitAttendance(colorRef, amount, docIds, length);
          Navigator.pop(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

void _submitAttendance(
    List<int> colorRef, List<int> amount, List docIds, int length) {
  print(amount);
  print(colorRef);
  print(length);
  print(docIds);
  //data will be added only if docIds[index]!='!'
  for (int i = 0; i < length; i++) {
    if (docIds[i] != '!') {
      if (colorRef[i] == 2) {
        markAbsent(docIds[i]);
      } else {
        if (colorRef[i] == 1 || amount[i] != 0) {
          markPresent(docIds[i], amount[i]);
        }
      }
    }
  }
}
