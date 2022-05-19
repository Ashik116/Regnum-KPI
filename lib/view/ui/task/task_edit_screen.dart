import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kpi_app/models/extra_task_models.dart';
import 'package:kpi_app/view/utils/background_all.dart';
import 'package:kpi_app/view/utils/round_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExtraTaskEdit extends StatefulWidget {
  _ExtraTaskEditState createState() => _ExtraTaskEditState();
}

class _ExtraTaskEditState extends State<ExtraTaskEdit> {
  String _projectType = "";
  String _taskCategory = "";
  String _workName = "";
  String _description = "";
  String _taskType = "";
  String _status = "";
  String _startTime = "";
  String _endTime = "";
  List<String> _project = [];
  List<String> _task = [];

  final workNameController = TextEditingController();
  final descriptionController = TextEditingController();

  Map<String, dynamic>? taskMap;
  var oldTaskInfo;

  String taskID = '';
  fetchproject() async {
    var _fireStoreInstance = FirebaseFirestore.instance;
    QuerySnapshot qn =
        await _fireStoreInstance.collection("Project_Type").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _project.add(qn.docs[i]["Project-Name"]);
      }
    });
    return qn.docs;
  }

  fetchtask() async {
    var _fireStoreInstance = FirebaseFirestore.instance;
    QuerySnapshot qn = await _fireStoreInstance.collection("Task_Type").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
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
    SharedPreferences.getInstance().then((value) {
      taskID = value.getString('oldTaskID')!;

      workNameController.text = value.getString('oldExtraWorkName')!;
      descriptionController.text = value.getString('oldDescribeWork')!;
      _startTime = value.getString('oldStartDate')!;
      _endTime = value.getString('oldEndDate')!;
      _taskType = value.getString('oldTaskType')!;
      _status = value.getString('oldStatus')!;
      _taskCategory = value.getString('oldTaskCategory')!;
      _projectType = value.getString('oldProjectType')!;
      if (value.getString('oldTaskCategory')!.length > 2) {
        _taskCategory = value.getString('oldTaskCategory')!;
      }
      if (value.getString('oldStatus')!.length > 2) {
        _status = value.getString('oldStatus')!;
      }
      if (value.getString('oldTaskType')!.length > 2) {
        _taskType = value.getString('oldTaskType')!;
      }
      if (value.getString('oldProjectType')!.length > 2) {
        _projectType = value.getString('oldProjectType')!;
      }
      setState(() {});
    });
  }

  // @override
  // void dispose() async {
  //   // TODO: implement dispose
  //   super.dispose();
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   sharedPreferences.clear();
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      header: 'Edit Task',
      floatingButton: FloatingActionButton.extended(
        label: Text('Delete'),
        icon: Icon(Icons.delete_rounded),
        backgroundColor: Colors.green.shade700,
        onPressed: () {
          deleteTask();
        },
      ),
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
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        DropdownSearch<String>(
                          mode: Mode.MENU,
                          items: _project,
                          dropdownSearchDecoration: InputDecoration(
                            hintText: "Select Your Project",
                            labelText: "Project Type",
                          ),
                          onChanged: (value) {
                            _projectType = value.toString();
                          },
                          selectedItem: _projectType,
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        DropdownSearch<String>(
                          mode: Mode.MENU,
                          items: _task,
                          dropdownSearchDecoration: InputDecoration(
                            hintText: "Task Category List",
                            labelText: "Select Your Task",
                          ),
                          onChanged: (value) {
                            _taskCategory = value.toString();
                          },
                          selectedItem: _taskCategory,
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        TextField(
                          maxLines: 2,
                          controller: workNameController,
                          decoration: InputDecoration(
                            labelText: "Extra Work Name",
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
                            labelText: "Describe Your Work",
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
                          selectedItem: _taskType,
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        DropdownSearch<String>(
                          mode: Mode.MENU,
                          items: const ["Pending", "Complete", "Cancel"],
                          dropdownSearchDecoration: InputDecoration(
                            labelText: "Status",
                            hintText: "Select Your Work Status",
                          ),
                          onChanged: (value) {
                            _status = value.toString();
                          },
                          selectedItem: _status,
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        DateTimePicker(
                          type: DateTimePickerType.dateTime,
                          //initialValue:DateTime.parse(_startTime).toString(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          dateLabelText: 'Start Time',
                          icon: Icon(Icons.event),
                          onChanged: (value) {
                            _startTime = value;
                          },
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        DateTimePicker(
                          type: DateTimePickerType.dateTime,
                          //initialValue:DateTime.parse(_endTime).toString(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          icon: Icon(Icons.event),
                          dateLabelText: 'End Time',
                          onChanged: (value) {
                            _endTime = value;
                          },
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: size.height * .045,
                      ),
                      RoundedButton(
                        text: "Save",
                        color: Colors.greenAccent.shade100,
                        textColor: Colors.black,
                        onPressed: () {
                          _workName = workNameController.value.text.toString();
                          _description =
                              descriptionController.value.text.toString();
                          if (_description != null &&
                              _workName != null &&
                              _projectType != null &&
                              _taskCategory != null &&
                              _taskType != null &&
                              _status != null &&
                              _startTime != null &&
                              _endTime != null) {
                            var extraTask = ExtraTaskModel(
                              projectType: _projectType,
                              taskCategory: _taskCategory,
                              extraWorkName: _workName,
                              describeWork: _description,
                              taskType: _taskType,
                              status: _status,
                              startTime: _startTime.toString(),
                              endTime: _endTime.toString(),
                              employeeEmail: '',
                            );
                            editTaskData(extraTask);
                          } else {}
                        },
                      ),
                      SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }

  void editTaskData(ExtraTaskModel extraTask) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      final CollectionReference extraTaskCollection =
          FirebaseFirestore.instance.collection('ExtraTaskInfo');
      await extraTaskCollection.doc(taskID).set({
        'projectType': extraTask.projectType.toString(),
        'taskCategory': extraTask.taskCategory.toString(),
        'extraWorkName': extraTask.extraWorkName.toString(),
        'employeeEmail': auth.currentUser!.email,
        'describeWork': extraTask.describeWork.toString(),
        'taskType': extraTask.taskType.toString(),
        'status': extraTask.status.toString(),
        'startTime': extraTask.startTime.toString(),
        'endTime': extraTask.endTime.toString(),
      }).then((value) {
        showToast('Edit Successful', Colors.green);

        Navigator.of(context)
            .pushNamedAndRemoveUntil("/dashboard/user", (route) => false);
        //Navigator.of(context).pop();
        //Navigator.of(context).pop();
      });
    } catch (e) {
      showToast('User Task Update failed', Colors.red);
      print(e.toString());
    }
  }

  void deleteTask() async {
    try {
      final CollectionReference extraTaskCollection =
          FirebaseFirestore.instance.collection('ExtraTaskInfo');
      await extraTaskCollection.doc(taskID).delete().then((value) {
        showToast('Task deleted', Colors.green);
        Navigator.of(context)
            .pushNamedAndRemoveUntil("/all/extra/task", (route) => false);
        //Navigator.of(context).pop();
        //Navigator.of(context).pop();
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
