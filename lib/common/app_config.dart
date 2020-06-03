import 'dart:collection';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:package_info/package_info.dart';

import 'develop.dart';

/// 是否在生产环境
_isInProduction() => bool.fromEnvironment("dart.vm.product");

isInProduction() =>
    bool.fromEnvironment("dart.vm.product") ||
    isFeatureDisable("feature_debug_mode");

class AppConfig {
  static String appName;
  static String packageName;
  static String version;
  static String buildNumber;

  static double screenWidth;
  static double screenHeight;
  static double devicePixelRatio; // 屏幕密度、像素比例
  static double textScaleFactor; // 文字缩放比例

  static Map<String, dynamic> androidDeviceInfo;
  static Map<String, dynamic> iosDeviceInfo;

  // todo 其他平台

  static init(BuildContext context) {
    _getPackageInfo();
    _getDeviceInfo();

    var queryData = MediaQuery.of(context);

    devicePixelRatio = queryData.devicePixelRatio;
    textScaleFactor = queryData.textScaleFactor;
    screenHeight = queryData.size.height;
    screenWidth = queryData.size.width;
  }

  static _getPackageInfo() {
    PackageInfo.fromPlatform().then((PackageInfo info) {
      appName = info.appName;
      packageName = info.packageName;
      version = info.version;
      buildNumber = info.buildNumber;
    });
  }

  static _getDeviceInfo() {
    DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    if (Platform.isAndroid) {
      deviceInfoPlugin.androidInfo.then((AndroidDeviceInfo info) {
        androidDeviceInfo = {
          "sdkInt": info.version.sdkInt,
          "brand": info.brand,
          "device": info.device,
          "host": info.host,
          "model": info.model,
          "product": info.product,
          "androidId": info.androidId,
          "isPhysicalDevice": info.isPhysicalDevice,
        };
      });
    }
    if (Platform.isIOS) {
      deviceInfoPlugin.iosInfo.then((IosDeviceInfo info) {
        iosDeviceInfo = {
          "name": info.name,
          "systemName": info.systemName,
          "systemVersion": info.systemVersion,
          "isPhysicalDevice": info.isPhysicalDevice,
          "identifierForVendor": info.identifierForVendor,
        };
      });
    }
    if (Platform.isFuchsia) {}
    if (Platform.isMacOS) {}
    if (Platform.isWindows) {}
    if (Platform.isLinux) {}
  }

  static Map<String, dynamic> getDeviceInfo() {
    if (Platform.isAndroid) return androidDeviceInfo;
    if (Platform.isIOS) return iosDeviceInfo;
    return null;
  }
}
