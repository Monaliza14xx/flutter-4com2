import 'package:flutter/material.dart';
import 'components/navbar/navigation_bar.dart';
import 'components/pages/signIn.dart';

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
      // home: const NavigationBarApp(),
      initialRoute: '/singIn',
      routes: {
        '/': (context) => const NavigationBarApp(),
        '/singIn': (context) => const SignInPage(),
      },
    );
  }
}