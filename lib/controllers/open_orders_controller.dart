import 'package:crypto_template/controllers/HomeController.dart';
import 'package:crypto_template/controllers/SnackbarController.dart';
import 'package:crypto_template/controllers/error_controller.dart';
import 'package:crypto_template/controllers/web_socket_controller.dart';
import 'package:crypto_template/models/formated_market.dart';
import 'package:crypto_template/models/open_order.dart';
import 'package:crypto_template/repository/open_orders_repository.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:crypto_template/utils/Helpers/ws_helper.dart';

class OpenOrdersController extends GetxController {
  HomeController homeController = Get.find();
  final FormatedMarket formatedMarket;
  OpenOrdersController({this.formatedMarket});
  SnackbarController snackbarController;
  ErrorController errorController = new ErrorController();

  var isLoading = false.obs;
  var hideOtherOrders = false.obs;
  var openOrdersList = List<OpenOrder>().obs;
  var openOrdersSortedList = List<OpenOrder>().obs;

  WebSocketController webSocketController = Get.find();

  @override
  void onInit() {
    openOrdersList.clear();
    openOrdersSortedList.clear();
    if (homeController.isLoggedIn.value) {
      fetchOpenOrders();
    }
    super.onInit();
  }

  @override
  void onReady() async {
    ever(homeController.isLoggedIn, fetchOrderOnLoggedIn);
    if (homeController.isLoggedIn.value) {
      await webSocketController.subscribeOrder();
      getOpenOrdersDataFromWS();
    }
    super.onReady();
  }

  fetchOrderOnLoggedIn(isUserLoggedIn) async {
    if (isUserLoggedIn) {
      fetchOpenOrders();
      await webSocketController.subscribeOrder();
      getOpenOrdersDataFromWS();
    } else {
      openOrdersList.clear();
      openOrdersSortedList.clear();
    }
  }

  void fetchOpenOrders() async {
    OpenOrdersRepository _openOrdersRepository = new OpenOrdersRepository();
    try {
      isLoading(true);
      var openOrders =
          await _openOrdersRepository.fetchOpenOrders(formatedMarket.id);
      openOrdersList.assignAll(openOrders);
      openOrdersSortedList.assignAll(openOrders);
      isLoading(false);
    } catch (error) {
      print(error);
      isLoading(false);
      errorController.handleError(error);
    }
  }

  void cancelOpenOrders(bool cancelAll, [int orderId]) async {
    OpenOrdersRepository _openOrdersRepository = new OpenOrdersRepository();
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    try {
      var cancelOrderResponse =
          await _openOrdersRepository.cancelOpenOrders(cancelAll, orderId);
      Get.back();
      print(cancelOrderResponse);
      if (cancelAll) {
        snackbarController = new SnackbarController(
            title: 'Success', message: 'success.order.cancelling.all');
      } else {
        snackbarController = new SnackbarController(
            title: 'Success', message: 'success.order.cancelling');
      }
      snackbarController.showSnackbar();
    } catch (error) {
      print(error);
      Get.back();
      errorController.handleError(error);
    }
  }

  void hideOrShowOtherOrder() {
    hideOtherOrders.value = !hideOtherOrders.value;
    if (hideOtherOrders.value) {
      var list = openOrdersList.where((openOrder) {
        return openOrder.market.toLowerCase() ==
            formatedMarket.id.toLowerCase();
      });
      openOrdersSortedList.assignAll(list);
    } else {
      openOrdersSortedList.assignAll(openOrdersList);
    }
  }

  void getOpenOrdersDataFromWS() {
    webSocketController.streamController.value.stream.listen((message) {
      var data = json.decode(message);
      if (data.containsKey('order')) {
        if (hideOtherOrders.value) {
          if (data['order']['market'].toLowerCase() ==
              formatedMarket.id.toLowerCase()) {
            WsHelper.insertOrUpdate(openOrdersSortedList, data['order']);
          }
        } else {
          WsHelper.insertOrUpdate(openOrdersSortedList, data['order']);
        }
      }
    }, onDone: () {
      print("Task Done1");
    }, onError: (error) {
      print("Some Error1");
    });
  }

  @override
  void onClose() {
    webSocketController.unSubscribeOrder();
    super.onClose();
  }
}
