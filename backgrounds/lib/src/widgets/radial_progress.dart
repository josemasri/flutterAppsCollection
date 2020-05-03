import 'dart:math';

import 'package:flutter/material.dart';

class RadialProgress extends StatefulWidget {
  final double percentage;
  final Color primaryColor;
  final Color secondaryColor;
  final double primaryStrokeWidth;
  final double secondaryStrokeWidth;

  const RadialProgress({
    @required this.percentage,
    this.primaryColor = Colors.blue,
    this.secondaryColor = Colors.grey,
    this.primaryStrokeWidth = 10,
    this.secondaryStrokeWidth = 4,
  });
  @override
  _RadialProgressState createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  double previousPercentage = 0;

  @override
  void initState() {
    previousPercentage = widget.percentage;
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward(from: 0.0);

    final differenceAnimate = widget.percentage - previousPercentage;
    previousPercentage = widget.percentage;

    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget child) {
        return Container(
          padding: EdgeInsets.all(10),
          width: double.infinity,
          height: double.infinity,
          child: CustomPaint(
            painter: _MiRadialProgress(
              (widget.percentage - differenceAnimate) +
                  (differenceAnimate * controller.value),
              widget.primaryColor,
              widget.secondaryColor,
              widget.primaryStrokeWidth,
              widget.secondaryStrokeWidth,
            ),
          ),
        );
      },
    );
  }
}

class _MiRadialProgress extends CustomPainter {
  final double precentage;
  final Color primaryColor;
  final Color secondaryColor;
  final double primaryStrokeWidth;
  final double secondaryStrokeWidth;

  _MiRadialProgress(
    this.precentage,
    this.primaryColor,
    this.secondaryColor,
    this.primaryStrokeWidth,
    this.secondaryStrokeWidth,
  );

  @override
  void paint(Canvas canvas, Size size) {
    // Circulo completado
    final paint = Paint()
      ..strokeWidth = secondaryStrokeWidth
      ..color = secondaryColor
      ..style = PaintingStyle.stroke;
    final c = Offset(size.width * 0.5, size.height * 0.5);
    final radius = min(size.width * 0.5, size.height * 0.5);
    canvas.drawCircle(c, radius, paint);

    // Arco
    final paintArc = Paint()
      ..strokeWidth = primaryStrokeWidth
      ..color = primaryColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Parte que se debera ir llenando
    double arcAngle = 2 * pi * (precentage / 100);
    canvas.drawArc(
      Rect.fromCircle(center: c, radius: radius),
      -pi / 2,
      arcAngle,
      false,
      paintArc,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
