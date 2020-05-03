import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BigButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color firstColor;
  final Color secondColor;
  final VoidCallback onPressed;
  final Color iconColor;

  const BigButton({
    @required this.onPressed,
    @required this.text,
    this.icon = Icons.account_circle,
    this.firstColor = Colors.blue,
    this.secondColor = Colors.grey, 
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        children: <Widget>[
          _BigButtonBackground(icon, firstColor, secondColor),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 140, width: 40),
              Icon(icon, color: iconColor, size: 40),
              SizedBox(width: 20),
              Expanded(
                child: Text(text,
                    style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
              Icon(FontAwesomeIcons.chevronRight,
                  color: iconColor, size: 40),
              SizedBox(width: 40),
            ],
          ),
        ],
      ),
    );
  }
}

class _BigButtonBackground extends StatelessWidget {
  final IconData icon;
  final Color firstColor;
  final Color secondColor;

  const _BigButtonBackground(this.icon, this.firstColor, this.secondColor);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: <Widget>[
            Positioned(
              right: -20,
              top: -20,
              child: Icon(
                icon,
                size: 150,
                color: Colors.white.withOpacity(0.2),
              ),
            )
          ],
        ),
      ),
      margin: EdgeInsets.all(20),
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: Offset(4, 6),
            blurRadius: 10,
          ),
        ],
        color: Colors.red,
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: <Color>[
            firstColor,
            secondColor,
          ],
        ),
      ),
    );
  }
}
