// ignore: implementation_imports
import 'package:flutter/material.dart';

// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:ledger/common/list/adapter_manager.dart';
import 'package:ledger/common/list/banner.dart';
import 'package:ledger/reader/model/article_banner.dart';
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

class BannerItemDelegate extends DelegateHolder<BannerItemData> {
  @override
  Widget build(BuildContext context, BannerItemData data, int position) {
    return GestureDetector(
      child: Stack(
        fit: StackFit.loose,
        children: [
          ConstrainedBox(
            child: Image.network(
              data.imagePath,
              fit: BoxFit.fill,
            ),
            constraints: BoxConstraints.expand(),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              data.title,
            ),
          )
        ],
      ),
      onTap: () {
        launch(data.url);
      },
    );
  }
}

/**/

class BannerDelegate extends DelegateHolder<ArticleBanner> {
  @override
  Widget build(BuildContext context, ArticleBanner data, int position) {
    return BannerDelegateWidget(data);
  }
}

// ignore: must_be_immutable
class BannerDelegateWidget extends StatefulWidget {
  ArticleBanner articleBanner;

  BannerDelegateWidget(this.articleBanner);

  @override
  State<StatefulWidget> createState() => BannerDelegateState();
}

class BannerDelegateState extends BaseBannerState<BannerDelegateWidget> {
  BannerDelegateState()
      : super((adapterManager) {
          adapterManager.registerDelegate(BannerItemDelegate());
        });

  @override
  void initState() {
    mAdapterManager.edit().addAll(widget.articleBanner.data).commit();
    super.initState();
  }
}
