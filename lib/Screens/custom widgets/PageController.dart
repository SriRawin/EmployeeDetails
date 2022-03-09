import 'package:employee_details/Utils/EmployeeDetails.dart';
import 'package:employee_details/Utils/responsive_template.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListViewPageController extends StatefulWidget {
  @override
  State<ListViewPageController> createState() => _ListViewPageControllerState();
}

class _ListViewPageControllerState extends State<ListViewPageController> {
  int totalUsers = 100;
  late TextEditingController textController;

  Future<String?> numOfPagesDialog(SizeInfo size) => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            "Items per page.",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: size.height * 0.03,
            ),
          ),
          content: TextField(
            controller: textController,
            cursorHeight: 20,
            decoration: InputDecoration(
              hintText: "Number of items per page.",
            ),
          ),
          actions: [
            MaterialButton(
              color: Colors.red,
              elevation: 3,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            MaterialButton(
              color: Colors.blue,
              elevation: 3,
              onPressed: () {
                Navigator.of(context).pop(textController.text);
              },
              child: Text(
                "Apply",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );

  @override
  void initState() {
    textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    EmployeeDetails _pagination = Provider.of<EmployeeDetails>(context);
    int curr_page = _pagination.page;
    int curr_limit = _pagination.limit;
    int noOfPages = (totalUsers / curr_limit).ceil().toInt();
    return ResponsiveTemplate(builder: (context, size) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.035,
          vertical: size.height * 0.008,
        ),
        child: Container(
          width: size.width,
          height: size.height * 0.05,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DirectionButton(
                icon: Icons.arrow_left_rounded,
                size: size,
                onClick: () {
                  if (curr_page > 1) {
                    curr_page -= 1;
                    _pagination.page = curr_page;
                    _pagination.notifyListeners();
                  }
                },
              ),
              GestureDetector(
                onTap: () async {
                  var newLimit = await numOfPagesDialog(size);
                  _pagination.limit = int.parse(newLimit!);
                  _pagination.page = 1;
                  _pagination.notifyListeners();
                },
                child: Container(
                  height: double.maxFinite,
                  width: size.width * 0.2,
                  child: Center(
                    child: Text(
                      " ${curr_page} / ${noOfPages} ",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Colors.blue,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
              DirectionButton(
                size: size,
                icon: Icons.arrow_right_rounded,
                onClick: () {
                  if (curr_page < noOfPages) {
                    curr_page += 1;
                    _pagination.page = curr_page;
                    _pagination.notifyListeners();
                  }
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}

class DirectionButton extends StatelessWidget {
  final IconData icon;
  final SizeInfo size;
  final VoidCallback onClick;
  DirectionButton({
    required this.size,
    required this.icon,
    required this.onClick,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        width: size.width * 0.1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Colors.blue,
            width: 1.5,
          ),
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.blue,
            size: size.height * 0.04,
          ),
        ),
      ),
    );
  }
}
