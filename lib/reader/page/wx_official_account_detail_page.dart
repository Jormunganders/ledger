import 'package:flutter/material.dart';
import 'package:ledger/common/list/list_view.dart';
import 'package:ledger/reader/config/constants.dart';
import 'package:ledger/reader/config/scene.dart';

class WXOfficialAccountDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WXOfficialAccountDetailState();
}

class _WXOfficialAccountDetailState
    extends BaseLokiListState<WXOfficialAccountDetailPage> {
  _WXOfficialAccountDetailState()
      : super((adapterManager) {
//    adapterManager.registerDelegate(new WXOfficialDelegate());
        }, key: Scene.WX_OFFICIAL_ACCOUNT_DETAIL.toString());

  @override
  void initState() {
//    ReaderNetService.getWXOfficialAccountList().then((result) =>
//        mAdapterManager.edit().clear().addAll(result.data).commit());
    super.initState();
  }

  Widget internalBuild(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(PAGE_TITLE.WX_OFFICIAL_ACCOUNT_DETAIL),
      ),
      body: buildLokiListView(),
    );
  }
}
