import 'package:flutter/material.dart';
import 'package:ledger/common/list/list_view.dart';
import 'package:ledger/reader/config/constants.dart';
import 'package:ledger/reader/config/reader_net_service.dart';
import 'package:ledger/reader/config/scene.dart';
import 'package:ledger/reader/model/wx_official_account.dart';

class WXOfficialAccountDetailPage extends StatefulWidget {
  final WXOfficialAccount account;

  WXOfficialAccountDetailPage({Key key, this.account}) : super(key: key);

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
    ReaderNetService.getWXArticleList(widget.account.id).then(print);
//        mAdapterManager.edit().clear().addAll(result.data).commit());
    super.initState();
  }

  Widget internalBuild(BuildContext context) {
    return widget.account == null
        ? Container(
            child: Center(
              child: Text("未知异常"),
            ),
            color: Colors.white,
          )
        : Scaffold(
            body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 200.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(
                      widget.account.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                    background: Center(
                      child: CircleAvatar(
                        child: Text(
                          widget.account.name.substring(0, 1).toUpperCase(),
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        radius: 50,
                      ),
                    ),
                  ),
                  actions: [
                    IconButton(
                        tooltip: 'Search',
                        icon: new Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        onPressed: () =>
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("搜索历史文章"),
                            ))),
                    IconButton(
                        tooltip: 'More',
                        icon: new Icon(
                          Icons.more_horiz,
                          color: Colors.white,
                        ),
                        onPressed: () =>
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("更多操作"),
                            )))
                  ],
                )
              ];
            },
            body: buildLokiListView(),
          ));
  }
}

/**/
