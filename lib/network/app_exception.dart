import 'package:crypto_template/utils/Helpers/readable_message.dart';

class AppException implements Exception {
  final dynamic response;
  final _prefix;

  AppException([this.response, this._prefix]);

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
