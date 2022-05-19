import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kpi_app/view/ui/auth/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideDrawer extends StatefulWidget {
  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  var user;

  var userInfo;
  var Allimage;

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

  void getData() {
    try {
      final CollectionReference userCollection =
          FirebaseFirestore.instance.collection('UserInfo');
      userCollection.get().then((value) {
        if (value.size > 0) {
          value.docs.forEach((element) async {
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      child: Container(
        color: Colors.black12,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  Container(
                    height: size.height * 0.096,
                    width: size.width * 0.25,
                    child: ClipOval(
                      child: Image.network(
                        "${userInfo?['image']}",
                        fit: BoxFit.fill,
                      ),
                      // "${userInfo['imgpath']}",
                      // style: const TextStyle(
                      //   fontSize: 15,
                      //   color: Colors.grey,
                      // ),
                      // textAlign: TextAlign.justify,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.005,
                  ),
                  Container(
                    child: Text(
                      "${userInfo?["fullName"]}",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Container(
                    child: Text(
                      "${userInfo?['designation']}",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                      // textAlign: TextAlign.justify,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 2,
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.of(context).pushNamed("/dashboard/user");
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle_rounded),
              title: Text('My Profile'),
              onTap: () {
                Navigator.of(context).pushNamed("/profile/user");
              },
            ),
            ListTile(
              leading: Icon(Icons.task),
              title: Text('All Task'),
              onTap: () {
                Navigator.of(context).pushNamed(
                    "/all/extra/task"); //all/extra/task//extra/task/create
              },
            ),
            ListTile(
              leading: Icon(Icons.margin),
              title: Text('Admin Task'),
              onTap: () {
                Navigator.of(context).pushNamed("/admin/taskList");
              },
            ),
            Divider(
              thickness: 2,
            ),
            Divider(
              thickness: 2,
            ),
            ListTile(
              title: Text('Logout'),
              leading: Icon(Icons.exit_to_app),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                sharedPreferences.clear();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
