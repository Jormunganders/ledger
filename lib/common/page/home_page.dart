import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ledger/common/page/feed_page.dart';

import 'mine_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // todo
    getPageStream().transform<BottomNavigationBarItem>(
        (StreamTransformer<Map<String, dynamic>, BottomNavigationBarItem>
            transformer) {
      return null;
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("账本"),
      ),
      body: null,
      bottomNavigationBar: BottomNavigationBar(items: null
          /*        .transform<BottomNavigationBarItem>(
              StreamTransformer < Map < String, dynamic>>,
              BottomNavigationBarItem > streamTransformer){
      return null;
      }*/

          ),
    );
  }

  Stream<Map<String, dynamic>> getPageStream() {
    StreamController<Map<String, dynamic>> controller = new StreamController();
    controller.sink.add({
      "name": "账本",
      "icon": Icons.book,
      "page": FeedPage,
    });
    controller.sink.add({
      "name": "我",
      "icon": Icons.person,
      "page": MinePage,
    });
    return controller.stream;
  }
}
