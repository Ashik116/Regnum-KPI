import 'package:charts_common/src/data/series.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kpi_app/view/utils/background_all.dart';

class Settings extends StatelessWidget {
  List<Series<dynamic, num>> get seriesList => [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
        header: "Settings",
        child: SafeArea(
          child: ListView(children: [
            SizedBox(
              height: size.height * .02,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed("/changepassword");
              },
              child: Container(
                child: const ListTile(
                  title: Text('Change Password'),
                  leading: Icon(Icons.lock),
                ),
              ),
            ),
            const Divider(
              thickness: 2,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed("/profile/user");
              },
              child: Container(
                child: const ListTile(
                  title: Text('Access your Information'),
                  subtitle: Text('View Your information'),
                  leading: Icon(Icons.perm_identity_rounded),
                ),
              ),
            ),
            const Divider(
              thickness: 2,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed("/animals/favourite");
              },
              child: Container(
                child: const ListTile(
                  title: Text('Favourite Employee'),
                  subtitle: Text('Select your favourite Employee'),
                  leading: Icon(Icons.perm_identity_rounded),
                ),
              ),
            ),
            const Divider(
              thickness: 2,
            ),
          ]),
        ));
  }
}
