import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kpi_app/view/utils/background_all.dart';
import 'package:kpi_app/view/utils/loading_animation.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class ExtraTaskList extends StatefulWidget {
  const ExtraTaskList({Key? key}) : super(key: key);

  @override
  State<ExtraTaskList> createState() => _ExtraTaskListState();
}

class _ExtraTaskListState extends State<ExtraTaskList> {
  List extraTask = [];
  List extraTaskIDList = [];
  List serial = [];
  var user;
  late FirebaseAuth auth;
  bool isLoading = true;
  String email = '';

  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;
    checkExtraData();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? loadingAnimation()
        : Background(
            header: 'All Tasks',
            floatingButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/extra/task/create");
              },
              child: const Icon(
                Icons.add,
              ),
              backgroundColor: Color.fromRGBO(39, 123, 74, 1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SafeArea(
                child: extraTask.length == 0
                    ? Center(
                        child: Text('NO TASK FOUND'),
                      )
                    : Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return Card(
                                  elevation: 5,
                                  margin: EdgeInsets.all(8),
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, "/task/details",
                                          arguments: {
                                            "taskID": extraTaskIDList
                                                .elementAt(index),
                                            "taskDetails":
                                                extraTask.elementAt(index),
                                            'email': email,
                                            'route': '/task/edit',
                                          });
                                    },
                                    title: Text(extraTask
                                        .elementAt(index)['projectType']),
                                    subtitle: Text(extraTask.elementAt(
                                        index)['extraWorkName']), //startTime
                                    tileColor: Colors.grey.shade200,
                                  ),
                                );
                              },
                              itemCount: extraTask.length,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          );
  }

  void checkExtraData() {
    try {
      extraTask.clear();
      final CollectionReference extraTaskCollection =
          FirebaseFirestore.instance.collection('ExtraTaskInfo');

      extraTaskCollection.orderBy('startTime').get().then((value) {
        if (value.size > 0) {
          value.docs.forEach((element) {
            if (element.get('employeeEmail') == auth.currentUser!.email) {
              email = element.get('startTime');
              extraTask.add(element.data());
              extraTaskIDList.add(element.id);
            } else {
              setState(() {
                isLoading = false;
              });
            }
          });

          setState(() {
            isLoading = false;
          });
        }
      });
    } catch (e) {
      print(e.toString());
      setState(() {
        isLoading = false;
      });
    }
  }

  void showToast(String message, Color colors) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: colors,
        textColor: Colors.black,
        fontSize: 16.0);
  }
}
