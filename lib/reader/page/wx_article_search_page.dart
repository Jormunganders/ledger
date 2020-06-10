import 'package:flutter/material.dart';
import 'package:ledger/common/list/list_view.dart';
import 'package:ledger/reader/config/reader_net_service.dart';
import 'package:ledger/reader/delegate/reader_delegates.dart';
import 'package:ledger/reader/model/wx_official_account.dart';

class WXArticleSearchDelegate extends SearchDelegate<String> {
  final WXOfficialAccount account;

  WXArticleSearchDelegate(this.account);

  // 搜索栏右边的图标
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  // 搜索栏左侧的图标和功能
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchResultPage(account, query);
  }

  @override
  Widget buildSuggestions(BuildContext context) =>
      SearchSuggestionPage((key) => query = key);
}

const suggestions = [
  "Java",
  "Android",
  "iOS",
  "Flutter",
  "Kotlin",
  "Clojure",
  "Python",
  "Js",
  "OpenGL",
  "音视频",
  "编解码",
  "C",
  "C++"
];

/// 搜索建议 Page， 这里就设置一些固定的值就好了
class SearchSuggestionPage extends StatelessWidget {
  Function _onTap;

  SearchSuggestionPage(this._onTap);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, position) {
          return ListTile(
            title: Text(suggestions[position]),
            onTap: () {
              _onTap(suggestions[position]);
            },
          );
        },
        itemCount: suggestions.length);
  }
}

class SearchResultPage extends StatefulWidget {
  final WXOfficialAccount account;
  final String searchKey;

  SearchResultPage(this.account, this.searchKey);

  @override
  State<StatefulWidget> createState() => SearchResultState();
}

class SearchResultState extends BaseLokiListState<SearchResultPage> {
  SearchResultState()
      : super((adapterManager) =>
            adapterManager.registerDelegate(new WXArticleDelegate()));

  @override
  void initState() {
    ReaderNetService.searchWXArticle(widget.account.id, widget.searchKey)
        .then((result) {
      mAdapterManager.edit().clear().addAll(result.data.datas).commit();
    });
    super.initState();
  }

  @override
  Widget internalBuild(BuildContext context) {
    return widget.account == null
        ? Container(
            child: Center(
              child: Text("未知异常"),
            ),
            color: Colors.white,
          )
        : buildLokiListView();
  }
}
