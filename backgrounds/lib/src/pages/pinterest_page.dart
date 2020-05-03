import 'package:backgrounds/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:backgrounds/src/widgets/pinterest_menu.dart';
import 'package:provider/provider.dart';

class PinterestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider.value(
        value: _MenuModel(),
        child: Stack(
          children: <Widget>[
            PinterestGrid(),
            _PinterestMenuLocation(),
          ],
        ),
      ),
    );
  }
}

class _PinterestMenuLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final menuModel = Provider.of<_MenuModel>(context);
    var screenWidth = MediaQuery.of(context).size.width;
    final themeChanger = Provider.of<ThemeChanger>(context);
    if (screenWidth > 500) {
      screenWidth = screenWidth - 300;
    }
    return Positioned(
      bottom: 30,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            PinterestMenu(
              activeColor: themeChanger.currentTheme.accentColor,
              // inactiveColor: Colors.black,
              backgroundColor: themeChanger.currentTheme.scaffoldBackgroundColor,
              show: menuModel.show,
              items: [
                PinterestButton(
                  onPressed: () => print('Icon pie_chart'),
                  icon: Icons.pie_chart,
                ),
                PinterestButton(
                  onPressed: () => print('Icon search'),
                  icon: Icons.search,
                ),
                PinterestButton(
                  onPressed: () => print('Icon notifications'),
                  icon: Icons.notifications,
                ),
                PinterestButton(
                  onPressed: () => print('Icon supervised_user_circle'),
                  icon: Icons.supervised_user_circle,
                ),
              ],
            ),
          ],
        ),
        width: screenWidth,
      ),
    );
  }
}

class PinterestGrid extends StatefulWidget {
  @override
  _PinterestGridState createState() => _PinterestGridState();
}

class _PinterestGridState extends State<PinterestGrid> {
  final List<int> items = List.generate(200, (i) => i);
  final controller = ScrollController();
  double previousScroll = 0.0;

  @override
  void initState() {
    final menuModel = Provider.of<_MenuModel>(context, listen: false);
    controller.addListener(() {
      if (controller.offset < 150) {
        return;
      }
      if (previousScroll < controller.offset) {
        menuModel.show = false;
      } else {
        menuModel.show = true;
      }
      previousScroll = controller.offset;
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int count = 2;
    if (MediaQuery.of(context).size.width > 500) {
      count = 3;
    }
    if (MediaQuery.of(context).size.width > 700) {
      count = 4;
    }
    return StaggeredGridView.countBuilder(
      physics: BouncingScrollPhysics(),
      controller: controller,
      crossAxisCount: count,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) => _PinterestItem(index),
      staggeredTileBuilder: (int index) =>
          new StaggeredTile.count(1, index.isEven ? 2 : 3),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }
}

class _PinterestItem extends StatelessWidget {
  final index;

  const _PinterestItem(this.index);

  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<ThemeChanger>(context);

    return new Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: themeChanger.currentTheme.accentColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: new Center(
          child: new CircleAvatar(
            backgroundColor: themeChanger.currentTheme.scaffoldBackgroundColor,
            child: new Text('$index'),
          ),
        ));
  }
}

class _MenuModel with ChangeNotifier {
  bool _show = true;

  bool get show => _show;

  set show(bool value) {
    _show = value;
    notifyListeners();
  }
}
