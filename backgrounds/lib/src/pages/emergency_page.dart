import 'package:animate_do/animate_do.dart';
import 'package:backgrounds/src/theme/theme.dart';
import 'package:backgrounds/src/widgets/big_button.dart';
import 'package:backgrounds/src/widgets/headers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ItemBoton {
  final IconData icon;
  final String texto;
  final Color color1;
  final Color color2;

  ItemBoton(this.icon, this.texto, this.color1, this.color2);
}

class EmergencyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isLarge;
    if (MediaQuery.of(context).size.height > 550) {
      isLarge = true;
    } else {
      isLarge = false;
    }
    final themeChanger = Provider.of<ThemeChanger>(context);
    final items = <ItemBoton>[
      new ItemBoton(FontAwesomeIcons.carCrash, 'Motor Accident',
          Color(0xff6989F5), Color(0xff906EF5)),
      new ItemBoton(FontAwesomeIcons.plus, 'Medical Emergency',
          Color(0xff66A9F2), Color(0xff536CF6)),
      new ItemBoton(FontAwesomeIcons.theaterMasks, 'Theft / Harrasement',
          Color(0xffF2D572), Color(0xffE06AA3)),
      new ItemBoton(FontAwesomeIcons.biking, 'Awards', Color(0xff317183),
          Color(0xff46997D)),
      new ItemBoton(FontAwesomeIcons.carCrash, 'Motor Accident',
          Color(0xff6989F5), Color(0xff906EF5)),
      new ItemBoton(FontAwesomeIcons.plus, 'Medical Emergency',
          Color(0xff66A9F2), Color(0xff536CF6)),
      new ItemBoton(FontAwesomeIcons.theaterMasks, 'Theft / Harrasement',
          Color(0xffF2D572), Color(0xffE06AA3)),
      new ItemBoton(FontAwesomeIcons.biking, 'Awards', Color(0xff317183),
          Color(0xff46997D)),
      new ItemBoton(FontAwesomeIcons.carCrash, 'Motor Accident',
          Color(0xff6989F5), Color(0xff906EF5)),
      new ItemBoton(FontAwesomeIcons.plus, 'Medical Emergency',
          Color(0xff66A9F2), Color(0xff536CF6)),
      new ItemBoton(FontAwesomeIcons.theaterMasks, 'Theft / Harrasement',
          Color(0xffF2D572), Color(0xffE06AA3)),
      new ItemBoton(FontAwesomeIcons.biking, 'Awards', Color(0xff317183),
          Color(0xff46997D)),
    ];

    List<Widget> itemMap = items
        .map((item) => FadeInLeft(
              duration: Duration(milliseconds: 500),
              child: BigButton(
                onPressed: () {},
                text: item.texto,
                firstColor: item.color1,
                secondColor: item.color2,
                icon: item.icon,
                iconColor: themeChanger.currentTheme.scaffoldBackgroundColor,
              ),
            ))
        .toList();

    return Scaffold(
      backgroundColor: themeChanger.currentTheme.scaffoldBackgroundColor,
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Container(
              margin: EdgeInsets.only(top: isLarge ? 220 : 10),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  if (isLarge)
                    SizedBox(
                      height: 80,
                    ),
                  ...itemMap
                ],
              ),
            ),
          ),
          if (isLarge) _Header()
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        IconHeader(
          firstColor: Color(0Xff536CF6),
          secondColor: Color(0xff66A9F2),
          icon: FontAwesomeIcons.plus,
          title: 'Asistencia Médica',
          subtitle: 'Haz solicitado',
        ),
        Positioned(
          right: 0,
          top: 45,
          child: RawMaterialButton(
            onPressed: () {},
            shape: CircleBorder(),
            child: Icon(
              FontAwesomeIcons.ellipsisV,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}

class PageHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconHeader(
      icon: FontAwesomeIcons.plus,
      title: 'Asistencia Médica',
      subtitle: 'Haz solicitado',
      firstColor: Color(0xff526BF6),
      secondColor: Color(0xff67ACF2),
    );
  }
}
