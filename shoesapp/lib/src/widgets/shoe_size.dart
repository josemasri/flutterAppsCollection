import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoesapp/src/models/shoe_model.dart';

class ShoeSize extends StatelessWidget {
  final bool fullScreen;

  const ShoeSize({this.fullScreen = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: fullScreen ? 5 : 30,
        vertical: fullScreen ? 5 : 0,
      ),
      width: double.infinity,
      height: fullScreen ? 440 : 480,
      decoration: BoxDecoration(
        color: Color(0xffFDD550),
        borderRadius: fullScreen
            ? BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              )
            : BorderRadius.circular(50),
      ),
      child: Column(
        children: <Widget>[
          _ShoeWithShadow(),
          if (!fullScreen) _ShoeSizes(),
        ],
      ),
    );
  }
}

class _ShoeSizes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _ShoeSize(7),
        _ShoeSize(7.5),
        _ShoeSize(8),
        _ShoeSize(8.5),
        _ShoeSize(9),
        _ShoeSize(9.5),
      ],
    );
  }
}

class _ShoeSize extends StatelessWidget {
  final double size;

  const _ShoeSize(this.size);

  @override
  Widget build(BuildContext context) {
    final showModel = Provider.of<ShoeModel>(context);
    bool selected = showModel.selected == size;
    return GestureDetector(
      onTap: () => showModel.selected = size,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: selected ? Color(0xffFF9F02) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            if (selected)
              BoxShadow(
                color: Color(0xffFF9F02),
                blurRadius: 10,
                spreadRadius: 3,
              ),
          ],
        ),
        child: Text(
          '${size.toString().replaceAll('.0', '')}',
          style: TextStyle(
            color: selected ? Colors.white : Color(0xffFFD54F),
            fontWeight: FontWeight.w700,
          ),
        ),
        alignment: Alignment.center,
      ),
    );
  }
}

class _ShoeWithShadow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final imageModel = Provider.of<ShoeModel>(context);
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 20,
            right: 0,
            child: _ShoeShadow(),
          ),
          Image(
            image: AssetImage(imageModel.image),
          )
        ],
      ),
    );
  }
}

class _ShoeShadow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -0.5,
      child: Container(
        width: 230,
        height: 120,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            boxShadow: [BoxShadow(color: Color(0xffEAA14E), blurRadius: 40)]),
      ),
    );
  }
}
