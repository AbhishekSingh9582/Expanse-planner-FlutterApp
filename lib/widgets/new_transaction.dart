import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import './transaction_list.dart';

class NewTransaction extends StatefulWidget {
  final Function _addNewTransaction;
  NewTransaction(this._addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();
  DateTime _chosenDate;

  void submitData() {
    if (_amountController.text.isEmpty) return;
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount < 0 || _chosenDate == null)
      return;
    widget._addNewTransaction(
      enteredTitle,
      enteredAmount,
      _chosenDate,
    );

    Navigator.of(context).pop();
  }

  void _selectedDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      setState(() {
        if (pickedDate == null) return;
        _chosenDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'TITLE'),

                // onChanged: (val) {
                //   titleInput = val;
                //   print("first text field : $val");
                // },
                controller: _titleController,
                style: TextStyle(decorationStyle: TextDecorationStyle.wavy),
                onSubmitted: (_) => submitData(),
              ),
              TextField(
                  decoration: InputDecoration(labelText: 'AMOUNT'),
                  autocorrect: false,
                  keyboardType: TextInputType.number,
                  // onChanged: (val) => amountInput = val,  onChanged is another way to store user input into variable
                  controller: _amountController,
                  onSubmitted: (_) {
                    submitData();
                  }),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(_chosenDate == null
                        ? 'No Date chosen Yet!'
                        : 'Picked Date ${DateFormat.yMd().format(_chosenDate)}'),
                  ),
                  FlatButton(
                    child: Text('Choose Date',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        )),
                    onPressed: _selectedDate,
                  ),
                ],
              ),
              RaisedButton(
                child: const Text('Add Transaction'),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).buttonColor,
                onPressed: submitData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
