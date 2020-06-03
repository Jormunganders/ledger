import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ledger/ledger/page/feed_page.dart';
import 'package:ledger/ledger/page/mine_page.dart';
import 'package:ledger/reader/page/reader_host_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

const DEFAULT_TAB_INDEX = 1; // 默认选中的 tab

class _HomeState extends State<HomePage> {
  int _currentIndex;

  _HomeState() {
    _currentIndex =
        DEFAULT_TAB_INDEX >= pageList.length ? 0 : DEFAULT_TAB_INDEX;
  }

  var pageList = [
    {
      "name": "账本",
      "icon": Icons.book,
      "page": FeedPage(),
    },
    {
      "name": "御书房",
      "icon": Icons.account_balance,
      "page": ReaderHostPage(),
    },
    {
      "name": "我",
      "icon": Icons.person,
      "page": MinePage(),
    }
  ];

  @override
  Widget build(BuildContext context) {
    /*getPageStream().transform<BottomNavigationBarItem>(StreamTransformer<
        Map<String, dynamic>,
        BottomNavigationBarItem>.fromHandlers(handleData: (data, sink) {
      sink.add(BottomNavigationBarItem(
        icon: Icon(data["icon"]),
        title: Text(data["name"]),
      ));
    }));*/

    return Scaffold(
//      appBar: AppBar(
//        title: const Text("账本"),
//      ),
      body: pageList[_currentIndex]["page"],
      bottomNavigationBar: BottomNavigationBar(
        items:
            pageList.map<BottomNavigationBarItem>((Map<String, dynamic> map) {
          return BottomNavigationBarItem(
            title: Text(map["name"]),
            icon: Icon(map["icon"]),
          );
        }).toList(),
        currentIndex: _currentIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (index) {
          setState(() {
            this._currentIndex = index;
          });
        },
      ),
    );
  }
}
