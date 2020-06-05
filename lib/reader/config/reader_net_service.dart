import 'package:dio/dio.dart';
import 'package:ledger/common/net/net.dart';
import 'package:ledger/reader/config/constants.dart';
import 'package:ledger/reader/config/scene.dart';
import 'package:ledger/reader/model/wx_article_list.dart';
import 'package:ledger/reader/model/wx_official_account.dart';

class ReaderNetService {
  static Future<WXOfficialAccountList> getWXOfficialAccountList() async {
    Response response = await globalDio().get(URL.GET_WX_ACCOUNT_LIST);
    handleNetResponse(response,
        url: URL.GET_WX_ACCOUNT_LIST,
        message: "获取公众号列表",
        scene: Scene.WX_OFFICIAL_ACCOUNT_LIST.toString());
    return WXOfficialAccountList.fromJson(response.data);
  }

  static Future<WXArticleList> getWXArticleList(int id, {int page = 1}) async {
    String url = URL.getWXArticleListUrl(id, page);
    Response response =
    await globalDio().get(url);
    handleNetResponse(response,
        url: url,
        message: "获取公众号历史数据",
        scene: Scene.WX_OFFICIAL_ACCOUNT_DETAIL.toString());
    return WXArticleList.fromJson(response.data);
  }

// todo 抽出公用方法到 common 里

}
