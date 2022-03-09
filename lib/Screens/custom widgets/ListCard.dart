import 'package:employee_details/Screens/EmployeeListPage.dart';
import 'package:employee_details/Utils/responsive_template.dart';
import 'package:flutter/material.dart';

class ListCard extends StatelessWidget {
  final EmployeeInfo info;
  final VoidCallback onClick;
  ListCard({
    required this.info,
    required this.onClick,
  });
  @override
  Widget build(BuildContext context) {
    return ResponsiveTemplate(builder: (context, size) {
      return GestureDetector(
        onTap: onClick,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.025,
            vertical: size.height * 0.002,
          ),
          child: Card(
            elevation: 4,
            shadowColor: Colors.grey.shade50,
            shape: Border.all(
              color: Colors.black12,
            ),
            child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05,
                  vertical: size.height * 0.015,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      info.id,
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: size.height * 0.03,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      info.name,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: size.height * 0.025,
                      ),
                    ),
                  ],
                )),
          ),
        ),
      );
    });
  }
}
