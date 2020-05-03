import 'package:flutter/material.dart';

import 'package:backgrounds/src/pages/slideshow_page.dart';

class LayoutModel with ChangeNotifier {
  Widget _currentPage = SlideShowPage();

  get currentPage => _currentPage;

  set currentPage(Widget page) {
    _currentPage = page;
    notifyListeners();
  }
}
