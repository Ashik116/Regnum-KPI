import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kpi_app/config/constants.dart';
import 'package:kpi_app/models/admin_task_model.dart';
import 'package:kpi_app/view/utils/background_all.dart';
import 'package:kpi_app/view/utils/round_button.dart';

class AssignTask extends StatefulWidget {

  @override
  _AssignTaskState createState() => _AssignTaskState();
}

class _AssignTaskState extends State<AssignTask> {
  String _projectType = "";
  String _taskCategory = "";
  String _workName = "";
  String _description = "";
  String _taskType = "";
  String _status = "";
  String _employeeEmail = "";
  String _startTime = DateTime.now().toString();

  int ashik=0;

  List<String> _project=[];
  List <String> _task=[];

  final workNameController = TextEditingController();
  final descriptionController = TextEditingController();

  fetchproject()async{
    var _fireStoreInstance= FirebaseFirestore.instance;
    QuerySnapshot qn= await _fireStoreInstance.collection("Project_Type").get();
    setState(() {
      for(int i = 0;i<qn.docs.length;i++){
        ashik=qn.docs.length;
        print("$ashik");
        _project.add(qn.docs[i]["Project-Name"]);



      }
    });
    return qn.docs;
  }
  fetchtask()async{
    var _fireStoreInstance= FirebaseFirestore.instance;
    QuerySnapshot qn= await _fireStoreInstance.collection("Task_Type").get();
    setState(() {
      for(int i = 0;i<qn.docs.length;i++){
        _task.add(qn.docs[i]["Task-Name"]);
      }
    });
    return qn.docs;
  }
  @override
  void initState() {
    super.initState();
    fetchproject();
    fetchtask();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Map<String, dynamic>? data = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    _employeeEmail = data!['email'];

    return Background(
      header: 'Admin Task Assign',
      child: SafeArea(
        child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: size.height * .002,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Column(
                    children: [
                      Container(
                        width: size.width * 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            DropdownSearch<String>(
                              mode: Mode.MENU,
                              items: _project,
                              dropdownSearchDecoration: InputDecoration(
                                labelText: "Project Type",
                                hintText: "Select Your Project",
                              ),
                              onChanged: (value) {
                                _projectType = value.toString();
                              },
                              // selectedItem: "Tender"
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            DropdownSearch<String>(
                              mode: Mode.MENU,
                              items: _task,
                              dropdownSearchDecoration: InputDecoration(
                                labelText: "Task Category List",
                                hintText: "Select Your Task",
                              ),
                              onChanged: (value) {
                                _taskCategory = value.toString();
                              },
                              //selectedItem: "Tender"
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            TextField(
                              controller: workNameController,
                              decoration: InputDecoration(
                                labelText: "Task Name",
                                suffixIcon: Icon(
                                  Icons.task,
                                  color: Colors.lightGreen.shade500,
                                ),
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black)),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            TextField(
                              maxLines: 8,
                              controller: descriptionController,
                              decoration: InputDecoration(
                                labelText: "Task Details",
                                suffixIcon: Icon(
                                  Icons.task_alt_outlined,
                                  color: Colors.lightGreen.shade500,
                                ),
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black)),
                              ),
                            ),
                            SizedBox(
                              height: size.height * .01,
                            ),
                            DropdownSearch<String>(
                              mode: Mode.MENU,
                              items: const ["Daily", "Weekly", "Monthly"],
                              label: "Task Type",
                              hint: "Select Type ",
                              onChanged: (value) {
                                _taskType = value.toString();
                              },
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            DropdownSearch<String>(
                              mode: Mode.MENU,
                              items: const ["Pending", "Complete", "Cancel"],
                              label: "Status",
                              hint: "Select Your Work Status",
                              onChanged: (value) {
                                _status = value.toString();
                              },
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            RoundedButton(
                              text: "Save",
                              color: Colors.greenAccent.shade100,
                              textColor: Colors.black,
                              onPressed: () {
                                _workName = workNameController.value.text.toString();
                                _description = descriptionController.value.text.toString();
                                if (_description != null &&
                                    _workName != null &&
                                    _projectType != null &&
                                    _taskCategory != null &&
                                    _taskType != null &&
                                    _status != null &&
                                    _startTime != null
                                ) {
                                  var extraTask = AdminTaskModel(
                                    projectType: _projectType,
                                    taskCategory: _taskCategory,
                                    extraWorkName: _workName,
                                    describeWork: _description,
                                    taskType: _taskType,
                                    status: _status,
                                    startTime: _startTime,
                                    employeeEmail: _employeeEmail,
                                  );
                                  assignTask(extraTask);
                                } else {}
                              },
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }

  void assignTask(AdminTaskModel adminTask) async {
    try {
      final CollectionReference adminTaskCollection = FirebaseFirestore.instance.collection('AdminTask');
      await adminTaskCollection.add({
        'projectType': adminTask.projectType.toString(),
        'taskCategory': adminTask.taskCategory.toString(),
        'extraWorkName': adminTask.extraWorkName.toString(),
        'describeWork': adminTask.describeWork.toString(),
        'taskType': adminTask.taskType.toString(),
        'status': adminTask.status.toString(),
        'startTime': adminTask.startTime.toString(),
        'employeeEmail': adminTask.employeeEmail,
      }).then((value) {
        showToast('Task Created Successfully', Colors.green);
        Navigator.of(context).pop();
      });
    } catch (e) {
      print(e.toString());
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
