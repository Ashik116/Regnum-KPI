import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kpi_app/view/utils/background_admin.dart';
import 'package:kpi_app/view/utils/loading_animation.dart';

class AdminAssignTaskList extends StatefulWidget {
  const AdminAssignTaskList({Key? key}) : super(key: key);

  @override
  _AdminAssignTaskListState createState() => _AdminAssignTaskListState();
}

class _AdminAssignTaskListState extends State<AdminAssignTaskList> {
  List singleTaskList = [];
  List taskIDList = [];
  late bool isLoading;
  var user;
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
    Map<String, dynamic>? data = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    email = data!['email'];

    return  isLoading ? loadingAnimation() : BackgroundAdmin(
      header: 'Admin Task',
      floatingButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
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
            backgroundColor: Color.fromRGBO(39, 123, 74, 1), label: Text('Filter'),
          ),
        ],
      ),
      child:  Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: singleTaskList.length == 0 ?
              Center(
                child: Text('NO DATA FOUND'),
              ) : ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, "/task/details",
                            arguments: {
                              "taskID": taskIDList.elementAt(index),
                              "taskDetails": singleTaskList.elementAt(index),
                              'email': email,
                              'route': '/admin/taskEdit',
                            });
                      },
                      title: Text(singleTaskList.elementAt(index)['projectType']),
                      subtitle: Text(
                          singleTaskList.elementAt(index)['extraWorkName']),
                    ),
                  );
                },
                itemCount: singleTaskList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void taskList(bool isDate) {
    try {
      singleTaskList.clear();
      final CollectionReference extraTaskCollection = FirebaseFirestore.instance.collection('AdminTask');
      extraTaskCollection.get().then((value) {
        if (value.size > 0) {
          value.docs.forEach((element) {
            DateTime lowestDate = DateTime.now().subtract(Duration(days: 30));
            if (element.get('employeeEmail') == email) {
              DateTime startDate = DateTime.parse(element.get('startTime'));
              if (startDate.isAfter(lowestDate) && isDate == false) {
                singleTaskList.add(element.data());
                taskIDList.add(element.id);

              } else if (isDate) {
                if (startDate.isAfter(dateRange!.start) && startDate.isBefore(dateRange!.end)) {
                  singleTaskList.add(element.data());
                  taskIDList.add(element.id);
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
