import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ledger/common/net/net.dart';
import 'package:ledger/reader/config/reader_net_service.dart';
import 'package:ledger/reader/page/wx_official_account_list_page.dart';

class ReaderHostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(data: READER_THEME_DATA, child: WXOfficialAccountListPage());
  }
}

// ignore: non_constant_identifier_names
final READER_THEME_DATA = new ThemeData(
  primaryColor: Colors.teal,
  accentColor: Colors.redAccent,
);
