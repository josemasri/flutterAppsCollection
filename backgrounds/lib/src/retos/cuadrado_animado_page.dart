import 'package:flutter/material.dart';

class CuadradoAnimadoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _CuadradoAnimado(),
      ),
    );
  }
}

class _CuadradoAnimado extends StatefulWidget {
  @override
  __CuadradoAnimadoState createState() => __CuadradoAnimadoState();
}

class __CuadradoAnimadoState extends State<_CuadradoAnimado>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  // Animaciones
  Animation<double> moveRight;
  Animation<double> moveUp;
  Animation<double> moveLeft;
  Animation<double> moveDown;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 4500),
    );
    moveRight = Tween(begin: 0.0, end: 100.0).animate(
      CurvedAnimation(
          parent: controller,
          curve: Interval(
            0,
            0.25,
            curve: Curves.bounceOut,
          )),
    );
    moveUp = Tween(begin: 0.0, end: -100.0).animate(
      CurvedAnimation(
          parent: controller,
          curve: Interval(
            0.25,
            0.5,
            curve: Curves.bounceOut,
          )),
    );
    moveLeft = Tween(begin: 0.0, end: -100.0).animate(
      CurvedAnimation(
          parent: controller,
          curve: Interval(
            0.5,
            0.75,
            curve: Curves.bounceOut,
          )),
    );
    moveDown = Tween(begin: 0.0, end: 100.0).animate(
      CurvedAnimation(
          parent: controller,
          curve: Interval(
            0.75,
            1,
            curve: Curves.bounceOut,
          )),
    );
    controller.addListener(() {
      if (controller.status == AnimationStatus.completed) {
        controller.repeat();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward();
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget child) {
        return Transform.translate(
          offset: Offset(moveRight.value, moveUp.value),
          child: Transform.translate(
            offset: Offset(moveLeft.value, moveDown.value),
            child: _Rectangulo(),
          ),
        );
      },
    );
  }
}

class _Rectangulo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
    );
  }
}
