import 'package:cubitvideourokrss/src/pages/last_news_page/last_news_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
// https://github.com/Rahiche/sqlite_demo

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text('Финансы', style: TextStyle(color: Colors.black)),
        //   centerTitle: false,
        // ),
        body: const LastNewsPage(),
      ),
    );
  }
}
