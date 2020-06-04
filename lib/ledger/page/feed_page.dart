import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ledger/common/delegate/delegates.dart';
import 'package:ledger/common/list/adapter_manager.dart';
import 'package:ledger/common/list/list_view.dart';
import 'package:provider/provider.dart';

import '../../common/strings.dart';

class FeedPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FeedState();
}

class _FeedState extends BaseLokiListState<FeedPage> {
  var index = 0;

  _FeedState()
      : super((adapterManager) {
          adapterManager
              .registerDelegate(new TextDelegate())
              .registerDelegate(new IntDelegate());
        }, key: "FeedPage");

  Widget internalBuild(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: "记账",
        onPressed: () {
          print("AdapterManager is ${mAdapterManager.hashCode}");
          mAdapterManager.edit().add(index).add("HelloWorld").commit();
          index++;
        },
      ),
      appBar: AppBar(
        title: const Text(feed_title),
      ),
      body: buildLokiListView(),
    );
  }
}

/*LokiListView(
        FeedAdapterManager(),
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
      )*/
