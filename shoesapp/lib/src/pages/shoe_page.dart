import 'package:flutter/material.dart';
import 'package:shoesapp/src/helpers/helpers.dart';
import 'package:shoesapp/src/pages/shoe_desc_page.dart';
import 'package:shoesapp/src/widgets/custom_widgets.dart';

class ShoePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    cambiarStatusDark();
    return Scaffold(
      body: Column(
        children: <Widget>[
          CustomAppBar(text: 'For You'),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  GestureDetector(
                      child: Hero(tag: 1, child: ShoeSize()),
                      onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => ShoeDescPage()))),
                  ShoeDescription(
                    title: 'Nike Air Max 720',
                    description:
                        '''The Nike Air Max 720 goes bigger than ever before with Nike's taller Air unit yet, offering more air underfoot for unimaginable, all-day comfort. Has Air Max gone too far? We hope so.''',
                  ),
                ],
              ),
            ),
          ),
          AddCartButton(total: 180.0),
        ],
      ),
    );
  }
}
