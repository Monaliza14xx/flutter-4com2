import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: '4COM2 - APP'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.btnFunc,
      required this.btnColor,
      required this.btnText})
      : super(key: key);
  final Function() btnFunc;
  final Color btnColor;
  final String btnText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: btnFunc,
        style: ElevatedButton.styleFrom(
          primary: btnColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        child: Text(btnText));
  }
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
            Image.network(urlIamge),
            const Text(
              'ຈຳນວນ',
              style: TextStyle(fontSize: 20),
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _doubleCounter() {
    setState(() {
      _counter = _counter * 2;
    });
  }
}
