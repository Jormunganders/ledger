import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: "记账",
        onPressed: () {
          print("HelloWorld");
        },
      ),
      appBar: AppBar(
        title: const Text("账本"),
      ),
      body: Center(
        child: Text("等梁旭设计"),
      ),
    );
  }
}
