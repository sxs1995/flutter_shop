import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  final Widget child;

  HomePage({Key key, this.child}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String homePageContent = '正在获取数据';

  @override
  void initState() {
    getHomePageContent().then((val) {
      setState(() {
        homePageContent = val.toString();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('百姓生活家'),
        ),
        body: FutureBuilder(
          future: getHomePageContent(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = json.decode(snapshot.data.toString());
              List<Map> swiper = (data['data']['slides'] as List).cast();
              return Column(
                children: <Widget>[SwiperDiy(swiperDataList: swiper)],
              );
            } else {
              return Center(
                child: Text('加载中...'),
              );
            }
          },
        ));
  }
}

//首页轮播组件
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;

  SwiperDiy({Key key, this.swiperDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 166.5,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return new Image.network(
            "${swiperDataList[index]['image']}",
            fit: BoxFit.fill,
          );
        },
        itemCount: 3,
        pagination: new SwiperPagination(margin: new EdgeInsets.all(5.0)),
        viewportFraction: 0.8,
        autoplay: true,
      ),
    );
  }
}
