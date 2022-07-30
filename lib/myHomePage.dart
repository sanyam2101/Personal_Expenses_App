import 'dart:io';

import 'package:flutter/material.dart';

import './models/transaction.dart';
import './widgets/addTransaction.dart';
import './widgets/adaptive_widgets/adaptive_scaffold.dart';

// Since we want to show an overlay window, then we need a new class with
// Its own context so that we can only use the body rather then the whole page
// Otherwise it wont show the overlay
// So whenever we need to have an overlay, then we must create a new class for it to be within
// Also it needs to be stateful widget
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // The list of transactions
  final List<Transaction> _transactions = [];

  // Adds a new transcation to the list of transactions
  void _addNewTransaction({String title, double amount, DateTime date}) {
    final newTrans = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amountSpent: amount,
      date: date,
    );

    // rebuild the widgets to reflect the addiction of the transaction
    setState(() {
      _transactions.add(newTrans);
    });
  }

  void _startAddNewTransactions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        // This will catch the tap within the overlay to not allow it to close automatically
        return GestureDetector(
          child: AddTransaction(_addNewTransaction),
          onTap: () {},
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return AdaptiveScaffold(
      mediaQuery: mediaQuery,
      deleteTransaction: _deleteTransaction,
      startAddNewTransactions: _startAddNewTransactions,
      transactions: _transactions,
    );
  }
}
