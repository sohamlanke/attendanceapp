import 'package:flutter/material.dart';
class PersonalCard extends StatelessWidget {
  final String title;
  final int amount;
  PersonalCard({this.title, this.amount});
  @override
  Widget build(BuildContext context) {
    return (Card(
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
              '₹$amount - $title',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Date: 23rd May 2020',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            //isThreeLine: true,
            trailing: IconButton(
              onPressed: (){},
              icon: Icon(
                Icons.delete_outline,
                size: 20,
                color: Colors.black,
              ),
            ),
            onTap: () {},
          ),
        ],
      ),
    ));
  }
}
