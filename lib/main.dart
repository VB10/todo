import 'package:flutter/material.dart';
import 'package:todoapp/ui/view/home_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: "/",
      routes: {"/": (context) => HomeView()},
    );
  }
}
