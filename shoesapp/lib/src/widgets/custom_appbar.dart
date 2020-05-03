import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String text;

  const CustomAppBar({@required this.text});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        margin: EdgeInsets.only(top: 30),
        padding: EdgeInsets.symmetric(horizontal: 30),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
            ),
            IconButton(
                icon: Icon(
                  Icons.search,
                  size: 30,
                ),
                onPressed: () {})
          ],
        ),
      ),
    );
  }
}
