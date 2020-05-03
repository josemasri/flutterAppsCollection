import 'package:flutter/material.dart';

import 'dart:math' as math;

class AnimacionesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CuadradoAnimado(),
      ),
    );
  }
}

class CuadradoAnimado extends StatefulWidget {
  @override
  _CuadradoAnimadoState createState() => _CuadradoAnimadoState();
}

class _CuadradoAnimadoState extends State<CuadradoAnimado>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> rotacion;
  Animation<double> opacity;
  Animation<double> opacityMover;
  Animation<double> moverDerecha;
  Animation<double> agrandar;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 4000),
    );
    rotacion = Tween(begin: 0.0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOut),
    );

    opacity = Tween(begin: 0.1, end: 1.0).animate(
      CurvedAnimation(
          parent: controller,
          curve: Interval(0, 0.33, curve: Curves.easeInExpo)),
    );

    opacityMover = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
          parent: controller,
          curve: Interval(0.75, 1.0, curve: Curves.easeOut)),
    );

    moverDerecha = Tween(begin: 0.0, end: 200.0).animate(
      CurvedAnimation(
          parent: controller, curve: Interval(0, 1, curve: Curves.easeIn)),
    );

    agrandar = Tween(begin: 0.0, end: 2.0).animate(
      CurvedAnimation(
          parent: controller, curve: Interval(0, 1, curve: Curves.easeInOutExpo)),
    );

    controller.addListener(() {
      if (controller.status == AnimationStatus.completed) {
        // controller.reverse();
        // controller.reset();
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
          offset: Offset(moverDerecha.value, 0),
          child: Transform.rotate(
            angle: rotacion.value,
            child: Opacity(
              opacity: opacityMover.value == 1 ? opacity.value: opacityMover.value,
              child: Transform.scale(
                scale: agrandar.value,
                child: _Rectangulo(),
              ),
            ),
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
