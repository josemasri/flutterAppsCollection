import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class TwitterPage extends StatefulWidget {
  @override
  _TwitterPageState createState() => _TwitterPageState();
}

class _TwitterPageState extends State<TwitterPage> {
  var active = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        onPressed: () {
          setState(() {
            active = true;
          });
        },
        child: FaIcon(
          FontAwesomeIcons.play,
        ),
      ),
      backgroundColor: Color(0xff1DA1F2),
      body: Center(
        child: ZoomOut(
          controller: null,
          animate: active,
          duration: Duration(seconds: 1),
          from: 30,
          child: FaIcon(
            FontAwesomeIcons.twitter,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
    );
  }
}

