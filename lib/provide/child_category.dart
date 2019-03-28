import 'package:flutter/material.dart';
import '../model/category.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCtategoryList = []; //子类列表
  int childIndex = 0; //子类高亮索引
  String categoryId = '4'; //大类Id
  String subId = '';
  int page = 1; //列表页数
  String noMoreText = ''; //下拉无数据时文字
  // 大类切换效果
  getChildCategory(List<BxMallSubDto> list, String id) {
    childIndex = 0;
    categoryId = id;
    page = 1;
    noMoreText = '';
    BxMallSubDto all = BxMallSubDto();
    all.mallCategoryId = '00';
    all.mallSubId = '00';
    all.mallSubName = '全部';
    all.comments = '';
    childCtategoryList = [all];
    childCtategoryList.addAll(list);
    notifyListeners();
  }

  // 改变子类索引
  changeChildIndex(int index, String id) {
    subId = id;
    page = 1;
    noMoreText = '';
    childIndex = index;
    notifyListeners();
  }

  //增加page的方法
  addpage() {
    page++;
  }

  //改变没内容提示
  changeText(String text) {
    noMoreText = text;
    notifyListeners();
  }
}
