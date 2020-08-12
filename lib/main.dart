import 'package:flutter/material.dart';
import 'file:///C:/Users/jille/StudioProjects/fl_loja_virtual/lib/view/home/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        fontFamily: 'JosefinSans',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: HomePage.tag,
      routes: {
        HomePage.tag : (context) =>HomePage(),
      },
    );
  }
}

