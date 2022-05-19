import 'package:flutter/material.dart';
import 'package:kpi_app/config/constants.dart';

class DashboardCard extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final String label;
  final String count;
  final Color color;

  const DashboardCard(
      {Key? key,
      required this.icon,
      required this.label,
      required this.onPressed,
      required this.color,
      required this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: onPressed,
        child: Container(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey[100],
                boxShadow: [
                  BoxShadow(color: color, offset: Offset.zero, blurRadius: 20)
                ],
              ),
              child: Column(
                children: [
                  Icon(icon, size: 50),
                  SizedBox(
                    height: 10,
                  ),
                  Text(count, textAlign: TextAlign.center, style: BodyText5),
                ],
              ),
            ),
            SizedBox(height: size.height * .01),
            Text(label, textAlign: TextAlign.center, style: BodyText5)
          ]),
        ));
  }
}
