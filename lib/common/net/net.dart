import 'dart:io';

import 'package:dio/dio.dart';
import 'net_config.dart';
import '../app_config.dart';
import '../utils.dart';

Dio globalDio() {
  return Dio(_getBaseOption());
}

/// 基础网络配置
_getBaseOption() {
  BaseOptions options = BaseOptions(
    baseUrl: BASE_URL,
    connectTimeout: CONNECTION_TIME_OUT,
    receiveTimeout: RECEIVE_TIME_OUT,
    headers: _getBaseHeader(),
    queryParameters: _getBaseParameters(),
    responseType: ResponseType.json,
  );
  return options;
}

_getBaseHeader() {
  var map = {
//    "User-Agent": "", // todo
    "X-Sessionid": generateUUID(),
  };
  if (isInProduction()) {
    map.putIfAbsent("x-proto", () => "SSL");
  }
  return map;
}

_getBaseParameters() {
  var map = {
    // user about (like uid)

    // flutter about
    "numberOfProcessors": Platform.numberOfProcessors,
    "localeName": Platform.localeName,
    "operatingSystem": Platform.operatingSystem,
    "operatingSystemVersion": Platform.operatingSystemVersion,
    "localHostname": Platform.localHostname,
    // app about
    "appName": AppConfig.appName,
    "packageName": AppConfig.packageName,
    "version": AppConfig.version,
    "buildNumber": AppConfig.buildNumber,
  };
  var deviceInfo = AppConfig.getDeviceInfo();
  if (deviceInfo != null) {
    map.addAll(deviceInfo);
  }
  return map;
}

//-------Functions---------
handleNetResponse(
  Response response, {
  String url = "No Url",
  String message = "No Message",
  String scene = "No Scene",
}) {
  if (isInProduction()) {
    print(
        "Url：[$url]\tScene: [$scene]\tMessage: [$message]\tCode:[${response.statusCode}]");
  }
}
