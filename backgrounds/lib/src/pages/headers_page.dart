import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:backgrounds/src/widgets/headers.dart';
import 'package:backgrounds/src/theme/theme.dart';

class HeadersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<ThemeChanger>(context);
    return Scaffold(
      body: HeaderWaves(color: themeChanger.currentTheme.accentColor),
    );
  }
}
