import 'package:flutter/material.dart';

import './transactionCard.dart';
import './noTransactions.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // Much more performant then ListView
      // it loads every item lazy which means when ever it needs it.
      // YOU MUST PROVIDE "height"
      child: transactions.isEmpty
          ? NoTransactions()
          : ListView.builder(
              // if the list is empty then display something other then a list
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                return TransactionCard(
                  transactions[index],
                  deleteTransaction,
                );
              },
            ),
    );
  }
}
