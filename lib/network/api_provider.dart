import 'dart:io';
import 'package:b4u_wallet/models/Error.dart';
import 'package:b4u_wallet/utils/Helpers/environment.dart';
import 'package:http/http.dart' as http;
import 'package:b4u_wallet/network/app_exception.dart';
import 'dart:async';

class ApiProvider {
  final String _baseUrl = Environment.getApiBaseUrl();
  final String _appVersion = Environment.getApiAppVersion();
  Map<String, String> headers;

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      print(_baseUrl + _appVersion + url);
      print('headers :' + headers.toString());
      final response =
          await http.get(_baseUrl + _appVersion + url, headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException({
        'statusCode': 1,
        'errors': ['server.not.available']
      });
    } on HttpException {
      throw FetchDataException({
        'statusCode': 2,
        'errors': ['no.internet']
      });
    } on FormatException {
      throw FetchDataException({
        'statusCode': 3,
        'errors': ['server.error']
      });
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
      throw FetchDataException({
        'statusCode': 1,
        'errors': ['server.not.available']
      });
    } on HttpException {
      throw FetchDataException({
        'statusCode': 2,
        'errors': ['no.internet']
      });
    } on FormatException {
      throw FetchDataException({
        'statusCode': 3,
        'errors': ['server.error']
      });
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
      throw FetchDataException({
        'statusCode': 1,
        'errors': ['server.not.available']
      });
    } on HttpException {
      throw FetchDataException({
        'statusCode': 2,
        'errors': ['no.internet']
      });
    } on FormatException {
      throw FetchDataException({
        'statusCode': 3,
        'errors': ['server.error']
      });
    }
    return responseJson;
  }

  Future<dynamic> delete(String url) async {
    var responseJson;
    try {
      final response =
          await http.delete(_baseUrl + _appVersion + url, headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException({
        'statusCode': 1,
        'errors': ['server.not.available']
      });
    } on HttpException {
      throw FetchDataException({
        'statusCode': 2,
        'errors': ['no.internet']
      });
    } on FormatException {
      throw FetchDataException({
        'statusCode': 3,
        'errors': ['server.error']
      });
    }
    return responseJson;
  }

  Future<dynamic> multiPart(http.MultipartRequest request) async {
    var responseJson;
    try {
      final response = await request.send();
      final res = await http.Response.fromStream(response);
      responseJson = _returnResponse(res);
    } on SocketException {
      throw FetchDataException({
        'statusCode': 1,
        'errors': ['server.not.available']
      });
    } on HttpException {
      throw FetchDataException({
        'statusCode': 2,
        'errors': ['no.internet']
      });
    } on FormatException {
      throw FetchDataException({
        'statusCode': 3,
        'errors': ['server.error']
      });
    }
    return responseJson;
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
      throw FetchDataException(errorResponse);
    default:
      var errorResponse = makeErrorResponse(response);
      FetchDataException(errorResponse);
  }
}

dynamic makeErrorResponse(response) {
  var errorResponseObject = {};
  Error errorObj = errorFromJson(response.body);
  errorResponseObject = {
    'statusCode': response.statusCode,
    'errors': errorObj.errors,
  };
  return errorResponseObject;
}
