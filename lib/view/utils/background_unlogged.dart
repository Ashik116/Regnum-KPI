import 'package:flutter/material.dart';
import 'package:kpi_app/config/constants.dart';

class BackgroundUnlogged extends StatelessWidget {
  final Widget child;

  const BackgroundUnlogged({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: PrimaryBGColor,
      body: Container(
        height: size.height,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assets/images/signup_top.png",
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                "assets/images/login_bottom.png",
              ),
            ),
            child
          ],
        ),
      ),
    );
  }
}
