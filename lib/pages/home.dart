import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  final Widget child;

  HomePage({Key key, this.child}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController typeConroller = TextEditingController();

  String showText = '欢迎您来到美好人间会所';

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      appBar: AppBar(
        title: Text('美好人间'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            new TextField(
              controller: typeConroller,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10.0),
                labelText: '美女类型',
                helperText: '请输入你喜欢的类型',
              ),
              autofocus: false,
            ),
            new RaisedButton(
              onPressed: () {
                _choiceAction();
              },
              child: Text('选择完毕'),
            ),
            Text(
              showText,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            )
          ],
        ),
      ),
    ));
  }

  void _choiceAction() {
    print('开始选择你喜欢的类型.........');
    if (typeConroller.text.toString() == '') {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('美女类型不能为空'),
              ));
    } else {
      getHttp(typeConroller.text.toString()).then((val) => {
            setState(() {
              showText = val['data']['name'].toString();
            })
          });
    }
  }

  void initState() {
    super.initState();
  }

  Future getHttp(String TypeText) async {
    try {
      var data = {'name': TypeText};
      Response response = await Dio().get(
          'https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian',
          queryParameters: data);
      return response.data;
    } catch (e) {
      return print(e);
    }
  }
}
