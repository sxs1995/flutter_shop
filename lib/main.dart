import 'package:flutter/material.dart';
import './pages/index_page.dart';
import 'package:provide/provide.dart';
import 'provide/child_category.dart';
import 'provide/category_goodslist.dart';

void main() {
  var childCategory = ChildCategory();
  var categotyGoodsListProvide = GoodsListProvide();
  var providers = Providers();
  providers
    ..provide(Provider<ChildCategory>.value(childCategory))
    ..provide(Provider<GoodsListProvide>.value(categotyGoodsListProvide));
  runApp(
    ProviderNode(
      child: Myapp(),
      providers: providers,
    ),
  );
}

class Myapp extends StatelessWidget {
  final Widget child;

  Myapp({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        // home:
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.pink),
        home: IndexPage(),
      ),
    );
  }
}
