import 'package:employee_details/Screens/EmployeeProfilePage.dart';
import 'package:employee_details/Screens/custom%20widgets/TextWidget.dart';
import 'package:employee_details/Utils/EmployeeDetails.dart';
import 'package:employee_details/Utils/responsive_template.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckInCard extends StatelessWidget {
  final CheckIn checkInData;
  final SizeInfo size;
  CheckInCard({required this.checkInData, required this.size});
  @override
  Widget build(BuildContext context) {
    double _dataFontSize = size.height * 0.018;
    double _leadingFontSize = size.height * 0.02;
    EmployeeDetails _info = Provider.of<EmployeeDetails>(context);
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: size.height * 0.01,
      ),
      padding: EdgeInsets.only(
        top: size.height * 0.01,
        bottom: size.height * 0.01,
        left: size.width * 0.02,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.blueAccent,
          )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextWidget(
            size: size,
            leading: "Employee ID",
            data: checkInData.employeeID,
            dataFontSize: _dataFontSize,
            leadingFontSize: _leadingFontSize,
          ),
          TextWidget(
            size: size,
            leading: "Date",
            data: _info.FormatMyDate(checkInData.date),
            dataFontSize: _dataFontSize,
            leadingFontSize: _leadingFontSize,
          ),
          TextWidget(
            size: size,
            leading: "Location",
            data: checkInData.location,
            dataFontSize: _dataFontSize,
            leadingFontSize: _leadingFontSize,
          ),
          TextWidget(
            size: size,
            leading: "Purpose",
            data: checkInData.purpose,
            dataFontSize: _dataFontSize,
            leadingFontSize: _leadingFontSize,
          ),
        ],
      ),
    );
  }
}
