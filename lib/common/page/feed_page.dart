import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ledger/common/delegate/delegates.dart';
import 'package:ledger/common/list/adapter_manager.dart';
import 'package:ledger/common/list/list_view.dart';
import 'package:provider/provider.dart';

import '../strings.dart';

class FeedPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FeedState();
}

class _FeedState extends State<FeedPage> {
  final _adapterManager = AdapterManager("FeedPage")
      .registerDelegate(new TextDelegate())
      .registerDelegate(new IntDelegate());

  var index = 0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AdapterManager>.value(
      value: _adapterManager,
      child: internalBuild(context),
    );
  }

  Widget internalBuild(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: "记账",
        onPressed: () {
          print("AdapterManager is ${_adapterManager.hashCode}");
          _adapterManager.edit().add(index).add("HelloWorld").commit();
          index++;
        },
      ),
      appBar: AppBar(
        title: const Text(feed_title),
      ),
      body: buildLokiListView(),
    );
  }

  buildLokiListView() {
    return LokiListView(
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
    );
  }
}

/*LokiListView(
        FeedAdapterManager(),
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
      )*/
