import 'dart:convert';
import 'package:crypto_template/controllers/HomeController.dart';
import 'package:crypto/crypto.dart';
import 'package:get/get.dart';

class RequestHeaders {
  HomeController homeController = Get.find();

  Object setAuthHeaders() {
    var nonce = new DateTime.now()
        // .add(new Duration(seconds: 10))
        .millisecondsSinceEpoch;
    var message = utf8
        .encode(nonce.toString() + homeController.authApiKey.value.toString());
    var secretEncode = utf8.encode(homeController.authSecret.value.toString());
    var hmacSha256 = new Hmac(sha256, secretEncode);
    Digest sha256Result = hmacSha256.convert(message);

    return {
      "X-Auth-Apikey": homeController.authApiKey.value.toString(),
      "X-Auth-Nonce": nonce.toString(),
      "X-Auth-Signature": sha256Result.toString(),
    };
  }
}
