import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ledger/common/page/feed_page.dart';

import 'mine_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  int _currentIndex = 0;

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
      body: getPageList()[_currentIndex]["page"],
      bottomNavigationBar: BottomNavigationBar(
        items: getPageList()
            .map<BottomNavigationBarItem>((Map<String, dynamic> map) {
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

  List<Map<String, dynamic>> getPageList() {
    return [
      {
        "name": "账本",
        "icon": Icons.book,
        "page": FeedPage(),
      },
      {
        "name": "我",
        "icon": Icons.person,
        "page": MinePage(),
      }
    ];
  }
}
