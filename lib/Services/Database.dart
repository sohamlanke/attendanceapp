import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

/*
* Notes:
* Always use '(..)'[Example-'(Advance)'] to specify some payment other than attendance else on delete record
* attendance will no be changed
*
* */

class DatabaseServices {
  //collection reference
  final CollectionReference names = Firestore.instance.collection("attendance");

  Future addHelperName(String name, [int amount = 0]) async {
    await Firestore.instance.collection('attendance').document(name).setData({
      'name': name,
      'last attendance': null,
      'total amount': amount,
    });

    if(amount!=0){
      await Firestore.instance.collection('attendance').document(name).collection('history').document().setData({
        'amount' : amount,
        'date': DateFormat.yMMMMd().format(DateTime.now())+' (Initial Balance)',
        'dateTimeStamp': DateTime.now(),
      });

    }
    getTotalHelperAmount();
  }

  //This same function is present in Helper_Page.dart because of some 'static' issue
  Future deleteHelperCard(String docId) async {
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

    await Firestore.instance.collection('attendance').document(docId).delete();
    getTotalHelperAmount();
  }
}

Future markPresent(String docId, int amount) async {
  await Firestore.instance
      .collection('attendance')
      .document(docId)
      .collection('history')
      .document(DateFormat.yMMMMd().format(DateTime.now()))
      .setData({
    'date': DateFormat.yMMMMd().format(DateTime.now()),
    'amount': amount,
    'dateTimeStamp': DateTime.now(),
  });

  await Firestore.instance.collection('attendance').document(docId).updateData({
    'last attendance': DateFormat.yMMMMd().format(DateTime.now()),
    'last amount': amount,
  });
  await updateTotalAmount(docId, amount);
  getTotalHelperAmount();
}

Future markAbsent(String docId) async {
  await Firestore.instance.collection('attendance').document(docId).updateData({
    'last attendance':
        ('No' + DateFormat.yMMMMd().format(DateTime.now()).toString()),
  });
  await Firestore.instance
      .collection('attendance')
      .document(docId)
      .collection('history')
      .document(DateFormat.yMMMMd().format(DateTime.now()))
      .delete();
}

Future updateTotalAmount(String docId, int amount) async {
  String totalAmt;
  await Firestore.instance
      .collection('attendance')
      .document(docId)
      .get()
      .then((DocumentSnapshot ds) {
    totalAmt = ds["total amount"].toString();
  });
  amount = amount + int.parse(totalAmt);

  await Firestore.instance.collection('attendance').document(docId).updateData({
    'total amount': amount,
  });
}

Future payAdvance(String docId, int amount) async {
  await Firestore.instance
      .collection('attendance')
      .document(docId)
      .collection('history')
      .document()
      .setData({
    'date':
        DateFormat.yMMMMd().format(DateTime.now()).toString() + ' (Advance)',
    'amount': amount,
    'dateTimeStamp': DateTime.now(),
  });
  updateTotalAmount(docId, amount);
  print('AAAdavanceddddd PAyyyyyyyedddddd $amount');
  getTotalHelperAmount();
}

Future clearTotalBalance(String docId) async {
  int amount;

  String totalAmt;
  await Firestore.instance
      .collection('attendance')
      .document(docId)
      .get()
      .then((DocumentSnapshot ds) {
    totalAmt = ds["total amount"].toString();
  });
  amount = int.parse(totalAmt);

  if (amount != 0) {
    await Firestore.instance
        .collection('attendance')
        .document(docId)
        .collection('history')
        .document()
        .setData({
      'date':
          DateFormat.yMMMMd().format(DateTime.now()).toString() + ' (Payment)',
      'amount': -amount,
      'dateTimeStamp': DateTime.now(),
    });
    updateTotalAmount(docId, -amount);
    getTotalHelperAmount();
  }
}

Future deleteRecord(String docId, String RdocId) async {
  int amount;
  String totalAmt;
  String attendanceCheck;
  await Firestore.instance
      .collection('attendance')
      .document(docId)
      .collection('history')
      .document(RdocId)
      .get()
      .then((DocumentSnapshot ds) {
    totalAmt = ds["amount"].toString();
    attendanceCheck = ds['date'].toString();
  });
  amount = int.parse(totalAmt);
  updateTotalAmount(docId, -amount); // Updating total balance

  await Firestore.instance
      .collection('attendance')
      .document(docId)
      .collection('history')
      .document(RdocId)
      .delete();                     // deleting record

  if (attendanceCheck.contains('(') == false) {   // if the deleted record was for attendance
    await Firestore.instance
        .collection('attendance')
        .document(docId)
        .updateData({
      'last attendance': 'pending',
    });
  }
  getTotalHelperAmount();
}

Future addManualRecord(String docId, int amount, DateTime date) async {

  await Firestore.instance.collection('attendance').document(docId).collection('history').document().setData({
    'amount' : amount,
    'date': DateFormat.yMMMMd().format(date).toString()+' (Manual Record)',
    'dateTimeStamp': date,
  });
  updateTotalAmount(docId, amount);
  getTotalHelperAmount();
}

Future getTotalHelperAmount() async{
  int amount=0;
  await Firestore.instance
      .collection('attendance')
      .getDocuments()
      .then((snapshot) {
    for (DocumentSnapshot doc in snapshot.documents) {
      amount = amount + doc['total amount'];
    }
  });
  await Firestore.instance.collection('Total Amount').document('total helper amount').setData({
    'amount': amount
  });

}