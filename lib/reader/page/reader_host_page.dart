import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ledger/common/net/net.dart';
import 'package:ledger/reader/config/reader_net_service.dart';

class ReaderHostPage extends StatelessWidget {
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
              onPressed: () async {
                var list = await ReaderNetService.getWXOfficialAccountList();
                print(list.data[0].name);
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
