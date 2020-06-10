//-------url------
class URL {
  static const GET_WX_ACCOUNT_LIST =
      "https://wanandroid.com/wxarticle/chapters/json"; // 获取公众号列表
  static String getWXArticleListUrl(int id, int page) =>
      "https://wanandroid.com/wxarticle/list/$id/$page/json"; // 获取某个公众号历史数据
  static String getSearchWXArticleUrl(int id, int page, String key) =>
      "https://wanandroid.com/wxarticle/list/$id/$page/json?k=$key"; // 搜索某个公众号历史数据
}

class PAGE_TITLE {
  static const WX_OFFICIAL_ACCOUNT_LIST = "微信公众号列表";
  static const WX_OFFICIAL_ACCOUNT_DETAIL = "微信公众号详情";
}
