import 'package:flutter/material.dart';

class NoTransactions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Container of text to give me margin
        Container(
          child: Opacity(
            opacity: 0.75,
            child: Text(
              "No Transactions Added Yet!",
              style: TextStyle(
                fontFamily: "OpenSans",
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          margin: EdgeInsets.fromLTRB(8, 8, 8, 20),
        ),

        // Container of an image to give me a certain height
        Container(
          child: Opacity(
            opacity: 0.25,
            child: Image.asset(
              "assets/images/waiting.png",
              fit: BoxFit.fill,
            ),
          ),
          height: 200,
        ),
      ],
    );
  }
}
