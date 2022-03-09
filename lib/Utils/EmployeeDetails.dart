import 'package:employee_details/Screens/EmployeeListPage.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

//enums for sorting
enum SortOptions { name, id, employeeId, createdAt }
enum SortTypes { asc, desc }

//enums for filtering
enum FilterOptions { id, name, country, phone, email, createdAt }

class EmployeeDetails extends ChangeNotifier {
  // Employee page
  bool hasDetails = false;
  // For BottomNavigation bar
  int currentIndex = 0;

  //Employee object model
  late EmployeeInfo basicInfo;

  //Pagination Details
  int page = 1;
  int limit = 10;

  //Sort
  String sortBy = "employeeId";
  String order = "asc";

  //Search or Filtering
  String searchParameter = "";
  String searchQuery = "";

  // For formatting date and time through out the app
  String FormatMyDate(String date) {
    List utcFormat = date.split("T");
    String UtcDate = utcFormat[0];
    String UtcTime = utcFormat[1].toString().replaceAll('Z', "");
    date = UtcDate + " " + UtcTime;
    var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(date, true);
    var dateLocal = dateTime.toLocal().toString();
    DateTime now = DateTime.parse(dateLocal);
    String myDate =
        DateFormat.yMd().format(now).replaceAll("/", "-").toString();
    String myTime = DateFormat.jm().format(now).toString();
    return myDate + "  " + myTime;
  }
}
