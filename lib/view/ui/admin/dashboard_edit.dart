import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kpi_app/config/constants.dart';
import 'package:kpi_app/view/ui/succes.dart';
import 'package:kpi_app/view/utils/background_all.dart';
import 'package:kpi_app/view/utils/round_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';




class DashboardEdit extends StatefulWidget {
  //const DashboardEdit({Key? key}) : super(key: key);

  @override
  _DashboardEditState createState() => _DashboardEditState();
}

class _DashboardEditState extends State<DashboardEdit> {
  String _totalProject = '';

  final totalProjectController = TextEditingController();

  TextEditingController _addProjectController =  TextEditingController();
  TextEditingController _addTaskCategoryController =  TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPreferences.getInstance().then((value) {
      totalProjectController.text = value.getString('totalProject')!;
      setState(() {

      });
    });
  }
  sendprojecttoDB()async{
    CollectionReference _collectionRef=FirebaseFirestore.instance.collection("Project_Type");
    return _collectionRef.doc().set({
      "Project-Name":_addProjectController.text,
    }).then((value) =>print("Data Added Succesfully")).catchError((error)=>print("Something is Wrong.$error"));
  }
  sendtasktoDB()async{
    CollectionReference _collectionRef=FirebaseFirestore.instance.collection("Task_Type");
    return _collectionRef.doc().set({
      "Task-Name":_addTaskCategoryController.text,
    }).then((value) =>print("Data Added Succesfully")).catchError((error)=>print("Something is Wrong.$error"));
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      header: 'Edit Dashboard',
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


                          ],
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: size.height * .045,
                          ),

                          SizedBox(
                            height: size.height * .03,
                          ),
                        ],
                      ),
                      Container(width: size.width * 0.50,child: Center(
                        child: Image.asset("assets/images/kpii.png"),
                      ),),
                      SizedBox(height: 20,),
                      Row(children: [
                        Container(height: size.height *.07,width: size.width * .50,
                          child: TextFormField(
                          controller: _addProjectController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(20),
                            labelText: "Add New Project",
                            hintText: "Enter new Project",
                            suffixIcon:Icon(Icons.add),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),),
                        SizedBox(width: 20,),
                        OutlinedButton(onPressed: (){sendprojecttoDB();
                          setState(() {
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>SuccesFul()));
                          });

                          }, child: Text("Submit",style: TextStyle(color: Colors.green),)),

                      ],),
                      SizedBox(height: 10,),
                      Row(children: [
                        Container(height: size.height * .07,
                          width: size.width * 0.50,
                          child: TextFormField(
                          controller: _addTaskCategoryController,
                          decoration: InputDecoration(
                            labelText: "Add Task Category",
                            hintText: "Enter new Category",
                            suffixIcon:Icon(Icons.add),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),),
                        SizedBox(width: 20,),
                        OutlinedButton(onPressed: (){sendtasktoDB();
                          setState(() {
                            setState(() {
                              Navigator.push(context, MaterialPageRoute(builder: (_)=>SuccesFul()));
                            });
                          });}, child: Text("Submit",style: TextStyle(color: Colors.green),))
                      ],),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
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

