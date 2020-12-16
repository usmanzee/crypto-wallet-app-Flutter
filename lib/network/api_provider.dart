import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto_template/network/app_exception.dart';
import 'dart:async';

class ApiProvider {
  final String _baseUrl = "http://192.168.18.7:9002/api/v2/";
  // final String _baseUrl = "https://ewallet.b4uwallet.com/api/v2/";

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      print(_baseUrl + url);
      final response = await http.get(_baseUrl + url);
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
      final response = await http.post(_baseUrl + url, body: body);
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
      final response = await http.put(_baseUrl + url, body: body);
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
      final response = await http.delete(_baseUrl + url);
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
      throw BadRequestException(errorResponse);
    case 401:
      var errorResponse = makeErrorResponse(response);
      throw BadRequestException(errorResponse);
    case 422:
      var errorResponse = makeErrorResponse(response);
      throw BadRequestException(errorResponse);
    case 403:
      var errorResponse = makeErrorResponse(response);
      throw UnauthorisedException(errorResponse);
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
