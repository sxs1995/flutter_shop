import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/couter.dart';

class ShopCarPage extends StatelessWidget {
  final Widget child;

  ShopCarPage({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Number(),
            Mybutton(),
          ],
        ),
      ),
    );
  }
}

class Mybutton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          Provide.value<Counter>(context).increment();
        },
        child: Text('递增'),
      ),
    );
  }
}

class Number extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 200.0),
        child: Center(
          child: Text('111'),
        ));
  }
}
