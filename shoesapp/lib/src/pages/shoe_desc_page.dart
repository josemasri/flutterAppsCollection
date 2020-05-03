import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoesapp/src/helpers/helpers.dart';
import 'package:shoesapp/src/models/shoe_model.dart';
import 'package:shoesapp/src/widgets/custom_widgets.dart';

class ShoeDescPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Hero(
                  tag: 1,
                  child: ShoeSize(fullScreen: true),
                ),
                Positioned(
                  top: 50,
                  left: 10,
                  child: IconButton(
                    icon: Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      cambiarStatusDark();
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
            Expanded(
                child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  ShoeDescription(
                    title: 'Nike Air Max 720',
                    description:
                        '''The Nike Air Max 720 goes bigger than ever before with Nike's taller Air unit yet, offering more air underfoot for unimaginable, all-day comfort. Has Air Max gone too far? We hope so.''',
                  ),
                  _TotalBuyNow(),
                  _ColorsAndMore(),
                  _IconButtons(),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class _IconButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      height: 75,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _Icon(
            selected: true,
          ),
          _Icon(
            icon: Icons.shopping_cart,
            index: 2,
          ),
          _Icon(
            icon: Icons.settings,
            index: 3,
          ),
        ],
      ),
    );
  }
}

class _Icon extends StatelessWidget {
  final IconData icon;
  final bool selected;
  final int index;

  const _Icon(
      {this.icon = Icons.favorite, this.selected = false, this.index = 1});
  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      delay: Duration(milliseconds: index * 200),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              spreadRadius: 5,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: IconButton(
          icon: Icon(
            icon,
            color: selected ? Colors.red : Colors.grey.withOpacity(0.5),
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}

class _ColorsAndMore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      height: 50,
      child: Row(
        children: <Widget>[
          _Colors(),
          Spacer(),
          FadeInLeft(
            duration: Duration(milliseconds: 600),
            child: OrangeButton(
              onPressed: () {},
              text: 'More related items',
              width: 140,
              height: 25,
              opacity: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _Colors extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FadeInRight(
      duration: Duration(milliseconds: 1000),
      child: Container(
        width: 100,
        height: 40,
        child: Stack(
          children: <Widget>[
            _Color(
              right: 0,
              color: Colors.green,
              image: 'assets/imgs/verde.png',
            ),
            _Color(
              right: 20,
              color: Colors.orange,
              image: 'assets/imgs/amarillo.png',
            ),
            _Color(
              right: 40,
              color: Colors.blue,
              image: 'assets/imgs/azul.png',
            ),
            _Color(
              right: 60,
              color: Colors.blueGrey,
              image: 'assets/imgs/negro.png',
            ),
          ],
        ),
      ),
    );
  }
}

class _Color extends StatelessWidget {
  final Color color;
  final double right;
  final String image;

  const _Color({
    this.color = Colors.blue,
    @required this.right,
    this.image = 'assets/imgs/azul.png',
  });

  @override
  Widget build(BuildContext context) {
    cambiarStatusLight();
    final shoeModel = Provider.of<ShoeModel>(context);
    final bool selected = shoeModel.image == image;
    return Positioned(
      top: 7.5,
      right: 10 + right,
      child: GestureDetector(
        onTap: () => shoeModel.image = image,
        child: Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
            border:
                selected ? Border.all(color: Colors.black, width: 1) : Border(),
            color: color,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

class _TotalBuyNow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: Row(
        children: <Widget>[
          Text(
            '\$180.0',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          Bounce(
            delay: Duration(seconds: 1),
            from: 8,
            child: OrangeButton(
              onPressed: () {},
              text: 'Buy Now',
              width: 100,
              height: 40,
            ),
          )
        ],
      ),
    );
  }
}
