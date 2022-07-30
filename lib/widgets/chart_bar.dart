import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPerctOfTotal;

  ChartBar({
    this.label,
    this.spendingAmount,
    this.spendingPerctOfTotal,
  });

  @override
  Widget build(BuildContext context) {
    // Builds a layout and giving you the contraints of the lay out
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: [
            Container(
              height: constraints.maxHeight * 0.15,
              child: Icon(
                Icons.attach_money,
                color: Theme.of(context).primaryColor,
              ),
            ),
            // Forces the child into its valiable space, if its a text it will shrink the text
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text("\$${spendingAmount.toStringAsFixed(0)}"),
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            Container(
              height: constraints.maxHeight * 0.5,
              width: 10,
              // Stack will stack widget ontop of each other, the first being at the bottom
              child: Stack(
                children: [
                  // Background container
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  // This will make a box with a size that has a certain fraction of its parent widget size
                  // from 0 - 1, 1 being completely equal to the parent size
                  FractionallySizedBox(
                    heightFactor: spendingPerctOfTotal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  )
                ],
                alignment: Alignment.bottomCenter,
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            Container(
              height: constraints.maxHeight * 0.1,
              child: FittedBox(
                child: Text(label),
              ),
            ),
          ],
        );
      },
    );
  }
}
