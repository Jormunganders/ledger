import 'dart:io';

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
    connectTimeout: CONNECTION_TIME_OUT,
    receiveTimeout: RECEIVE_TIME_OUT,
    headers: getBaseHeader(),
    queryParameters: getBaseParameters(),
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
