import 'package:flutter/material.dart';
import 'package:kpi_app/config/constants.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color, textColor;
  const RoundedButton({
    Key? key,
    required this.text,
    this.color = PrimaryColor,
    this.textColor = Colors.white,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.6,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(60),
        child: FlatButton(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          color: color,
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
