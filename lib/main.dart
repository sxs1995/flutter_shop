import 'package:flutter/material.dart';
import './pages/index_page.dart';
import 'package:provide/provide.dart';
import 'provide/child_category.dart';
import 'provide/category_goodslist.dart';
import 'package:fluro/fluro.dart';
import './routers/routes.dart';
import './routers/application.dart';

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
  @override
  Widget build(BuildContext context) {
    final router = Router();
    Routes.configrureRoutes(router);
    Appcalition.router = router;

    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        onGenerateRoute: Appcalition.router.generator,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.pink),
        home: IndexPage(),
      ),
    );
  }
}
