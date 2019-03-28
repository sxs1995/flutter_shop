import 'package:flutter/material.dart';
import '../model/categoryGoodsList.dart';

class GoodsListProvide with ChangeNotifier {
  List<CategoryListData> goodslist = [];

  // 点击大类时更换商品列表
  getGoodsList(List<CategoryListData> list) {
    goodslist = list;
    notifyListeners();
  }
}
