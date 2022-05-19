import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kpi_app/view/ui/auth/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerAdmin extends StatelessWidget {
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
              decoration: BoxDecoration(
                //color: Colors.grey.shade300,
                image: DecorationImage(
                    fit: BoxFit.contain,
                    image: new AssetImage('assets/images/kpii.png')),
              ), child: null,
            ),
            Divider(
              thickness: 2,
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Admin Dashboard'),
              onTap: () {
                //  Navigator.of(context).pushNamed("/employee/list");

              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle_rounded),
              title: Text('Edit Dashboard'),
              onTap: () {
                Navigator.of(context).pushNamed("/admin/dashboard/edit");
              },
            ),
            ListTile(
              leading: Icon(Icons.group),
              title: Text('All Employee List'),
              onTap: () {
                Navigator.of(context).pushNamed("/employee/list");
              },
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
