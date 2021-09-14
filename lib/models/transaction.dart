import 'package:flutter/foundation.dart';

class Transaction {
  final String id;
  final String thing;
  final double amount;
  final DateTime date;

  Transaction(
      {@required this.id,
      @required this.thing,
      @required this.amount,
      @required this.date});
}
