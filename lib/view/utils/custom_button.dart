import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.isLoading,
  }) : super(key: key);

  final String label;
  final VoidCallback onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.black,
              fontSize: 30,
            ),
          ),
          _RoundContinueButton(onPressed: onPressed),
        ],
      ),
    );
  }
}

class _RoundContinueButton extends StatelessWidget {
  const _RoundContinueButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: Colors.lightGreen.shade500,
      splashColor: Colors.lightGreen.shade500,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
            Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: 32,
            ),
          ],
        ),
      ),
      onPressed: onPressed,
      padding: EdgeInsets.all(16.0),
      shape: const CircleBorder(),
    );
  }
}
