// ignore: implementation_imports
import 'package:flutter/material.dart';

// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:ledger/common/list/adapter_manager.dart';
import 'package:ledger/reader/model/wx_article_list.dart';
import 'package:ledger/reader/model/wx_official_account.dart';
import 'package:ledger/reader/page/wx_official_account_detail_page.dart';
import 'package:url_launcher/url_launcher.dart';

class WXOfficialDelegate extends DelegateHolder<WXOfficialAccount> {
  @override
  Widget build(BuildContext context, WXOfficialAccount data, int position) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(data.name.substring(0, 1).toUpperCase()),
      ),
      title: Text(data.name),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WXOfficialAccountDetailPage(
                      account: data,
                    )));
      },
    );
  }
}

class WXArticleDelegate extends DelegateHolder<WXArticleInfo> {
  @override
  Widget build(BuildContext context, WXArticleInfo data, int position) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(data.title.substring(0, 1).toUpperCase()),
      ),
      title: Text(data.title),
      subtitle: Text(data.niceDate),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        launch(data.link);
      },
    );
  }
}

/* todo 需要显示的元素。
1. 作者
2. 时间
3. 标题
直接使用 ListTile
 */
