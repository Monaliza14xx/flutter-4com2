import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../button/custom_button.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _title = "Initial Title";
  late String data = '';

  void mapData(value) {
    setState(() {
      data = value;
    });
  }

  void getData() async {
    var url = Uri.parse('https://sheetdb.io/api/v1/4q5fhwwuonqmj');
    http.Response res = await http.get(url);
    if (res.statusCode == 200) {
      mapData(jsonDecode(utf8.decode(res.bodyBytes)).toString());
      print(data);
    } else {
      print('Failed to fetch data');
    }
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _disincrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  void _goToSecondPage() {
    Navigator.pushNamed(context, '/secondPage',
            arguments: {"title": "Second Page", "value": _counter})
        .then((value) => reciveContext(value));
  }

  void reciveContext(value) {
    setState(() {
      _title = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final urlIamge = _counter >= 10
        ? 'https://x-playground.com/wp-content/uploads/2023/11/0_7c2b07f4-77e5-4d9d-9c2a-db7ac6e99011_900x.jpg'
        : 'https://img4.dhresource.com/webp/m/0x0/f3/albu/km/o/18/928f8698-7b9b-437f-9ae2-4b1b10c1adb1.jpg';

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_title, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            Image.network(urlIamge, width: 200, height: 200),
            const Text(
              'ຈຳນວນ',
              style: TextStyle(fontSize: 20, fontFamily: "NotoSansLaoLoop"),
            ),
            Text(
              '$_counter',
              style: const TextStyle(fontSize: 50, color: Colors.orange),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CustomButton(
                    btnFunc: _incrementCounter,
                    btnColor: Colors.green,
                    btnText: "ເພີ່ມຄ່າ",
                  ),
                  CustomButton(
                    btnFunc: _disincrementCounter,
                    btnColor: Colors.red,
                    btnText: "ລົບຄ່າ",
                  ),
                  CustomButton(
                    btnFunc: _resetCounter,
                    btnColor: Colors.blue,
                    btnText: "ຄືນຄ່າ",
                  ),
                  CustomButton(
                    btnFunc: _doubleCounter,
                    btnColor: Colors.orange,
                    btnText: "x2",
                  ),
                ]),
            CustomButton(
              btnFunc: _goToSecondPage,
              btnColor: Colors.cyan,
              btnText: "Go to second page",
            ),
            CustomButton(
              btnFunc: getData,
              btnColor: Colors.green,
              btnText: "Fetch Data",
            ),
            Text(data),
          ],
        ),
      ),
    );
  }

  _doubleCounter() {
    setState(() {
      _counter = _counter * 2;
    });
  }
}
