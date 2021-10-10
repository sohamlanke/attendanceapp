import 'package:flutter/material.dart';

class Invoice extends StatefulWidget {
  @override
  _InvoiceState createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keshav Industries'),
        backgroundColor: Colors.lightGreen,
      ),
      body: Text('Invoice'),
    );
  }
}
