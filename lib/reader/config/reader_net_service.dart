import 'package:dio/dio.dart';
import 'package:ledger/common/net/net.dart';
import 'package:ledger/reader/config/constants.dart';
import 'package:ledger/reader/config/scene.dart';
import 'package:ledger/reader/model/wx_official_account.dart';

class ReaderNetService {
  static Future<WXOfficialAccountList> getWXOfficialAccountList() async {
    Response response = await globalDio().get(URL.GET_WX_ARTICLE_LIST);
    handleNetResponse(response,
        url: URL.GET_WX_ARTICLE_LIST,
        message: "获取公众号列表",
        scene: Scene.WX_OFFICIAL_ACCOUNT_LIST.toString());
    return WXOfficialAccountList.fromJson(response.data);
  }

// todo 抽出公用方法到 common 里

}
