import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/src/providers/products.provider.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context).settings.arguments;
    final product = Provider.of<Products>(context, listen: false).findById(id);
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(product.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 300,
                child: FadeInImage(
                  fit: BoxFit.fill,
                  placeholder: AssetImage('assets/loading.gif'),
                  image: NetworkImage(product.imageUrl),
                ),
              ),
              SizedBox(height: 10),
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  product.description,
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
