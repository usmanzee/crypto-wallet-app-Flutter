import 'dart:convert';
import 'package:b4u_wallet/controllers/HomeController.dart';
import 'package:crypto/crypto.dart';
import 'package:get/get.dart';

class RequestHeaders {
  HomeController homeController = Get.find();

  Map<String, String> setAuthHeaders() {
    int nonce =  DateTime.now()
        // .add( Duration(seconds: 10),)
        .millisecondsSinceEpoch;
    List<int> message = utf8
        .encode(nonce.toString() + homeController.authApiKey.value.toString());
    List<int> secretEncode = utf8.encode(homeController.authSecret.value.toString());
    Hmac hMacSha256 = Hmac(sha256, secretEncode);
    Digest sha256Result = hMacSha256.convert(message);

    return {
      "X-Auth-Apikey": homeController.authApiKey.value.toString(),
      "X-Auth-Nonce": nonce.toString(),
      "X-Auth-Signature": sha256Result.toString(),
    };
  }
}
