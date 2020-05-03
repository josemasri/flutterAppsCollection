import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

enum DotsPosition { up, down }

class SlideShow extends StatelessWidget {
  final List<Widget> slides;
  final DotsPosition dotsPosition;
  final Color selectedDotColor;
  final Color unselectedDotColor;
  final Color dotBorderColor;
  final double selectedDotSize;
  final double unselectedDotSize;

  const SlideShow({
    @required this.slides,
    this.dotsPosition = DotsPosition.down,
    this.selectedDotColor = Colors.blue,
    this.unselectedDotColor = Colors.grey,
    this.dotBorderColor = Colors.black54,
    this.selectedDotSize = 12,
    this.unselectedDotSize = 12,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _SlideShowModel(),
      child: SafeArea(
        child: Center(
          child: Builder(
            builder: (BuildContext context) {
              final slideShowModel = Provider.of<_SlideShowModel>(context);
              slideShowModel.selectedDotColor = selectedDotColor;
              slideShowModel.unselectedDotColor = unselectedDotColor;
              slideShowModel.dotBorderColor = dotBorderColor;
              slideShowModel.selectedDotSize = selectedDotSize;
              slideShowModel.unselectedDotSize = unselectedDotSize;

              return Column(
                children: <Widget>[
                  if (dotsPosition == DotsPosition.up) _Dots(slides.length),
                  Expanded(child: _Slides(slides)),
                  if (dotsPosition == DotsPosition.down) _Dots(slides.length),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Slides extends StatefulWidget {
  final List<Widget> slides;

  const _Slides(this.slides);

  @override
  __SlidesState createState() => __SlidesState();
}

class __SlidesState extends State<_Slides> {
  final pageViewController = PageController();

  @override
  void initState() {
    final sliderModel = Provider.of<_SlideShowModel>(context, listen: false);
    pageViewController.addListener(() {
      if (sliderModel.currentPage != pageViewController.page.ceil()) {
        sliderModel.currentPage = pageViewController.page.ceil();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView(
        controller: pageViewController,
        children: widget.slides.map((slide) => _Slide(slide)).toList(),
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  final int length;

  const _Dots(this.length);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      curve: Curves.bounceIn,
      width: double.infinity,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(length, (index) => _Dot(index)),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;

  const _Dot(this.index);
  @override
  Widget build(BuildContext context) {
    final sliderModel = Provider.of<_SlideShowModel>(context);

    double size = sliderModel.unselectedDotSize;
    Color color = sliderModel.unselectedDotColor;
    if (sliderModel.currentPage == index) {
      size = sliderModel.selectedDotSize;
      color = sliderModel.selectedDotColor;
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: sliderModel.dotBorderColor),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Widget child;

  const _Slide(this.child);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(30),
      child: child,
    );
  }
}

class _SlideShowModel with ChangeNotifier {
  int _currentPage = 0;
  Color selectedDotColor = Colors.blue;
  Color unselectedDotColor = Colors.grey;
  Color dotBorderColor = Colors.black;
  double selectedDotSize = 12;
  double unselectedDotSize = 12;

  int get currentPage => _currentPage;

  set currentPage(int page) {
    _currentPage = page;
    notifyListeners();
  }
}
