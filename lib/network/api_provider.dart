import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:crypto_template/network/app_exception.dart';

import 'dart:async';
import 'dart:convert';
import 'package:crypto_template/controllers/HomeController.dart';
import 'package:crypto/crypto.dart';
import 'package:get/get.dart';

class ApiProvider {
  final String _baseUrl = "http://10.121.121.203:9002/api/v2/";
  // final String _baseUrl = "http://www.app.local/api/v2/";
  // final String _baseUrl = "https://www.coinee.cf/api/v2/";
  // final String _baseUrl = "https://ewallet.b4uwallet.com/api/v2/";

  dynamic headers;
  bool includeAuthHeaders = true;
  // ApiProvider({this.includeAuthHeaders});
  HomeController homeController = Get.find();

  void setHeaders() {
    var nonce =
        new DateTime.now().add(new Duration(seconds: 5)).millisecondsSinceEpoch;
    var message = utf8
        .encode(nonce.toString() + homeController.authApiKey.value.toString());
    var secretEncode = utf8.encode(homeController.authSecret.value.toString());
    var hmacSha256 = new Hmac(sha256, secretEncode);
    Digest sha256Result = hmacSha256.convert(message);

    headers = {
      "X-Auth-Apikey": homeController.authApiKey.value.toString(),
      "X-Auth-Nonce": nonce.toString(),
      "X-Auth-Signature": sha256Result.toString(),
    };
  }

  Future<dynamic> get(String url) async {
    if (includeAuthHeaders) {
      setHeaders();
    }
    var responseJson;
    try {
      print(_baseUrl + url);
      print(headers);
      final response = await http.get(_baseUrl + url, headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException(
          {'statusCode': 1, 'message': 'No Internet connection'});
    } on HttpException {
      throw FetchDataException(
          {'statusCode': 2, 'message': 'Could not find the data'});
    } on FormatException {
      throw FetchDataException(
          {'statusCode': 3, 'message': 'Bad response format'});
    }
    return responseJson;
  }

  Future<dynamic> post(String url, dynamic body) async {
    if (includeAuthHeaders) {
      setHeaders();
    }
    var responseJson;
    try {
      print(_baseUrl + url);
      final response =
          await http.post(_baseUrl + url, body: body, headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException(
          {'statusCode': 1, 'message': 'No Internet connection'});
    } on HttpException {
      throw FetchDataException(
          {'statusCode': 2, 'message': 'Could not find the data'});
    } on FormatException {
      throw FetchDataException(
          {'statusCode': 3, 'message': 'Bad response format'});
    }
    return responseJson;
  }

  Future<dynamic> put(String url, dynamic body) async {
    if (includeAuthHeaders) {
      setHeaders();
    }
    var responseJson;
    try {
      final response =
          await http.put(_baseUrl + url, body: body, headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException(
          {'statusCode': 1, 'message': 'No Internet connection'});
    } on HttpException {
      throw FetchDataException(
          {'statusCode': 2, 'message': 'Could not find the data'});
    } on FormatException {
      throw FetchDataException(
          {'statusCode': 3, 'message': 'Bad response format'});
    }
    return responseJson;
  }

  Future<dynamic> delete(String url) async {
    if (includeAuthHeaders) {
      setHeaders();
    }
    var apiResponse;
    try {
      final response = await http.delete(_baseUrl + url, headers: headers);
      apiResponse = _returnResponse(response);
    } on SocketException {
      throw FetchDataException(
          {'statusCode': 1, 'message': 'No Internet connection'});
    } on HttpException {
      throw FetchDataException(
          {'statusCode': 2, 'message': 'Could not find the data'});
    } on FormatException {
      throw FetchDataException(
          {'statusCode': 3, 'message': 'Bad response format'});
    }
    return apiResponse;
  }
}

dynamic _returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      var responseJson = response.body;
      return responseJson;
    case 201:
      var responseJson = response.body;
      return responseJson;
    case 302:
      var responseJson = response.body;
      return responseJson;
    case 400:
      var errorResponse = makeErrorResponse(response);

      print(errorResponse);
      throw BadRequestException(errorResponse);
    case 401:
      var errorResponse = makeErrorResponse(response);
      throw UnauthorisedException(errorResponse);
    case 403:
      var errorResponse = makeErrorResponse(response);
      throw UnauthorisedException(errorResponse);
    case 422:
      var errorResponse = makeErrorResponse(response);
      throw BadRequestException(errorResponse);
    case 500:
      var errorResponse = makeErrorResponse(response);
      throw UnauthorisedException(errorResponse);
    default:
      var errorResponse = makeErrorResponse(response);
      FetchDataException(errorResponse);
  }
}

dynamic makeErrorResponse(response) {
  var errorResponseObject = {};
  var errorResponse = json.decode(response.body);
  var errors = errorResponse['errors'];
  for (var i = 0; i < errors.length; i++) {
    errorResponseObject = {
      'statusCode': response.statusCode,
      'message': errors[i]
    };
  }
  return errorResponseObject;
}
