import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kpi_app/view/utils/background_admin.dart';
import 'package:kpi_app/view/utils/loading_animation.dart';

class EmployeeList extends StatefulWidget {
  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

//ITs ok***


class _EmployeeListState extends State<EmployeeList> {
  List employeeList = [];
  var user;
  late FirebaseAuth auth;
  late bool isLoading;
  late final String email;

  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;
    isLoading = true;
    allEmployee();
  }

  @override
  Widget build(BuildContext context) {
    return  isLoading ? loadingAnimation() :  BackgroundAdmin(
      header: 'All Employee',
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    margin: EdgeInsets.all(5),
                    child: ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, "/single/task/list",
                            arguments: {
                              "email": employeeList.elementAt(index)['email']
                            });
                      },
                      title: Text(employeeList.elementAt(index)['fullName']),
                      subtitle:
                          Text(employeeList.elementAt(index)['designation']),
                      trailing: Icon(Icons.account_circle_rounded),
                    ),
                  );
                },
                itemCount: employeeList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void allEmployee() {
    try {
      employeeList.clear();
      final CollectionReference employeeCollection =
          FirebaseFirestore.instance.collection('UserInfo');
      employeeCollection.get().then((value) {
        if (value.size > 0) {
          value.docs.forEach((element) {
            employeeList.add(element.data());
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
