import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class loadingAnimation extends StatelessWidget {
  const loadingAnimation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitSpinningLines(
            color: Colors.limeAccent.shade200,
            size: 130,
          ),
          SizedBox(height: 10,),

          SpinKitFadingGrid(
            color: Colors.red,
            size: 30,
          ),
          SizedBox(
            height: 10,
          ),
          DefaultTextStyle(
            style: const TextStyle(
              color: Colors.lightGreen,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText('Loading...',
                    speed: Duration(milliseconds: 150))
              ],
              isRepeatingAnimation: true,
            ),
          )
        ],
      ),
    );
  }
}
