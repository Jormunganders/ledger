import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ledger/common/app_config.dart';
import 'package:ledger/common/page/home_page.dart';

import 'common/utils.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // web 不支持
//    AppConfig.init(context);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
