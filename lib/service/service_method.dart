import 'package:dio/dio.dart';
import 'dart:io';
import '../config/serviece_url.dart';
import 'dart:async';

// {formdata可选参数}
Future request(url, {formdata}) async {
  print('开始获取数据');
  try {
    Response response;
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded");
    if (formdata == null) {
      response = await dio.post(servicePath[url]);
    } else {
      response = await dio.post(servicePath[url], data: formdata);
    }
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('接口异常');
    }
  } catch (e) {
    return print(e);
  }
}

// 获取首页主体内容
Future getHomePageContent() async {
  print('开始获取首页数据');
  try {
    Response response;
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded");
    var formData = {'lon': '115.02932', 'lat': '35.76189'};
    response = await dio.post(servicePath['homePageContent'], data: formData);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('接口异常');
    }
  } catch (e) {
    return print(e);
  }
}

// 获取火爆专区的商品
Future getHomePageBelowConten() async {
  print('开始火爆专区数据.....');
  try {
    Response response;
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded");
    int page = 1;
    response = await dio.post(servicePath['homepagebelowConten'], data: page);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('接口异常');
    }
  } catch (e) {
    return print(e);
  }
}
