import 'package:flutter/material.dart';
import 'package:kpi_app/view/utils/background_all.dart';

class SuccesFul extends StatelessWidget {
  const SuccesFul({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background( header: "Successful",
    child: Center(
      child: Container(
          height: 300,width: 350,
          child: Column(
            children: [
              Image.asset("assets/images/you.png"),

            ],
          )),
    ),

    );
  }
}
