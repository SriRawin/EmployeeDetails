import 'package:employee_details/Utils/EmployeeDetails.dart';
import 'package:employee_details/Utils/responsive_template.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatefulWidget {
  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  TextStyle style = TextStyle(
      fontWeight: FontWeight.w600, color: Colors.black54, fontSize: 16);
  double iconSize = 26;
  SortOptions? _options = SortOptions.employeeId;
  SortTypes? _sortType = SortTypes.asc;
  FilterOptions? _filterOptions = FilterOptions.name;
  late TextEditingController _textController;

  //dialog box for sorting
  Future sortDialog() {
    EmployeeDetails sort = Provider.of<EmployeeDetails>(context, listen: false);
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: StatefulBuilder(builder: (context, setState) {
            return Row(
              children: [
                Text(
                  "Sorting options",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.blue,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _sortType = SortTypes.asc;
                    });
                  },
                  child: Icon(
                    Icons.keyboard_arrow_up,
                    size: iconSize,
                    color: _sortType == SortTypes.asc
                        ? Colors.blue
                        : Colors.black26,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_options != SortOptions.employeeId) {
                        _sortType = SortTypes.desc;
                      }
                    });
                  },
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    size: iconSize,
                    color: _sortType == SortTypes.desc
                        ? Colors.blue
                        : Colors.black26,
                  ),
                ),
              ],
            );
          }),
          content: StatefulBuilder(
            builder: ((context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text(
                      "Employee ID",
                      style: style,
                    ),
                    leading: Radio<SortOptions>(
                      value: SortOptions.employeeId,
                      groupValue: _options,
                      onChanged: (SortOptions? value) {
                        setState(() {
                          _options = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "ID",
                      style: style,
                    ),
                    leading: Radio<SortOptions>(
                      value: SortOptions.id,
                      groupValue: _options,
                      onChanged: (SortOptions? value) {
                        setState(() {
                          _options = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Name",
                      style: style,
                    ),
                    leading: Radio<SortOptions>(
                      value: SortOptions.name,
                      groupValue: _options,
                      onChanged: (SortOptions? value) {
                        setState(() {
                          _options = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Created at",
                      style: style,
                    ),
                    leading: Radio<SortOptions>(
                      value: SortOptions.createdAt,
                      groupValue: _options,
                      onChanged: (SortOptions? value) {
                        setState(() {
                          _options = value;
                        });
                      },
                    ),
                  ),
                ],
              );
            }),
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
                print(_sortType);
                sort.sortBy = _options.toString().split(".")[1];
                sort.order = _sortType.toString().split(".")[1];
                sort.notifyListeners();
                Navigator.pop(context);
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
        );
      },
    );
  }

  //dialog box for filtering
  Future filterDialog() {
    EmployeeDetails filter =
        Provider.of<EmployeeDetails>(context, listen: false);
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Filtering options",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.blue,
            ),
          ),
          content: StatefulBuilder(
            builder: ((context, setState) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: Text(
                        "Name",
                        style: style,
                      ),
                      leading: Radio<FilterOptions>(
                        value: FilterOptions.name,
                        groupValue: _filterOptions,
                        onChanged: (FilterOptions? value) {
                          setState(() {
                            _filterOptions = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Id",
                        style: style,
                      ),
                      leading: Radio<FilterOptions>(
                        value: FilterOptions.id,
                        groupValue: _filterOptions,
                        onChanged: (FilterOptions? value) {
                          setState(() {
                            _filterOptions = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Country",
                        style: style,
                      ),
                      leading: Radio<FilterOptions>(
                        value: FilterOptions.country,
                        groupValue: _filterOptions,
                        onChanged: (FilterOptions? value) {
                          setState(() {
                            _filterOptions = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Created at",
                        style: style,
                      ),
                      leading: Radio<FilterOptions>(
                        value: FilterOptions.createdAt,
                        groupValue: _filterOptions,
                        onChanged: (FilterOptions? value) {
                          setState(() {
                            _filterOptions = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Phone",
                        style: style,
                      ),
                      leading: Radio<FilterOptions>(
                        value: FilterOptions.phone,
                        groupValue: _filterOptions,
                        onChanged: (FilterOptions? value) {
                          setState(() {
                            _filterOptions = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "E-mail",
                        style: style,
                      ),
                      leading: Radio<FilterOptions>(
                        value: FilterOptions.email,
                        groupValue: _filterOptions,
                        onChanged: (FilterOptions? value) {
                          setState(
                            () {
                              _filterOptions = value;
                            },
                          );
                        },
                      ),
                    ),
                    TextField(
                      controller: _textController,
                      cursorHeight: 20,
                      decoration: InputDecoration(
                        hintText: "Search....",
                      ),
                    ),
                  ],
                ),
              );
            }),
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
                filter.searchParameter =
                    _filterOptions.toString().split(".")[1];
                filter.searchQuery = _textController.text;
                filter.notifyListeners();
                Navigator.pop(context);
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
        );
      },
    );
  }

  @override
  void initState() {
    _textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveTemplate(
      builder: (context, size) {
        return Padding(
          padding: EdgeInsets.only(
            left: size.width * 0.035,
            right: size.width * 0.035,
            top: size.height * 0.01,
          ),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HeaderTile(
                  size: size,
                  icon: Icons.sort_rounded,
                  title: "Sort",
                  onClick: () {
                    sortDialog();
                  },
                ),
                HeaderTile(
                  size: size,
                  icon: Icons.filter_alt_rounded,
                  title: "Filter",
                  onClick: () {
                    filterDialog();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class HeaderTile extends StatelessWidget {
  final SizeInfo size;
  final IconData icon;
  final String title;
  final VoidCallback onClick;
  HeaderTile({
    required this.size,
    required this.onClick,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onClick,
        child: Container(
          height: double.maxFinite,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blue,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.blue,
                size: size.height * 0.03,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                title,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                  fontSize: size.height * 0.024,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
