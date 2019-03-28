import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'dart:convert';
import '../model/category.dart';
import '../model/categoryGoodsList.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../provide/child_category.dart';
import '../provide/category_goodslist.dart';

class CategoryPage extends StatefulWidget {
  final Widget child;

  CategoryPage({Key key, this.child}) : super(key: key);

  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品分类'),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
            Column(
              children: <Widget>[RightCategoryNav(), CategoryGoods()],
            ),
          ],
        ),
      ),
    );
  }
}

//左侧大类导航
class LeftCategoryNav extends StatefulWidget {
  final Widget child;

  LeftCategoryNav({Key key, this.child}) : super(key: key);

  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List list = [];
  var listIndex = 0;

  @override
  void initState() {
    _getCategory();
    _getGoodsList();
    super.initState();
  }

  // 根据类别获取商品列表
  void _getGoodsList({String categoryId}) async {
    var data = {
      'categoryId': categoryId == null ? '4' : categoryId,
      'categorySubId': '',
      'page': '1',
    };

    await request('getMallGoods', formdata: data).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodslist = CategoryGoodsListModel.fromJson(data);
      Provide.value<GoodsListProvide>(context).getGoodsList(goodslist.data);
    });
  }

  // 获取左侧类别列表
  void _getCategory() async {
    await request('getCategory').then((val) {
      var data = json.decode(val.toString());
      CategoryModel category = CategoryModel.fromJson(data);
      setState(() {
        list = category.data;
      });
      Provide.value<ChildCategory>(context)
          .getChildCategory(list[0].bxMallSubDto);
      // List.data.forEach((item) => print(item.mallCategoryName));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
          border: Border(right: BorderSide(width: 0.5, color: Colors.black12))),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return _leftInkwell(index);
        },
      ),
    );
  }

  Widget _leftInkwell(int index) {
    bool isClick = false;
    isClick = (index == listIndex) ? true : false;
    return InkWell(
      onTap: () {
        setState(() {
          listIndex = index;
        });
        var childList = list[index].bxMallSubDto;
        var categoryId = list[index].mallCategoryId;
        Provide.value<ChildCategory>(context).getChildCategory(childList);
        _getGoodsList(categoryId: categoryId);
      },
      child: Container(
          height: ScreenUtil().setHeight(100),
          padding: EdgeInsets.only(left: 10.0, top: 16.0),
          decoration: BoxDecoration(
            color: isClick ? Color.fromRGBO(236, 236, 236, 1.0) : Colors.white,
            border:
                Border(bottom: BorderSide(width: 0.5, color: Colors.black12)),
          ),
          child: Text(
            list[index].mallCategoryName,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              color: isClick ? Colors.pink : Colors.black,
            ),
          )),
    );
  }
}

// 右侧顶部导航
class RightCategoryNav extends StatefulWidget {
  final Widget child;

  RightCategoryNav({Key key, this.child}) : super(key: key);

  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {
  String itenClick = '00';
  Widget _rightInkWell(BxMallSubDto item) {
    bool isClick = (itenClick == item.mallSubId) ? true : false;
    return InkWell(
      onTap: () {
        setState(() {
          itenClick = item.mallSubId;
        });
        print(item.mallSubId);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Text(
          item.mallSubName,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28),
            color: isClick ? Colors.pink : Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategory>(
      builder: (context, child, childCtategory) {
        return Container(
          height: ScreenUtil().setHeight(80),
          width: ScreenUtil().setWidth(570),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                width: 0.5,
                color: Colors.black12,
              ),
            ),
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: childCtategory.childCtategoryList.length,
            itemBuilder: (BuildContext context, int index) {
              return _rightInkWell(childCtategory.childCtategoryList[index]);
            },
          ),
        );
      },
    );
  }
}

// 商品列表,可以上拉加载
class CategoryGoods extends StatefulWidget {
  final Widget child;

  CategoryGoods({Key key, this.child}) : super(key: key);

  _CategoryGoodsState createState() => _CategoryGoodsState();
}

class _CategoryGoodsState extends State<CategoryGoods> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provide<GoodsListProvide>(
      builder: (context, child, data) {
        return Container(
          width: ScreenUtil().setWidth(570),
          height: ScreenUtil().setHeight(978),
          child: ListView.builder(
            itemCount: data.goodslist.length,
            itemBuilder: (BuildContext context, int index) {
              return _listWidget(data.goodslist[index]);
            },
          ),
        );
      },
    );
  }

  // 商品图片
  Widget _goodsImage(data) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(data.image),
    );
  }

  Widget _goodsName(data) {
    return Container(
      width: ScreenUtil().setWidth(370),
      padding: EdgeInsets.all(5.0),
      child: Text(
        data.goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(28),
        ),
      ),
    );
  }

  Widget _goodsPrice(data) {
    return Container(
      width: ScreenUtil().setWidth(370),
      margin: EdgeInsets.only(top: 20.0),
      child: Row(
        children: <Widget>[
          Text(
            '价格:￥${data.presentPrice}',
            style:
                TextStyle(color: Colors.pink, fontSize: ScreenUtil().setSp(30)),
          ),
          Container(
            margin: EdgeInsets.only(left: 10.0),
            child: Text(
              '￥${data.oriPrice}',
              style: TextStyle(
                color: Colors.black26,
                decoration: TextDecoration.lineThrough,
                fontSize: ScreenUtil().setSp(24),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _listWidget(data) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 0.5,
              color: Colors.black12,
            ),
          ),
        ),
        child: Row(
          children: <Widget>[
            _goodsImage(data),
            Column(
              children: <Widget>[
                _goodsName(data),
                _goodsPrice(data),
              ],
            )
          ],
        ),
      ),
    );
  }
}
