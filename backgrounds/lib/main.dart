import 'package:backgrounds/src/pages/launcher_tablet_page.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:backgrounds/src/theme/theme.dart';
import 'package:backgrounds/src/pages/launcher_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: ThemeChanger(2),
      child: Builder(
        builder: (BuildContext context) {
          final themeProvider = Provider.of<ThemeChanger>(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Diseños App',
            home: OrientationBuilder(
              builder: (BuildContext context, Orientation orientation) {
                final screenSize = MediaQuery.of(context).size;
                if (screenSize.width > 500) {
                  return LauncherTabletPage();
                }
                return LauncherPage();
              },
            ),
            theme: themeProvider.currentTheme,
          );
        },
      ),
    );
  }
}
