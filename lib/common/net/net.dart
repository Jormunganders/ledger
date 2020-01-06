import 'package:dio/dio.dart';
import 'net_config.dart';
import '../app_config.dart';
import '../utils.dart';

Dio getDio() {
  return Dio(getBaseOption());
}

/**
 * 基础网络配置
 */
getBaseOption() {
  BaseOptions options = BaseOptions(
    baseUrl: BASE_URL,
//    connectTimeout: CONNECTION_TIME_OUT,
//    receiveTimeout: RECEIVE_TIME_OUT,
//    headers: getBaseHeader(),
  );
  return options;
}

getBaseHeader() {
  var map = {
//    "User-Agent": "", // todo
    "X-Sessionid": generateUUID(),
  };
  if (isInProduction()) {
    map.putIfAbsent("x-proto", () => "SSL");
  }
  return map;
}

getBaseParameters() {
  // todo
  // 设备信息（网络状况、机型、系统）
  // uid
}
