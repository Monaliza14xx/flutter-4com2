import 'package:flutter/material.dart';
import '../button/custom_button.dart';
import 'second_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

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
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => const SecondPage()),
    );
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
            )
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
