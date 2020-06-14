import 'package:dio/dio.dart';
import 'package:ledger/common/net/net.dart';
import 'package:ledger/common/net/net_engine.dart';
import 'package:ledger/reader/config/constants.dart';
import 'package:ledger/reader/config/scene.dart';
import 'package:ledger/reader/model/article_banner.dart';
import 'package:ledger/reader/model/wx_article_list.dart';
import 'package:ledger/reader/model/wx_official_account.dart';

class ReaderNetService {
  static Future<WXOfficialAccountList> getWXOfficialAccountList() async {
    CommonResponse response =
        await NetEngineFactory.getEngine().get(URL.GET_WX_ACCOUNT_LIST);
    handleNetResponse(response,
        url: URL.GET_WX_ACCOUNT_LIST,
        message: "获取公众号列表",
        scene: Scene.WX_OFFICIAL_ACCOUNT_LIST.toString());
    return WXOfficialAccountList.fromJson(response.data);
  }

  static Future<WXArticleList> getWXArticleList(int id, {int page = 1}) async {
    String url = URL.getWXArticleListUrl(id, page);
    CommonResponse response = await NetEngineFactory.getEngine().get(url);
    handleNetResponse(response,
        url: url,
        message: "获取公众号历史数据",
        scene: Scene.WX_OFFICIAL_ACCOUNT_DETAIL.toString());
    return WXArticleList.fromJson(response.data);
  }

  static Future<WXArticleList> searchWXArticle(int id, String key,
      {int page = 1}) async {
    String url = URL.getSearchWXArticleUrl(id, page, key);
    CommonResponse response = await NetEngineFactory.getEngine().get(url);
    handleNetResponse(response,
        url: url,
        message: "搜索公众号历史数据",
        scene: Scene.WX_OFFICIAL_ACCOUNT_SEARCH.toString());
    return WXArticleList.fromJson(response.data);
  }

  static Future<ArticleBanner> getBannerData() async {
    String url = URL.GET_BANNER_DATA;
    CommonResponse response = await NetEngineFactory.getEngine().get(url);
    handleNetResponse(response,
        url: url,
        message: "获取 Banner 数据",
        scene: Scene.WX_OFFICIAL_ACCOUNT_LIST.toString());
    return ArticleBanner.fromJson(response.data);
  }

// todo 抽出公用方法到 common 里

}
