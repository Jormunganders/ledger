// 微信公众号列表页
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ledger/common/list/adapter_manager.dart';
import 'package:ledger/common/list/list_view.dart';
import 'package:ledger/reader/config/constants.dart';
import 'package:ledger/reader/config/reader_net_service.dart';
import 'package:ledger/reader/config/scene.dart';
import 'package:ledger/reader/delegate/wx_official_account_delegate.dart';
import 'package:provider/provider.dart';

class WXOfficialAccountListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WXOfficialAccountListState();
}

class _WXOfficialAccountListState extends State<WXOfficialAccountListPage> {
  final _adapterManager =
      AdapterManager(Scene.WX_OFFICIAL_ACCOUNT_LIST.toString())
          .registerDelegate(new WXOfficialDelegate());

  @override
  void initState() {
    ReaderNetService.getWXOfficialAccountList()
        .then((result) => _adapterManager.edit().clear().addAll(result.data).commit());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AdapterManager>.value(
      value: _adapterManager,
      child: internalBuild(context),
    );
  }

  Widget internalBuild(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(PAGE_TITLE.WX_OFFICIAL_ACCOUNT_LIST),
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

/*floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: "记账",
        onPressed: () {
          print("AdapterManager is ${_adapterManager.hashCode}");
          _adapterManager.edit().add(index).add("HelloWorld").commit();
          index++;
        },
      ),*/
