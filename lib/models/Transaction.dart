import 'package:flutter/foundation.dart';

class Transaction {
  String id;
  double amount;
  String title;
  DateTime dateTime;
  Transaction(
      {@required this.id,
      @required this.title,
      @required this.amount,
      @required this.dateTime});
}
