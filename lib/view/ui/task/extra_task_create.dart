import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kpi_app/models/extra_task_models.dart';
import 'package:kpi_app/view/utils/background_all.dart';
import 'package:kpi_app/view/utils/round_button.dart';

class CreateExtraTask extends StatefulWidget {
  @override
  _CreateExtraTaskState createState() => _CreateExtraTaskState();
}

class _CreateExtraTaskState extends State<CreateExtraTask> {
  String _projectType = "";
  String _taskCategory = "";
  String _workName = "";
  String _description = "";
  String _taskType = "";
  String _status = "";
  String _employeeID = "";
  String _employeeEmail = "";
  String _startTime = "";
  String _endTime = "";

  List<String> _project = [];
  List<String> _task = [];

  final workNameController = TextEditingController();
  final descriptionController = TextEditingController();
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
    fetchtask();
    fetchproject();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      header: 'Please Add Your Extra Task ',
      child: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            SizedBox(
              height: size.height * .002,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Container(
                    width: size.width * 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        DropdownSearch<String>(
                          mode: Mode.MENU,
                          items: _project,
                          label: "Project Type",
                          hint: "Select Your Project ",
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
                          label: "Task Category List",
                          hint: "Select Your Task",
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
                            contentPadding: EdgeInsets.all(8),
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
                          scrollPadding: EdgeInsets.all(10),
                          maxLines: 8,
                          controller: descriptionController,
                          decoration: InputDecoration(
                            labelText: "Task Description",
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
                        Container(
                          height: size.height * 0.06,
                          width: size.width * 5,
                          child: DropdownSearch<String>(
                            mode: Mode.MENU,
                            items: const ["Daily", "Weekly", "Monthly"],
                            dropdownSearchDecoration: InputDecoration(
                              labelText: "Task Type",
                              hintText: "Select Type",
                              //alignLabelWithHint: true,
                            ),
                            onChanged: (value) {
                              _taskType = value.toString();
                            },
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Container(
                          height: size.height * 0.06,
                          width: size.width * 5,
                          child: DropdownSearch<String>(
                            mode: Mode.MENU,
                            items: const ["Pending", "Complete", "Cancel"],
                            dropdownSearchDecoration: InputDecoration(
                              labelText: "Status",
                              hintText: "Select Your Work Status",
                            ),
                            onChanged: (value) {
                              _status = value.toString();
                            },
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        DateTimePicker(
                          type: DateTimePickerType.dateTime,
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
                            createExtraTask(extraTask);
                          } else {}
                        },
                      ),
                      SizedBox(
                        height: size.height * .03,
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

  void createExtraTask(ExtraTaskModel extraTask) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      var user = auth.currentUser;
      final CollectionReference extraTaskCollection =
          FirebaseFirestore.instance.collection('ExtraTaskInfo');
      await extraTaskCollection.add({
        'projectType': extraTask.projectType.toString(),
        'taskCategory': extraTask.taskCategory.toString(),
        'extraWorkName': extraTask.extraWorkName.toString(),
        'describeWork': extraTask.describeWork.toString(),
        'taskType': extraTask.taskType.toString(),
        'status': extraTask.status.toString(),
        'startTime': extraTask.startTime.toString(),
        'endTime': extraTask.endTime.toString(),
        //'employeeID': user!.uid,
        'employeeEmail': user!.email,
      }).then((value) {
        showToast('Task Created Successfully', Colors.green);

        Navigator.of(context)
            .pushNamedAndRemoveUntil("/all/extra/task", (route) => false);
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
