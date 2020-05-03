import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PinterestButton {
  final VoidCallback onPressed;
  final IconData icon;

  PinterestButton({
    @required this.onPressed,
    @required this.icon,
  });
}

class PinterestMenu extends StatelessWidget {
  final List<PinterestButton> items;
  final bool show;

  final Color backgroundColor;
  final Color activeColor;
  final Color inactiveColor;

  const PinterestMenu({
    this.show = true,
    @required this.items,
    this.backgroundColor = Colors.white,
    this.activeColor = Colors.red,
    this.inactiveColor = Colors.blueGrey,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _MenuModel(),
      child: Builder(
        builder: (BuildContext context) {
          final menuModel = Provider.of<_MenuModel>(context);
          menuModel.activeColor = activeColor;
          menuModel.backgroundColor = backgroundColor;
          menuModel.inactiveColor = inactiveColor;
          return AnimatedOpacity(
            duration: Duration(milliseconds: 400),
            opacity: show ? 1 : 0,
            child: _PinterestMenuBackground(
              child: _MenuItems(items),
            ),
          );
        },
      ),
    );
  }
}

class _PinterestMenuBackground extends StatelessWidget {
  final Widget child;

  const _PinterestMenuBackground({@required this.child});

  @override
  Widget build(BuildContext context) {
    final menuModel = Provider.of<_MenuModel>(context, listen: false);

    return Container(
      child: child,
      width: 250,
      height: 60,
      decoration: BoxDecoration(
        color: menuModel.backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(100)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black38,
            blurRadius: 10,
            spreadRadius: -5,
          )
        ],
      ),
    );
  }
}

class _MenuItems extends StatelessWidget {
  final List<PinterestButton> menuItems;

  const _MenuItems(this.menuItems);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        menuItems.length,
        (i) => _PinterestMenuButton(i, menuItems[i]),
      ),
    );
  }
}

class _PinterestMenuButton extends StatelessWidget {
  final int index;
  final PinterestButton item;

  const _PinterestMenuButton(this.index, this.item);

  @override
  Widget build(BuildContext context) {
    final menuModel = Provider.of<_MenuModel>(context);
    Color color = menuModel.inactiveColor;
    double size = 25;
    if (menuModel.selectedItem == index) {
      color = menuModel.activeColor;
      size = 35;
    }
    return GestureDetector(
      onTap: () {
        menuModel.selectedItem = index;
        item.onPressed();
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        child: Icon(
          item.icon,
          size: size,
          color: color,
        ),
      ),
    );
  }
}

class _MenuModel with ChangeNotifier {
  int _selectedItem = 0;
  Color backgroundColor;
  Color activeColor;
  Color inactiveColor;

  int get selectedItem => _selectedItem;

  set selectedItem(int item) {
    _selectedItem = item;
    notifyListeners();
  }
}
