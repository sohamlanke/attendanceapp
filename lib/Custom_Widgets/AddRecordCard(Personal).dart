//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class PersonalRecordAddCard extends StatefulWidget {
  @override
  _PersonalRecordAddCardState createState() => _PersonalRecordAddCardState();
}

class _PersonalRecordAddCardState extends State<PersonalRecordAddCard> {

  FocusNode textSecondFocusNode = new FocusNode();
  FocusNode textSecondFocusNode1 = new FocusNode();
  FocusNode textSecondFocusNode2 = new FocusNode();
  DateTime _dateTime;


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 15,),
          Row(
            children: <Widget>[

            ],
          ),
          ListTile(
            leading: Container(
              //color: Colors.lightGreen,
              width: 10,
              decoration: BoxDecoration(
                color: Colors.blue[300],
                borderRadius: BorderRadius.circular(5.00),
              ),
            ),
            title: Container(
              //color: Colors.blue,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        'Date : ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: 100,
                        height: 25,
                        child: TextField(
                          readOnly: true,

                          onTap: (){
                            showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2020), lastDate: DateTime.now()).then((date){
                              setState(() {
                                _dateTime = date;
                              });
                              print(date);
                            });
                          },

                        ),
                      )
                    ],
                  ),


                  SizedBox(height: 10,),

                  Row(
                    children: <Widget>[
                      Text(
                        'Title:  ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(

                        width: 180,
                        height: 25,
                        child: TextField(
                          autofocus: true,
                          onSubmitted: (String value) {
                            FocusScope.of(context).requestFocus(textSecondFocusNode);
                          },


                        ),
                      )
                    ],
                  ),


                  SizedBox(height: 10,),

                  Row(
                    children: <Widget>[
                      Text(
                        '   ₹   :  ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: 100,
                        height: 25,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          focusNode: textSecondFocusNode,
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly,
                          ],
                          onSubmitted: (String value) {
                            FocusScope.of(context).requestFocus(textSecondFocusNode1);
                          },


                        ),
                      )
                    ],
                  ),



                  SizedBox(height: 10,),





                  Row(
                    children: <Widget>[
                      Text(
                        'Type : ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(

                        /* decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blueGrey,

                          ),
                        ),*/
                        width: 100,
                        height: 25,
                        child: TextField(


                          focusNode: textSecondFocusNode1,
                          onSubmitted: (String value) {
                            FocusScope.of(context).requestFocus(textSecondFocusNode2);
                          },

                        ),
                      )
                    ],
                  ),

                  SizedBox(height: 10,),

                  Row(
                    children: <Widget>[
                      Text(
                        'To/From : ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(

                        /* decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blueGrey,

                          ),
                        ),*/
                        width: 100,
                        height: 25,
                        child: TextField(

                          focusNode: textSecondFocusNode2,

                        ),
                      )
                    ],
                  ),

                  SizedBox(height: 10,),

                  Row(
                    children: <Widget>[
                      Text(
                        'Comment : ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: 125,
                        height: 30,
                      //  color: Colors.red,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Optional',
                          ),

                        ),
                      )
                    ],
                  ),



                  SizedBox(height: 15,),




                ],
              )
            ),
            /*subtitle: Text(
              'Date: 23rd May 2020',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),*/
            //isThreeLine: true,
            trailing: IconButton(
              onPressed: (){},
              icon: Icon(
                Icons.delete_outline,
                size: 22,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
