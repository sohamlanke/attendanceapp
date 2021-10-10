import 'package:flutter/material.dart';
import 'package:flutterapp1/Custom_Widgets/AddRecordCard(Personal).dart';
class PersonalAddPage extends StatefulWidget {
  @override
  _PersonalAddPageState createState() => _PersonalAddPageState();
}

class _PersonalAddPageState extends State<PersonalAddPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Personal Record'),
        backgroundColor: Colors.blue,
        actions: <Widget>[
          FlatButton(
            child: Text('Submit', style: TextStyle(color: Colors.white),),
            onPressed: (){},
          )
        ],
      ),
      body: ListView.builder(
          itemCount: 1,
          itemBuilder: (context,index){
            return PersonalRecordAddCard();

      }),
        floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
          onPressed: (){
          },
    ),
    );
  }
}
