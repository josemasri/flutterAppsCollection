import 'package:backgrounds/src/routes/routes.dart';
import 'package:backgrounds/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LauncherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context).currentTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Diseños en flutter - Telefono',
          style: TextStyle(color: appTheme.scaffoldBackgroundColor),
        ),
        backgroundColor: appTheme.accentColor,
      ),
      body: Center(
        child: _ListaOpciones(),
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
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemCount: pageRoutes.length,
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          color: appTheme.primaryColorLight,
        );
      },
      itemBuilder: (BuildContext context, int i) {
        return ListTile(
          leading: FaIcon(pageRoutes[i].icon, color: appTheme.accentColor),
          title: Text(pageRoutes[i].titulo),
          trailing: Icon(
            Icons.chevron_right,
            color: appTheme.accentColor,
          ),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => pageRoutes[i].page));
          },
        );
      },
    );
  }
}
