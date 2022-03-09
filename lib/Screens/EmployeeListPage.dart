import 'dart:convert';

import 'package:employee_details/Screens/custom%20widgets/MyAppBar.dart';
import 'package:employee_details/Screens/custom%20widgets/PageController.dart';
import 'package:employee_details/Utils/EmployeeDetails.dart';
import 'package:employee_details/Utils/responsive_template.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'custom widgets/ListCard.dart';

class EmployeeList extends StatefulWidget {
  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  Future<List<EmployeeInfo>> getDetails() async {
    List<EmployeeInfo> employeeList = [];
    EmployeeDetails url = Provider.of<EmployeeDetails>(context);
    int page = url.page;
    int limit = url.limit;
    String sortOption = url.sortBy;
    String orderOption = url.order;
    String searchOption = url.searchParameter;
    String searchFor = url.searchQuery;
    String base =
        "https://620dfdda20ac3a4eedcf5a52.mockapi.io/api/employee?page=${page}&limit=${limit}&sortBy=${sortOption}&order=${orderOption}&${searchOption}=${searchFor}";
    var apiResponse = await http.get(Uri.parse(base));

    var data;
    data = jsonDecode(apiResponse.body);
    for (var result in data) {
      EmployeeInfo info = EmployeeInfo(
          name: result['name'],
          eMail: result['email'],
          imgPath: result['avatar'],
          createTime: result['createdAt'],
          number: result['phone'],
          departments: result['department'],
          dob: result['birthday'],
          Country: result['country'],
          id: result['id']);
      employeeList.add(info);
    }
    return employeeList;
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveTemplate(builder: (context, size) {
      return SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(size.height * 0.07),
            child: MyAppBar(),
          ),
          body: FutureBuilder(
            future: getDetails(),
            builder: (context, AsyncSnapshot snapshot) {
              Widget child;
              if (snapshot.connectionState == ConnectionState.done) {
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
                    itemCount: snapshot.data.length + 1,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, idx) {
                      EmployeeDetails curr =
                          Provider.of<EmployeeDetails>(context);
                      Widget listViewChild;

                      if (idx == snapshot.data.length) {
                        listViewChild = ListViewPageController();
                      } else {
                        listViewChild = ListCard(
                          info: snapshot.data[idx],
                          onClick: () {
                            curr.currentIndex = 1;
                            curr.basicInfo = snapshot.data[idx];
                            curr.hasDetails = true;
                            curr.notifyListeners();
                          },
                        );
                      }
                      return listViewChild;
                    },
                  );
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
      );
    });
  }
}

class EmployeeInfo {
  final String name;
  final String eMail;
  final String imgPath;
  final String createTime;
  final String number;
  final List<dynamic> departments;
  final String dob;
  final String Country;
  final String id;

  EmployeeInfo(
      {required this.name,
      required this.eMail,
      required this.imgPath,
      required this.createTime,
      required this.number,
      required this.departments,
      required this.dob,
      required this.Country,
      required this.id});
}
