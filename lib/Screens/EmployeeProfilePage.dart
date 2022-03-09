import 'dart:convert';

import 'package:employee_details/Screens/NoDataPage.dart';
import 'package:employee_details/Screens/custom%20widgets/CheckInCard.dart';
import 'package:employee_details/Utils/EmployeeDetails.dart';
import 'package:employee_details/Utils/responsive_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'custom widgets/TextWidget.dart';

class EmployeeProfile extends StatefulWidget {
  @override
  State<EmployeeProfile> createState() => _EmployeeProfileState();
}

class _EmployeeProfileState extends State<EmployeeProfile> {
  Future<List<CheckIn>> getCheckInDetails() async {
    List<CheckIn> checkInDetails = [];
    EmployeeDetails details =
        Provider.of<EmployeeDetails>(context, listen: false);
    String currId = details.basicInfo.id;
    String url = "https://620dfdda20ac3a4eedcf5a52.mockapi.io/api/employee" +
        "/${currId}/checkin/";
    var apiResponse = await http.get(Uri.parse(url));
    var data;
    data = jsonDecode(apiResponse.body);
    for (var result in data) {
      CheckIn info = CheckIn(
          date: result['checkin'],
          location: result['location'],
          purpose: result['purpose'],
          employeeID: result['employeeId']);
      checkInDetails.add(info);
    }
    return checkInDetails;
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveTemplate(builder: (context, size) {
      return SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Scaffold(
            body: SafeArea(
              child: Consumer<EmployeeDetails>(
                builder: (context, curr, child) {
                  if (curr.hasDetails == true) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Employee Details",
                          style: TextStyle(
                            fontSize: size.height * 0.045,
                            fontWeight: FontWeight.w700,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CircleAvatar(
                          minRadius: size.height * 0.1,
                          backgroundImage: NetworkImage(curr.basicInfo.imgPath),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextWidget(
                              size: size,
                              leading: "Name",
                              data: curr.basicInfo.name,
                            ),
                            TextWidget(
                              size: size,
                              leading: "Id",
                              data: curr.basicInfo.id,
                            ),
                            TextWidget(
                              size: size,
                              leading: "E-mail",
                              data: curr.basicInfo.eMail,
                            ),
                            TextWidget(
                              size: size,
                              leading: "Mobile",
                              data: curr.basicInfo.number
                                  .split("x")[0]
                                  .replaceAll(".", "-"),
                            ),
                            TextWidget(
                              size: size,
                              leading: "Created at",
                              data:
                                  curr.FormatMyDate(curr.basicInfo.createTime),
                            ),
                            TextWidget(
                              size: size,
                              leading: "Birthday",
                              data: curr.FormatMyDate(curr.basicInfo.dob),
                            ),
                            TextWidget(
                              size: size,
                              leading: "Country",
                              data: curr.basicInfo.Country,
                            ),
                            TextWidget(
                              size: size,
                              leading: "Departments",
                              data: curr.basicInfo.departments
                                  .toString()
                                  .toUpperCase()
                                  .replaceAll(',', "  ")
                                  .replaceAll('[', "")
                                  .replaceAll(']', ""),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Checkin Details ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: size.height * 0.025,
                            color: Colors.blue,
                          ),
                        ),
                        Expanded(
                          child: FutureBuilder(
                            future: getCheckInDetails(),
                            builder: (context, AsyncSnapshot snapshot) {
                              Widget child;
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.data.length == 0) {
                                  child = Center(
                                    child: Text(
                                      "No records found.",
                                      style: TextStyle(
                                        fontSize: size.height * 0.03,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  );
                                } else {
                                  child = ListView.builder(
                                      itemCount: snapshot.data.length,
                                      physics: BouncingScrollPhysics(),
                                      itemBuilder: (context, idx) {
                                        return CheckInCard(
                                          checkInData: snapshot.data[idx],
                                          size: size,
                                        );
                                      });
                                }
                              } else {
                                child = Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return child;
                            },
                          ),
                        ),
                      ],
                    );
                  } else {
                    return NoDataFound();
                  }
                },
              ),
            ),
          ),
        ),
      );
    });
  }
}

class CheckIn {
  final String date;
  final String location;
  final String purpose;
  final String employeeID;
  CheckIn({
    required this.date,
    required this.location,
    required this.purpose,
    required this.employeeID,
  });
}
