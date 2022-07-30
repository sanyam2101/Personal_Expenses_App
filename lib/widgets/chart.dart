import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './chart_bar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupTransactionValues {
    return List.generate(
      7,
      (index) {
        // Getting the weekday minus the index as a day
        // This will give us index days passed
        final weekDay = DateTime.now().subtract(Duration(days: index));
        double totalSum = 0;
        for (int i = 0; i < recentTransactions.length; i++) {
          if (recentTransactions[i].date.day == weekDay.day &&
              recentTransactions[i].date.month == weekDay.month &&
              recentTransactions[i].date.year == weekDay.year) {
            totalSum += recentTransactions[i].amountSpent;
          }
        }
        print(DateFormat.E().format(weekDay));
        print(totalSum);
        return {
          "day": DateFormat.E().format(weekDay).substring(0, 1),
          "amount": totalSum,
        };
      },
    ).reversed.toList();
  }

  double get totalSpending {
    return groupTransactionValues.fold(0.0, (sum, item) {
      return sum + item["amount"];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: groupTransactionValues.map((e) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: e["day"],
                spendingAmount: e["amount"],
                spendingPerctOfTotal: totalSpending == 0.0
                    ? 0.0
                    : (e["amount"] as double) / totalSpending,
              ),
            );
          }).toList(),
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
      ),
    );
  }
}
