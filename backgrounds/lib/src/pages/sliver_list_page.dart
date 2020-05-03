import 'dart:math';

import 'package:backgrounds/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SliverListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _MainScroll(),
          Positioned(
            bottom: -10,
            right: 0,
            child: _BotonNewList(),
          ),
        ],
      ),
    );
  }
}

class _BotonNewList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final themeChanger = Provider.of<ThemeChanger>(context);
    return ButtonTheme(
      height: 100,
      minWidth: size.width * 0.9,
      child: RaisedButton(
        color: themeChanger.darkTheme
            ? themeChanger.currentTheme.accentColor
            : Color(0xffFF5C5C),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(50))),
        onPressed: () {},
        child: Text(
          'CREATE NEW LIST',
          style: TextStyle(
            color: themeChanger.currentTheme.scaffoldBackgroundColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
          ),
        ),
      ),
    );
  }
}

class _MainScroll extends StatelessWidget {
  final items = [
    _ListItem('Orange', Color(0xffF08F66)),
    _ListItem('Family', Color(0xffF2A38A)),
    _ListItem('Subscriptions', Color(0xffF7CDD5)),
    _ListItem('Books', Color(0xffFCEBAF)),
    _ListItem('Orange', Color(0xffF08F66)),
    _ListItem('Family', Color(0xffF2A38A)),
    _ListItem('Subscriptions', Color(0xffF7CDD5)),
    _ListItem('Books', Color(0xffFCEBAF)),
    _ListItem('Orange', Color(0xffF08F66)),
    _ListItem('Family', Color(0xffF2A38A)),
    _ListItem('Subscriptions', Color(0xffF7CDD5)),
    _ListItem('Books', Color(0xffFCEBAF)),
    _ListItem('Orange', Color(0xffF08F66)),
    _ListItem('Family', Color(0xffF2A38A)),
    _ListItem('Subscriptions', Color(0xffF7CDD5)),
    _ListItem('Books', Color(0xffFCEBAF)),
  ];
  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<ThemeChanger>(context);
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: <Widget>[
        SliverPersistentHeader(
          floating: true,
          delegate: _SliverHeaderCustomDelegate(
            minHeight: 170,
            maxHeight: 200,
            child: Container(
              alignment: Alignment.centerLeft,
              color: themeChanger.currentTheme.scaffoldBackgroundColor,
              child: _Titulo(),
            ),
          ),
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          ...items,
          SizedBox(
            height: 100,
          )
        ])),
      ],
    );
  }
}

class _SliverHeaderCustomDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverHeaderCustomDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: child,
    );
  }

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  double get minExtent => min(maxHeight, minHeight);

  @override
  bool shouldRebuild(_SliverHeaderCustomDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class _Titulo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<ThemeChanger>(context);
    return Column(
      children: <Widget>[
        SizedBox(
          height: 30,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Text(
            'New',
            style: TextStyle(
              color: themeChanger.darkTheme ? Colors.grey : Color(0xff532128),
              fontSize: 50,
            ),
          ),
        ),
        Stack(
          children: <Widget>[
            SizedBox(
              width: 100,
            ),
            Positioned(
                bottom: 8,
                child: Container(
                    width: 150,
                    height: 8,
                    color: themeChanger.darkTheme
                        ? Colors.grey
                        : Color(0xffF7CDD5))),
            Container(
              child: Text(
                'List',
                style: TextStyle(
                  color: Color(0xffD93A39),
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

// class _TaskList extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       physics: BouncingScrollPhysics(),
//       itemCount: items.length,
//       itemBuilder: (BuildContext context, int i) =>
//           _ListItem(items[i].text, items[i].color),
//     );
//   }
// }

class _ListItem extends StatelessWidget {
  final Color color;
  final String text;

  const _ListItem(this.text, this.color);
  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<ThemeChanger>(context);
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(30),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      height: 130,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: themeChanger.darkTheme ? Colors.grey : color,
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }
}
