import 'package:flutter/material.dart';
import 'package:shoesapp/src/pages/shoe_desc_page.dart';
import 'package:shoesapp/src/widgets/custom_widgets.dart';

class AddCartButton extends StatelessWidget {
  final double total;

  const AddCartButton({@required this.total});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      width: double.infinity,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Text(
            '\$${total.toStringAsFixed(1)}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          Spacer(),
          OrangeButton(
            onPressed: () {},
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}
