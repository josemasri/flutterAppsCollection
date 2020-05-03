import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoesapp/src/models/shoe_model.dart';

import 'package:shoesapp/src/pages/shoe_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: ShoeModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ShesApp',
        home: ShoePage(),
      ),
    );
  }
}
