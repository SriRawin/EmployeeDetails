import 'package:employee_details/Screens/homePage.dart';
import 'package:employee_details/Utils/EmployeeDetails.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee Details',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Montserrat"),
      home: ChangeNotifierProvider.value(
        value: EmployeeDetails(),
        child: HomePage(),
      ),
    );
  }
}
