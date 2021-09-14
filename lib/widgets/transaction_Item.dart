import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 2),
      elevation: 6,
      child: ListTile(
        isThreeLine: false,
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: FittedBox(
              child: Text('\$${transaction.amount}'),
            ),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        title: Text(transaction.thing,
            style: Theme.of(context).textTheme.headline6),
        subtitle: Text(
          DateFormat.yMMMd().format(transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 460
            ? FlatButton.icon(
                icon: const Icon(Icons.delete),
                label: const Text('Delete'),
                textColor: Theme.of(context).primaryColor,
                onPressed: () {
                  deleteTx(transaction.id);
                },
              )
            : IconButton(
                icon: Icon(Icons.delete, color: Theme.of(context).errorColor),
                onPressed: () {
                  deleteTx(transaction.id);
                },
              ),
      ),
    );
  }
}
