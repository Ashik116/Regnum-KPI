import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kpi_app/view/utils/background_all.dart';
import 'package:kpi_app/view/utils/loading_animation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeDetailsAdmin extends StatefulWidget {
  const EmployeeDetailsAdmin({Key? key}) : super(key: key);

  @override
  _EmployeeDetailsAdminState createState() => _EmployeeDetailsAdminState();
}

class _EmployeeDetailsAdminState extends State<EmployeeDetailsAdmin> {
  var userEmail;
  var userInfo;
  bool isLoading = true ;
  bool userNotFound = false;
  late SharedPreferences sharedPreferences ;


  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? data =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    userEmail = data!['email'];
    getData();
    return isLoading ? loadingAnimation() :  Background(
      floatingButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("Regnum-KPI",style: TextStyle(fontSize: 10),),
              Container(height: 20,width: 20,
                  child: Image.asset("assets/images/kpii.png")),
            ],
          ),
        ],
      ),
      header: "Profile",
      child: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding:
            const EdgeInsets.only(left: 16, top: 15, right: 16, bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: const Text(
                        'Full Name',
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
                      child:Text(
                        "${userInfo['fullName']}",
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                        //    textAlign: TextAlign.justify,
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
                        'Email',
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
                        "${userInfo['email']}",
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
                        'Designation',
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
                        "${userInfo['designation']}",
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
                        'Phone Number',
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
                        "${userInfo['phone']}",
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                        //  textAlign: TextAlign.justify,
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
                        'Address',
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
                        "${userInfo['city']}",
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                        //  textAlign: TextAlign.justify,
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
                        'Relationship Status',
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
                        "${userInfo['relationshipStatus']}",
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                        //  textAlign: TextAlign.justify,
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
                        'Joining Date',
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
                        "${userInfo['joinDate']}",
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                        //  textAlign: TextAlign.justify,
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

  void getData(){
    try{
      final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('UserInfo');
      userCollection.get().then((value) {
        if(value.size > 0){
          value.docs.forEach((element) async {
            if(element.get('email') == userEmail){
              userInfo = element.data();

              setState(() {
                userNotFound = false;
                isLoading = false;
              });
            }
            else{
              setState(() {
                userNotFound = true;
                isLoading = false;
              });
            }
          });
        }
        else{
          setState(() {
            userNotFound = true;
            isLoading = false;
          });
        }
      });
    }
    catch(e){
      setState(() {
        userNotFound = true;
        isLoading = false;
      });
      print(e.toString());
    }
  }
}
