import 'package:flutter/material.dart';
import 'package:kpi_app/config/constants.dart';
import 'package:kpi_app/view/utils/drawer_admin.dart';

class BackgroundAdminDashboard extends StatefulWidget {
  final Widget child;
  final String header;
  const BackgroundAdminDashboard({
    Key? key,
    required this.child,
    required this.header,
  }) : super(key: key);

  @override
  _BackgroundAdminDashboardState createState() => _BackgroundAdminDashboardState();
}

class _BackgroundAdminDashboardState extends State<BackgroundAdminDashboard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: PrimaryColor),
        title: Text(
          widget.header,
          style: const TextStyle(color: PrimaryColor),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [],
      ),
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assets/images/main_top.png",
                width: size.width * 0.35,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                "assets/images/login_bottom.png",
                width: size.width * 0.4,
              ),
            ),
            widget.child,
          ],
        ),
      ),
      drawer: DrawerAdmin(),
    );
  }
}
