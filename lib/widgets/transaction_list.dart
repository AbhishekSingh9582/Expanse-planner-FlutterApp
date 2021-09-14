import 'package:flutter/material.dart';
import 'transaction_Item.dart';
import '../models/transaction.dart';
//import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> list;
  final Function deleteTx;
  TransactionList(this.list, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return list.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraint) {
              return Column(
                children: [
                  Text(
                    'Items not added yet! ',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: constraint.maxHeight * 0.6,
                    child: Image.asset('assets/Images/waiting.png',
                        fit: BoxFit.cover),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              return TransactionItem(
                  transaction: list[index], deleteTx: deleteTx);
              // return Card(
              //   elevation: 10,
              //   child: Row(
              //     children: [
              //       Container(
              //         margin:
              //             EdgeInsets.symmetric(vertical: 7, horizontal: 3),
              //         decoration: BoxDecoration(
              //           border:
              //               Border.all(color: Colors.orange[500], width: 2),
              //           color: Colors.orange[200],
              //         ),
              //         alignment: Alignment.center,

              //         height: 60,
              //         // color: Colors.orange, Either color can be in container or BoxDecoration.
              //         child: Text(
              //           '\$${list[index].amount}',
              //           overflow: TextOverflow.clip,
              //           style: TextStyle(
              //               fontWeight: FontWeight.bold, fontSize: 20),
              //         ),
              //       ),
              //       Flexible(
              //         fit: FlexFit.tight,
              //         child: Container(
              //           width: 250,
              //           height: 70,
              //           //alignment: Alignment.center,
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Text(list[index].thing,
              //                   style: Theme.of(context).textTheme.headline6),
              //               Text(
              //                 DateFormat.yMMMd().format(list[index].date),
              //                 style: TextStyle(fontSize: 20),
              //               ),
              //             ],
              //           ),
              //         ),
              //       )
              //     ],
              //   ),
              // );
            },
            itemCount: list.length,
          );
  }
}
