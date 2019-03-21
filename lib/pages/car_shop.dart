import 'package:flutter/material.dart';

class ShopCarPage extends StatelessWidget {
  final Widget child;

  ShopCarPage({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('购物车'),
      ),
    );
  }
}
