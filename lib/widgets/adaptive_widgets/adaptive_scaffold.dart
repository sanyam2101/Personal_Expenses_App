import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../models/transaction.dart';
import '../transactionList.dart';
import '../chart.dart';

class AdaptiveScaffold extends StatelessWidget {
  final Function startAddNewTransactions;
  final Function deleteTransaction;
  final List<Transaction> transactions;
  final MediaQueryData mediaQuery;

  AdaptiveScaffold({
    this.startAddNewTransactions,
    this.deleteTransaction,
    this.transactions,
    this.mediaQuery,
  });

  List<Transaction> get _recentTransactions {
    // Gives only elements where a certain condition is met
    return transactions.where((element) {
      // Return the elements that their date is after today - 7 days.
      // i.e. if today was monday gives any element that was made after last monday
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final androidAppBar = AppBar(
      title: Text(
        "My Personal Expenses",
        textAlign: TextAlign.center,
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            startAddNewTransactions(context);
          },
        ),
      ],
    );
    final PreferredSizeWidget iosAppBar = CupertinoNavigationBar(
      middle: Text(
        "My Personal Expenses",
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            child: Icon(
              CupertinoIcons.add,
              color: Theme.of(context).accentColor,
            ),
            onTap: () => startAddNewTransactions,
          )
        ],
      ),
    );

    return Platform.isAndroid
        ? Scaffold(
            appBar: androidAppBar,
            body: Column(
              children: [
                Container(
                  height: (mediaQuery.size.height -
                          androidAppBar.preferredSize.height -
                          mediaQuery.padding.top) *
                      0.3,
                  child: Chart(_recentTransactions),
                ),
                Container(
                    height: (mediaQuery.size.height -
                            androidAppBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.7,
                    child: TransactionList(transactions, deleteTransaction)),
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                startAddNewTransactions(context);
              },
            ),
          )
        : CupertinoPageScaffold(
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    height: (mediaQuery.size.height -
                            androidAppBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.3,
                    child: Chart(_recentTransactions),
                  ),
                  Container(
                      height: (mediaQuery.size.height -
                              androidAppBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.7,
                      child: TransactionList(transactions, deleteTransaction)),
                ],
              ),
            ),
            navigationBar: iosAppBar,
          );
  }
}
