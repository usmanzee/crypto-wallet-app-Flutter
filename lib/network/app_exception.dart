import 'dart:convert';
import 'package:crypto_template/utils/Helpers/readable_message.dart';

class AppException implements Exception {
  final dynamic response;
  final _prefix;

  AppException([this.response, this._prefix]);

  // String toString() {
  //   ReadAbleMessage newReadAbleMessage = new ReadAbleMessage(message: _message);
  //   var readAbleMessage = newReadAbleMessage.getMessage();
  //   var obj = {
  //     'statusCode': _statusCode,
  //     'message': _prefix + readAbleMessage,
  //     'originalMessage': _message
  //   };
  //   return obj.toString();
  // }

  dynamic errorResponse() {
    var errorResponseObject = {};

    ReadAbleMessage newReadAbleMessage =
        new ReadAbleMessage(message: response["message"]);
    var readAbleMessage = newReadAbleMessage.getMessage();
    errorResponseObject = {
      'statusCode': response["statusCode"],
      'message': _prefix + readAbleMessage,
      'originalMessage': response["message"]
    };
    // if (response.statusCode == 1) {
    //   errorResponseObject = {
    //     'statusCode': response["statusCode"],
    //     'message': _prefix + response["message"],
    //     'originalMessage': response["message"]
    //   };
    // } else {
    //   var errorResponse = json.decode(response.body);
    //   var errors = errorResponse['errors'];
    //   for (var i = 0; i <= errors.length; i++) {
    //     // throw BadRequestException(errors[i]);
    //     ReadAbleMessage newReadAbleMessage =
    //         new ReadAbleMessage(message: errors[i]);
    //     var readAbleMessage = newReadAbleMessage.getMessage();
    //     errorResponseObject = {
    //       'statusCode': response.statusCode,
    //       'message': _prefix + readAbleMessage,
    //       'originalMessage': errors[i]
    //     };
    //   }
    // }
    return errorResponseObject;
  }
}

class APIException extends AppException {}

class FetchDataException extends AppException {
  dynamic response;
  FetchDataException([this.response]) : super(response, "Server error: ");
}

class BadRequestException extends AppException {
  dynamic response;
  BadRequestException([this.response]) : super(response, "Bad Request: ");
}

class UnauthorisedException extends AppException {
  dynamic response;
  UnauthorisedException([this.response]) : super(response, "Unauthorised: ");
}

class InvalidInputException extends AppException {
  dynamic response;
  InvalidInputException([this.response])
      : super(response, "Error During Communication: ");
}
