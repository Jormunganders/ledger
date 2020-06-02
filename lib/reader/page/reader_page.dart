import 'package:flutter/material.dart';
import 'package:ledger/common/net/net.dart';

class ReaderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: READER_THEME_DATA,
        child: Scaffold(
          appBar: AppBar(
            title: Text("御书房"),
          ),
          body: Center(
            child: RaisedButton(
              child: Text("Get"),
              onPressed: () {
                print("Start Get");
                getDio()
                    .get("http://www.baidu.com")
                    .then((value) => print);
              },
            ),
          ),
        ));
  }
}

// ignore: non_constant_identifier_names
final READER_THEME_DATA = new ThemeData(
  primaryColor: Colors.teal,
  accentColor: Colors.redAccent,
);
