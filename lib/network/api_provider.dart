import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:crypto_template/network/app_exception.dart';

import 'dart:async';
import 'dart:convert';

class ApiProvider {
  final String _baseUrl = "http://192.168.18.7:9002/";
  // final String _baseUrl = "http://www.app.local/";
  // final String _baseUrl = "https://www.coinee.cf/";
  // final String _baseUrl = "https://ewallet.b4uwallet.com/";
  final String _appVersion = "api/v2/";
  @override
  String _apiVersion;
  Map<String, String> _headers;

  Map<String, String> get headers {
    return _headers;
  }

  set headers(Map<String, String> headers) {
    _headers = headers;
  }

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      print(_baseUrl + _appVersion + url);
      print('headers :' + headers.toString());
      final response =
          await http.get(_baseUrl + _appVersion + url, headers: headers);
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
    var responseJson;
    try {
      print(_baseUrl + url);
      final response = await http.post(_baseUrl + _appVersion + url,
          body: body, headers: headers);
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
    var responseJson;
    try {
      final response = await http.put(_baseUrl + _appVersion + url,
          body: body, headers: headers);
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
    var apiResponse;
    try {
      final response =
          await http.delete(_baseUrl + _appVersion + url, headers: headers);
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
