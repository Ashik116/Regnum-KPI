import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kpi_app/view/utils/background_all.dart';
import 'package:kpi_app/view/utils/loading_animation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminTaskList extends StatefulWidget {

  @override
  _AdminTaskListState createState() => _AdminTaskListState();
}

class _AdminTaskListState extends State<AdminTaskList> {
  List adminTask = [];
  List adminTaskIDList = [];
  var user;
  late FirebaseAuth auth;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;
    getAdminData();
  }


  @override
  Widget build(BuildContext context) {
    return isLoading ? loadingAnimation() : Background(
      header: 'Admin Tasks',
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
          child: adminTask.length == 0 ? Center(child: Text('NO TASK FOUND'),) : Column(
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
                          Navigator.pushNamed(context, "/task/details",
                              arguments: {
                                "taskID": adminTaskIDList.elementAt(index),
                                "taskDetails": adminTask.elementAt(index),
                                'email': '',
                                'route': '',
                              });},
                        title: Text(adminTask.elementAt(index)['projectType']),
                        subtitle: Text(
                            adminTask.elementAt(index)['taskCategory']),
                        tileColor: Colors.grey.shade200,
                      ),
                    );},
                  itemCount: adminTask.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getAdminData() {
    try {
      adminTask.clear();
      final CollectionReference extraTaskCollection = FirebaseFirestore.instance.collection('AdminTask');

      extraTaskCollection.get().then((value) {
        if (value.size > 0) {
          value.docs.forEach((element) {
            if (element.get('employeeEmail') == auth.currentUser!.email) {
              adminTask.add(element.data());
              adminTaskIDList.add(element.id);
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
}
