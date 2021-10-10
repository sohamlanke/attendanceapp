import 'package:flutter/material.dart';
import 'package:flutterapp1/Attendance.dart';
import 'package:flutterapp1/Personal.dart';
import 'package:flutterapp1/PersonalRecord_AddPage.dart';
import 'package:flutterapp1/Test.dart';
import 'Hepler_Page.dart';
import 'Company.dart';
import 'Invoice.dart';

class SecondRoute extends StatefulWidget {
  @override
  _SecondRouteState createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  // Properties & Variables needed

  int currentTab = 0; // to keep track of active tab index
  final List<Widget> screens = [
    Helper_Page(),
    Personal(),
    Invoice(),
    Company(),
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Helper_Page(); // Our first view in viewport

  @override
  Widget build(BuildContext context) {
    /*This dart file has only BottomNavigationBar, Appbar and Floating Button*/
    return Scaffold(

      body: PageStorage(
      child: currentScreen,
      bucket: bucket,
    ),
      bottomNavigationBar: BottomAppBar(
        elevation: 10,
        child: Container(
            height: 55,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen =
                              Helper_Page(); // if user taps on this dashboard tab will be active
                          currentTab = 0;
                        });
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.people,
                            color: currentTab == 0? Colors.lightBlue: Colors.black,
                          ),
                          Text(
                            'Helpers',
                            style: TextStyle(color: currentTab == 0? Colors.lightBlue: Colors.black,),
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen =
                              Personal(); // if user taps on this dashboard tab will be active
                          currentTab = 1;
                        });
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.assistant_photo,
                            color: currentTab == 1? Colors.lightBlue: Colors.black,
                          ),
                          Text(
                            'Personal',
                             style: TextStyle(color: currentTab == 1? Colors.lightBlue: Colors.black,),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen =
                              Company(); // if user taps on this dashboard tab will be active
                          currentTab = 3;
                        });
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.assessment,
                             color: currentTab == 3? Colors.lightBlue: Colors.black,
                          ),
                          Text(
                            'Company',
                             style: TextStyle(color: currentTab == 3? Colors.lightBlue: Colors.black),
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen =
                              Invoice(); // if user taps on this dashboard tab will be active
                          currentTab = 4;
                        });
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.assignment,
                            color:  currentTab == 4? Colors.lightBlue: Colors.black,
                          ),
                          Text(
                            'Invoice',
                             style: TextStyle(color:  currentTab == 4? Colors.lightBlue: Colors.black),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
        child: currentTab == 0? Icon(Icons.today):Icon(Icons.add),
        backgroundColor:  Colors.blue,
        onPressed: () {
          if(currentTab==0) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Attendance()));
          }
          if(currentTab==1) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => PersonalAddPage()));
          }

        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
