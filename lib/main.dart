import 'package:flutter/material.dart';
import './pages/index_page.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  final Widget child;

  Myapp({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: '百姓生活家',
        // home:
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.pink),
        home: IndexPage(),
      ),
    );
  }
}
