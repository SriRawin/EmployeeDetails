import 'package:employee_details/Screens/EmployeeListPage.dart';
import 'package:employee_details/Screens/EmployeeProfilePage.dart';
import 'package:employee_details/Utils/EmployeeDetails.dart';
import 'package:employee_details/Utils/responsive_template.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> Screens = [
    EmployeeList(),
    EmployeeProfile(),
  ];
  @override
  Widget build(BuildContext context) {
    return ResponsiveTemplate(builder: (context, size) {
      return Consumer<EmployeeDetails>(
        builder: (context, curr, child) {
          EmployeeDetails idx = Provider.of<EmployeeDetails>(context);
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: IndexedStack(
                children: Screens,
                index: curr.currentIndex,
              ),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.shifting,
                backgroundColor: Colors.white,
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.blue.withOpacity(0.5),
                selectedIconTheme: IconThemeData(size: size.height * 0.04),
                selectedFontSize: size.height * 0.02,
                elevation: 4,
                currentIndex: curr.currentIndex,
                onTap: (index) {
                  idx.currentIndex = index;
                  idx.notifyListeners();
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.list_alt_outlined,
                    ),
                    label: 'Employee list',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person_outline,
                    ),
                    label: 'Employee Profile',
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
