import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: LoadingAnimationWidget.threeRotatingDots(
        color: Color.fromARGB(255, 196, 114, 8),
        size: 50,
      )),
    );
  }
}
