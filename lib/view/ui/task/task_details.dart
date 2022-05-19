import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kpi_app/view/utils/background_all.dart';
import 'package:kpi_app/view/utils/loading_animation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen({Key? key}) : super(key: key);

  @override
  _TaskDetailsScreenState createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  var task;
  late String taskID;
  bool isLoading = true;
  late SharedPreferences sharedPreferences;
  String email = '';
  late String route;


  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? taskData = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    taskID = taskData!['taskID'];
    task = taskData['taskDetails'];
    email = taskData['email']!;
    route = taskData['route'];

    return Background(
      floatingButton: route.length < 2 ? null : FloatingActionButton.extended(
        onPressed: () async{
          sharedPreferences = await SharedPreferences.getInstance();
          await sharedPreferences.setString('oldProjectType', task['projectType'].toString());
          await sharedPreferences.setString('oldTaskCategory', task['taskCategory'].toString());
          await sharedPreferences.setString('oldExtraWorkName', task['extraWorkName'].toString());
          await sharedPreferences.setString('oldDescribeWork', task['describeWork'].toString());
          await sharedPreferences.setString('oldTaskType', task['taskType'].toString());
          await sharedPreferences.setString('oldStatus', task['status'].toString());
          await sharedPreferences.setString('oldStartDate', task['startTime'].toString());
          await sharedPreferences.setString('oldEndDate', task['endTime'].toString());
          await sharedPreferences.setString('oldTaskID', taskID);
          await sharedPreferences.setString('oldEmail', email);

          Navigator.of(context).pushNamed(route);
        },
        icon: const Icon(
          Icons.edit,
        ),
        backgroundColor: Color.fromRGBO(39,123,74, 1), label: Text('Edit'),
      ),
      header: 'Task Details',
      child: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 16, top: 15, right: 16,bottom: 30 ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: const Text(
                        'Project Type',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: Text(
                        '${task['projectType']}',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: const Text(
                        'Task Category',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: Text(
                        '${task['taskCategory']}',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                       // textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: const Text(
                        'Extra Work Name',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: Text(
                        '${task['extraWorkName']}',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                       // textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: const Text(
                        'Work Description',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: Text(
                        "${task['describeWork']}",
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                        //textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: const Text(
                        'Start Time',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: Text(
                        '${task['startTime']}',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: const Text(
                        'End Time',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: Text(
                        '${task['endTime']}',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: const Text(
                        'Status',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: Text(
                        '${task['status']}',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: const Text(
                        'Task Type',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: Text(
                        '${task['taskType']}',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
