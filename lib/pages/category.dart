import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  final Widget child;

  CategoryPage({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('分类'),
      ),
    );
  }
}
