import 'package:flutter/material.dart';

class ShoeModel with ChangeNotifier {
  double _selected = 9.0;
  String _image = 'assets/imgs/azul.png';

  double get selected => _selected;
  String get image => _image;

  set selected(double value) {
    _selected = value;
    notifyListeners();
  }

  set image(String value) {
    _image = value;
    notifyListeners();
  }
}
