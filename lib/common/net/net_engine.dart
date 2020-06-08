import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ledger/common/net/net.dart';

abstract class NetEngine {
  Future<CommonResponse> get(String url);

  Future<CommonResponse> post(String url, Map<String, dynamic> param);
}

class CommonResponse {
  Map<String, dynamic> data;
  int statusCode;
// 有需要可以添加
}

class DioNetEngineImpl extends NetEngine {
  var _dio = globalDio();

  @override
  Future<CommonResponse> get(String url) async {
    var response = await _dio.get(url);
    var result = CommonResponse();
    result.data = response.data;
    result.statusCode = response.statusCode;
    return result;
  }

  @override
  Future<CommonResponse> post(String url, Map<String, dynamic> param) async {
    var response = await _dio.post(url, queryParameters: param);
    var result = CommonResponse();
    result.data = response.data;
    result.statusCode = response.statusCode;
    return result;
  }
}

class OriginNetEngineImpl extends NetEngine {
  var _httpClient = HttpClient();

  @override
  Future<CommonResponse> get(String url) async {
    var uri = Uri.parse(url);
    var request = await _httpClient.getUrl(uri);
    var response = await request.close();
    var result = CommonResponse();
    result.statusCode = response.statusCode;
    var string = await response.transform(Utf8Decoder()).join();
    result.data = json.decode(string);
    return result;
  }

  @override
  Future<CommonResponse> post(String url, Map<String, dynamic> param) async {
    var uri = Uri.parse(url).replace(queryParameters: param);
    var request = await _httpClient.postUrl(uri);
    var response = await request.close();
    var result = CommonResponse();
    result.statusCode = response.statusCode;
    var string = await response.transform(Utf8Decoder()).join();
    result.data = json.decode(string);
    return result;
  }
}

class NetEngineFactory {
  static NetEngine getEngine() {
    if (USE_DIO) {
      return DioNetEngineImpl();
    } else {
      return OriginNetEngineImpl();
    }
  }
}

const USE_DIO = true;
