import 'package:flutter/material.dart';

class NoDataFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: Image.asset(
              "images/warning.png",
              color: Colors.grey.shade300,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Click any employee in the list to get details.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              color: Colors.grey.shade300,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
