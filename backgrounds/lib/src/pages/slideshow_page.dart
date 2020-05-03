import 'package:backgrounds/src/theme/theme.dart';
import 'package:backgrounds/src/widgets/slideshow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SlideShowPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isLarge;
    if (MediaQuery.of(context).size.height > 500) {
      isLarge = true;
    } else {
      isLarge = false;
    }
    final children = [
      Expanded(child: MiSlideshow()),
      Expanded(child: MiSlideshow())
    ];
    return Scaffold(
      body: isLarge ? Column(children: children) : Row(children: children),
    );
  }
}

class MiSlideshow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<ThemeChanger>(context);
    return SlideShow(
      selectedDotSize: 25,
      unselectedDotSize: 12,
      selectedDotColor: themeChanger.darkTheme
          ? themeChanger.currentTheme.accentColor
          : Color(0xffff5a7e),
      unselectedDotColor: Colors.grey,
      dotsPosition: DotsPosition.down,
      dotBorderColor: Colors.transparent,
      slides: <Widget>[
        SvgPicture.asset('assets/svgs/slide-1.svg'),
        SvgPicture.asset('assets/svgs/slide-2.svg'),
        SvgPicture.asset('assets/svgs/slide-3.svg'),
        SvgPicture.asset('assets/svgs/slide-4.svg'),
        SvgPicture.asset('assets/svgs/slide-5.svg'),
      ],
    );
  }
}
