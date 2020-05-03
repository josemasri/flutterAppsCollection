import 'package:flutter/material.dart';

class OrangeButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double height;
  final double width;
  final double opacity;

  const OrangeButton({
    @required this.onPressed,
    this.text = 'Add to cart',
    this.height = 30,
    this.width = 100, 
    this.opacity = 1.0,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(opacity),
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.center,
      child: FlatButton(
        onPressed: onPressed,
        textColor: Colors.white,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 11,
          ),
        ),
      ),
    );
  }
}
