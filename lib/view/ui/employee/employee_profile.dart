import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kpi_app/view/utils/background_all.dart';
import 'package:kpi_app/view/utils/loading_animation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeProfileScreen extends StatefulWidget {
  const EmployeeProfileScreen({Key? key}) : super(key: key);

  @override
  _EmployeeProfileScreenState createState() => _EmployeeProfileScreenState();
}

class _EmployeeProfileScreenState extends State<EmployeeProfileScreen> {
  var user;
  var userInfo;
  bool isLoading = true;
  bool userNotFound = false;
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    FirebaseAuth auth = FirebaseAuth.instance;
    user = auth.currentUser;
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? loadingAnimation()
        : Background(
            floatingButton: FloatingActionButton.extended(
              onPressed: () async {
                sharedPreferences = await SharedPreferences.getInstance();
                await sharedPreferences.setString(
                    'oldFullName', userInfo['fullName'].toString());
                await sharedPreferences.setString(
                    'oldPhone', userInfo['phone'].toString());
                await sharedPreferences.setString(
                    'oldJoinDate', userInfo['joinDate'].toString());
                await sharedPreferences.setString(
                    'oldDesignation', userInfo['designation'].toString());
                await sharedPreferences.setString(
                    'oldStatus', userInfo['relationshipStatus'].toString());
                await sharedPreferences.setString(
                    'oldCity', userInfo['city'].toString());
                Navigator.of(context).pushNamed("/employee/profile/update");
              },
              icon: const Icon(
                Icons.edit,
              ),
              backgroundColor: Color.fromRGBO(39, 123, 74, 1),
              label: Text('Edit'),
            ),
            header: "Profile",
            child: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 16, top: 15, right: 16, bottom: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              height: 100,
                              width: 100,
                              child: Image.network(
                                "${userInfo['image']}",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
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
                            child: Text(
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

  void getData() {
    try {
      final CollectionReference userCollection =
          FirebaseFirestore.instance.collection('UserInfo');
      userCollection.get().then((value) {
        if (value.size > 0) {
          value.docs.forEach((element) async {
            print('FFFFFFFFFFFFFFFFFFFFF');
            print(element.id);
            if (element.id == user.uid) {
              userInfo = element.data();

              setState(() {
                userNotFound = false;
                isLoading = false;
              });
            } else {
              setState(() {
                userNotFound = true;
                isLoading = false;
              });
            }
          });
        } else {
          setState(() {
            userNotFound = true;
            isLoading = false;
          });
        }
      });
    } catch (e) {
      setState(() {
        userNotFound = true;
        isLoading = false;
      });
      print(e.toString());
    }
  }
}
