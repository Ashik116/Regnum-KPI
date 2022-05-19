import 'package:flutter/material.dart';
import 'package:kpi_app/config/constants.dart';

class BackgroundAdmin extends StatefulWidget {
  final Widget child;
  Widget? floatingButton;
  Widget? leading;
  final String header;

  BackgroundAdmin({
    Key? key,
    required this.child,
    required this.header,
    this.leading,
    this.floatingButton,
  }) : super(key: key);

  @override
  _BackgroundAdminState createState() => _BackgroundAdminState();
}

class _BackgroundAdminState extends State<BackgroundAdmin> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        //leading: widget.leading,
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
      drawer: widget.leading,
      floatingActionButton: widget.floatingButton,
    );
  }
}
