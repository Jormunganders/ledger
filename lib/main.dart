import 'package:flutter/material.dart';
import 'package:ledger/common/app_config.dart';
import 'package:ledger/common/net/net.dart';
import 'package:ledger/common/page/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppConfig.init(context);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
