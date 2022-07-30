import 'dart:io';

import 'package:Personal_Expenses_App/widgets/adaptive_widgets/adaptive_flat_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// We need this to be StatefulWidget so that when we type something into
// The overlay, it wouldnt automatically clears it.
class AddTransaction extends StatefulWidget {
  final Function _addNewTransaction;

  AddTransaction(this._addNewTransaction);

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _datePicked;

  void _submittedData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = _amountController.text.isNotEmpty
        ? double.parse(_amountController.text)
        : 0.00;

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _datePicked == null)
      return;
    // Gives us access to the variables in the super class
    widget._addNewTransaction(
      title: enteredTitle,
      amount: enteredAmount,
      date: _datePicked,
    ); // Add Transaction

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) return;

      setState(() {
        _datePicked = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // The single child scroll view is to allow the Card widget to move up when the keypad is on
    return SingleChildScrollView(
      child: Card(
        elevation: 3,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            // This will allow the bottom padding to be adjusted based on the keypad
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: "Title"),
                controller: _titleController,
                onSubmitted: (_) => _submittedData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: "Amount"),
                controller: _amountController,
                // keyboardType: TextInputType.number, since we need decimal on iOS we need the follwong:
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true,
                ),
                onSubmitted: (_) => _submittedData(),
              ),
              Container(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_datePicked == null
                        ? "No Date Chosen!"
                        : DateFormat.yMMMd().format(_datePicked)),
                    AdaptiveFlatButton(
                      buttonText: "Choose Date",
                      onPressFunction: _presentDatePicker,
                    )
                  ],
                ),
              ),
              RaisedButton(
                onPressed: _submittedData,
                child: Text(
                  "Add Transaction",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                color: Theme.of(context).accentColor,
                textColor: Theme.of(context).textTheme.button.color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
