import 'dart:convert';

class AppException implements Exception {
  final dynamic response;

  AppException([this.response]);

  // dynamic errorResponse() {
  //   var errorResponseObject = {};

  //   errorResponseObject = {
  //     'statusCode': response["statusCode"],
  //     'message': response["originalMessage"],
  //     'originalMessage': response["message"]
  //   };
  //   return errorResponseObject;
  // }
  String toString() {
    return json.encode(response);
  }
}

class APIException extends AppException {}

class FetchDataException extends AppException {
  dynamic response;
  FetchDataException([this.response]);
}

class BadRequestException extends AppException {
  dynamic response;
  BadRequestException([this.response]);
}

class UnauthorisedException extends AppException {
  dynamic response;
  UnauthorisedException([this.response]);
}

class InvalidInputException extends AppException {
  dynamic response;
  InvalidInputException([this.response]);
}
