import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ledger/common/adapter_manager/adapters.dart';
import 'package:ledger/common/list/list_view.dart';

class FeedPage extends StatelessWidget {
  var adapterManager = FeedAdapterManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: "记账",
        onPressed: () {
          adapterManager.edit().add("Hello").commit();
        },
      ),
      appBar: AppBar(
        title: const Text("账本"),
      ),
      body: LokiListView(adapterManager),
    );
  }
}
