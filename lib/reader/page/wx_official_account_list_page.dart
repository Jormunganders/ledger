// 微信公众号列表页
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ledger/common/list/adapter_manager.dart';
import 'package:ledger/common/list/list_view.dart';
import 'package:ledger/reader/config/constants.dart';
import 'package:ledger/reader/config/reader_net_service.dart';
import 'package:ledger/reader/config/scene.dart';
import 'package:ledger/reader/delegate/reader_delegates.dart';
import 'package:provider/provider.dart';

class WXOfficialAccountListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WXOfficialAccountListState();
}

class _WXOfficialAccountListState
    extends BaseLokiListState<WXOfficialAccountListPage> {
  _WXOfficialAccountListState()
      : super((adapterManager) {
          adapterManager.registerDelegate(new WXOfficialDelegate());
        }, key: Scene.WX_OFFICIAL_ACCOUNT_LIST.toString());

  @override
  void initState() {
    ReaderNetService.getWXOfficialAccountList().then((result) =>
        mAdapterManager.edit().clear().addAll(result.data).commit());
    super.initState();
  }

  Widget internalBuild(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(PAGE_TITLE.WX_OFFICIAL_ACCOUNT_LIST),
      ),
      body: buildLokiListView(),
    );
  }
}

/*floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: "记账",
        onPressed: () {
          print("AdapterManager is ${_adapterManager.hashCode}");
          _adapterManager.edit().add(index).add("HelloWorld").commit();
          index++;
        },
      ),*/
