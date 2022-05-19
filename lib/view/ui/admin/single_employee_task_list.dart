import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kpi_app/models/graph_model.dart';
import 'package:kpi_app/view/utils/background_admin.dart';
import 'package:kpi_app/view/utils/loading_animation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SingleEmployeeTaskList extends StatefulWidget {
  @override
  _SingleEmployeeTaskListState createState() => _SingleEmployeeTaskListState();
}

class _SingleEmployeeTaskListState extends State<SingleEmployeeTaskList> {
  List singleTaskList = [];
  List taskIDList = [];
  List<GraphModel> graphData = <GraphModel>[];
  late bool isLoading;
  var user;
  var userEmail;
  late FirebaseAuth auth;
  late String email;
  DateTimeRange? dateRange;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    auth = FirebaseAuth.instance;
    taskList(false);
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    email = data!['email'];

    return isLoading
        ? loadingAnimation()
        : BackgroundAdmin(
            header: 'Employee Task',
            floatingButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 21,
                          ),
                          FloatingActionButton.extended(
                            onPressed: () async {
                              Navigator.pushNamed(context, "/admin/taskAssign",
                                  arguments: {
                                    "email": userEmail = data['email']
                                  });
                            },
                            icon: const Icon(
                              Icons.add_outlined,
                            ),
                            backgroundColor: Color.fromRGBO(39, 123, 74, 1),
                            label: Text('Assign Task'),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          FloatingActionButton.extended(
                            onPressed: () async {
                              await showDateRangePicker(
                                context: context,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2050),
                                currentDate: DateTime.now(),
                              ).then((value) {
                                dateRange = value;
                                taskList(true);
                              });
                            },
                            icon: const Icon(
                              Icons.date_range_rounded,
                            ),
                            backgroundColor: Color.fromRGBO(39, 123, 74, 1),
                            label: Text('Filter'),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          FloatingActionButton.extended(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, "/admin/performanceGraph",
                                  arguments: {
                                    "graphData": graphData,
                                  });
                            },
                            icon: const Icon(
                              Icons.insert_chart_outlined_rounded,
                            ),
                            backgroundColor: Color.fromRGBO(39, 123, 74, 1),
                            label: Text('Chart'),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 21,
                          ),
                          FloatingActionButton.extended(
                            onPressed: () async {
                              Navigator.pushNamed(
                                  context, "/admin/assignedTaskList",
                                  arguments: {
                                    "email": userEmail = data['email']
                                  });
                            },
                            icon: const Icon(
                              Icons.list_alt,
                            ),
                            backgroundColor: Color.fromRGBO(39, 123, 74, 1),
                            label: Text('Admin Tasks'),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          FloatingActionButton.extended(
                            onPressed: () async {
                              Navigator.pushNamed(
                                  context, "/employee/details/admin",
                                  arguments: {
                                    "email": userEmail = data['email']
                                  });
                            },
                            icon: const Icon(
                              Icons.face,
                            ),
                            backgroundColor: Color.fromRGBO(39, 123, 74, 1),
                            label: Text('Profile'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: singleTaskList.length == 0
                          ? Center(
                              child: Text('NO DATA FOUND'),
                            )
                          : ListView.builder(
                              itemBuilder: (context, index) {
                                return Card(
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, "/task/details",
                                          arguments: {
                                            "taskID":
                                                taskIDList.elementAt(index),
                                            "taskDetails":
                                                singleTaskList.elementAt(index),
                                            'email': email,
                                            'route': '/admin/employeeTaskEdit',
                                          });
                                    },
                                    title: Text(singleTaskList
                                        .elementAt(index)['projectType']),
                                    subtitle: Text(singleTaskList
                                        .elementAt(index)['extraWorkName']),
                                  ),
                                );
                              },
                              itemCount: singleTaskList.length,
                            ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  void taskList(bool isDate) {
    try {
      SharedPreferences.getInstance().then((value) {
        value.setBool('isEmployeeTask', true);
      });

      singleTaskList.clear();
      graphData.clear();
      final CollectionReference extraTaskCollection =
          FirebaseFirestore.instance.collection('ExtraTaskInfo');
      extraTaskCollection.get().then((value) {
        if (value.size > 0) {
          value.docs.forEach((element) {
            DateTime lowestDate = DateTime.now().subtract(Duration(days: 30));
            if (element.get('employeeEmail') == email) {
              DateTime startDate = DateTime.parse(element.get('startTime'));
              if (startDate.isAfter(lowestDate) && isDate == false) {
                singleTaskList.add(element.data());
                taskIDList.add(element.id);
                DateTime dateTime = DateTime(
                    DateTime.parse(element.get('startTime')).year,
                    DateTime.parse(element.get('startTime')).month,
                    DateTime.parse(element.get('startTime')).day);
                bool found = false;
                for (GraphModel i in graphData) {
                  if (i.date.toString() == dateTime.toString()) {
                    i.value = i.value + 1;
                    found = true;
                    break;
                  }
                }

                if (found == false) {
                  graphData
                      .add(GraphModel(date: dateTime.toString(), value: 1));
                }
              } else if (isDate) {
                if (startDate.isAfter(dateRange!.start) &&
                    startDate.isBefore(dateRange!.end)) {
                  singleTaskList.add(element.data());
                  taskIDList.add(element.id);

                  DateTime dateTime = DateTime(
                      DateTime.parse(element.get('startTime')).year,
                      DateTime.parse(element.get('startTime')).month,
                      DateTime.parse(element.get('startTime')).day);
                  bool found = false;
                  for (GraphModel i in graphData) {
                    if (i.date.toString() == dateTime.toString()) {
                      i.value = i.value + 1;
                      found = true;
                      break;
                    }
                  }

                  if (found == false) {
                    graphData
                        .add(GraphModel(date: dateTime.toString(), value: 1));
                  }
                }
              }
            }
          });
          setState(() {
            isLoading = false;
          });
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
