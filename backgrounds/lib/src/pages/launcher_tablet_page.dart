import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:backgrounds/src/models/layout_model.dart';
import 'package:backgrounds/src/routes/routes.dart';
import 'package:backgrounds/src/theme/theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LauncherTabletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<ThemeChanger>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Diseños en flutter - Tablet',
          style: TextStyle(
              color: themeChanger.currentTheme.scaffoldBackgroundColor),
        ),
        backgroundColor: themeChanger.currentTheme.accentColor,
      ),
      body: ChangeNotifierProvider.value(
        value: LayoutModel(),
        child: Row(
          children: <Widget>[
            Container(
              width: 300,
              child: _ListaOpciones(),
            ),
            Container(
              width: 1,
              height: double.infinity,
              color: (themeChanger.darkTheme)
                  ? Colors.grey
                  : themeChanger.currentTheme.accentColor,
            ),
            Builder(
              builder: (BuildContext context) {
                final layoutModel = Provider.of<LayoutModel>(context);
                return Expanded(child: layoutModel.currentPage);
              },
            ),
          ],
        ),
      ),
      drawer: _MenuPrincipal(),
    );
  }
}

class _MenuPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeChanger>(context);
    final accentColor = themeProvider.currentTheme.accentColor;
    return Drawer(
      child: Container(
        color: themeProvider.currentTheme.scaffoldBackgroundColor,
        child: Column(
          children: <Widget>[
            SafeArea(
              child: Container(
                width: double.infinity,
                height: 200,
                child: CircleAvatar(
                  backgroundColor: accentColor,
                  child: Text(
                    'JM',
                    style: TextStyle(
                      fontSize: 50,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(child: _ListaOpciones()),
            ListTile(
              leading: Icon(
                Icons.lightbulb_outline,
                color: accentColor,
              ),
              title: Text('Dark Mode'),
              trailing: Switch.adaptive(
                value: themeProvider.darkTheme,
                onChanged: (value) {
                  themeProvider.darkTheme = value;
                },
                activeColor: accentColor,
              ),
            ),
            SafeArea(
              bottom: true,
              top: false,
              left: false,
              right: false,
              child: ListTile(
                leading: Icon(
                  Icons.add_to_home_screen,
                  color: accentColor,
                ),
                title: Text('Custom Theme'),
                trailing: Switch.adaptive(
                  value: themeProvider.customTheme,
                  onChanged: (value) {
                    themeProvider.customTheme = value;
                  },
                  activeColor: accentColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListaOpciones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context).currentTheme;
    final layoutModel = Provider.of<LayoutModel>(context);
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemCount: pageRoutes.length,
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          color: appTheme.primaryColorLight,
        );
      },
      itemBuilder: (BuildContext context, int i) {
        return ListTileTheme(
          selectedColor: appTheme.accentColor,
          child: ListTile(
            selected: layoutModel.currentPage == pageRoutes[i].page,
            leading: FaIcon(pageRoutes[i].icon, color: appTheme.accentColor),
            title: Text(pageRoutes[i].titulo),
            trailing: Icon(
              Icons.chevron_right,
              color: appTheme.accentColor,
            ),
            onTap: () {
              layoutModel.currentPage = pageRoutes[i].page;
            },
          ),
        );
      },
    );
  }
}
