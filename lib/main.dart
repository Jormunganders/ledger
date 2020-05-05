import 'package:flutter/material.dart';
import 'package:ledger/common/page/account_page.dart';
import 'package:ledger/common/page/home_page.dart';
import 'package:ledger/common/strings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // web 不支持
//    AppConfig.init(context);
    return MaterialApp(
      title: feed_title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
