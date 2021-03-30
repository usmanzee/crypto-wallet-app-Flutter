import 'package:b4u_wallet/controllers/HomeController.dart';
import 'package:b4u_wallet/controllers/SnackbarController.dart';
import 'package:b4u_wallet/controllers/error_controller.dart';
import 'package:b4u_wallet/controllers/web_socket_controller.dart';
import 'package:b4u_wallet/models/formated_market.dart';
import 'package:b4u_wallet/models/open_order.dart';
import 'package:b4u_wallet/repository/open_orders_repository.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:b4u_wallet/utils/Helpers/ws_helper.dart';

class OpenOrdersController extends GetxController {
  HomeController homeController = Get.find();
  final FormatedMarket formatedMarket;
  OpenOrdersController({this.formatedMarket});
  SnackbarController snackbarController;
  ErrorController errorController = new ErrorController();

  var isLoading = false.obs;
  var hideOtherOrders = false.obs;
  var openOrdersList = <OpenOrder>[].obs;
  var openOrdersSortedList = <OpenOrder>[].obs;

  WebSocketController webSocketController = Get.find();

  @override
  void onInit() {
    openOrdersList.clear();
    openOrdersSortedList.clear();

    super.onInit();
  }

  @override
  void onReady() async {
    if (homeController.isLoggedIn.value) {
      await homeController.fetchMemberLevels();
      if (!homeController.fetchingMemberLevel.value &&
          !homeController.publicMemberLevel.value.isBlank) {
        if (homeController.user.value.level >=
            homeController.publicMemberLevel.value.trading.minimumLevel) {
          fetchOpenOrders();
          await webSocketController.subscribeOrder();
          getOpenOrdersDataFromWS();
        }
      }
    }
    ever(homeController.isLoggedIn, fetchOrderOnLoggedIn);
    super.onReady();
  }

  fetchOrderOnLoggedIn(isUserLoggedIn) async {
    if (isUserLoggedIn) {
      await homeController.fetchMemberLevels();
      if (!homeController.fetchingMemberLevel.value &&
          !homeController.publicMemberLevel.value.isBlank) {
        if (homeController.user.value.level >=
            homeController.publicMemberLevel.value.trading.minimumLevel) {
          fetchOpenOrders();
          await webSocketController.subscribeOrder();
          getOpenOrdersDataFromWS();
        }
      }
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
      var reqObj = {};
      if (cancelAll) {
        if (hideOtherOrders.value) {
          reqObj = {'market': formatedMarket.id};
        }
      } else {
        reqObj = {'id': orderId.toString()};
      }
      if (cancelAll) {
        var cancelAllOrdersResponse =
            await _openOrdersRepository.cancelAllOpenOrders(reqObj);
        if (cancelAllOrdersResponse.length > 0) {
          for (var i = 0; i < cancelAllOrdersResponse.length; i++) {
            openOrdersList.removeWhere((openOrder) {
              return openOrder.id == cancelAllOrdersResponse[i].id;
            });
            openOrdersSortedList.removeWhere((openOrder) {
              return openOrder.id == cancelAllOrdersResponse[i].id;
            });
          }
        }
        Get.back();
        snackbarController = new SnackbarController(
            title: 'Success', message: 'success.order.cancelling.all'.tr);
      } else {
        var cancelOrderResponse =
            await _openOrdersRepository.cancelOpenOrder(orderId, reqObj);
        if (cancelOrderResponse != null) {
          openOrdersList.removeWhere((openOrder) {
            return openOrder.id == cancelOrderResponse.id;
          });
          openOrdersSortedList.removeWhere((openOrder) {
            return openOrder.id == cancelOrderResponse.id;
          });
        }
        Get.back();
        snackbarController = new SnackbarController(
            title: 'Success', message: 'success.order.cancelling'.tr);
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
        var state = data['order']['state'];
        switch (state) {
          case 'wait':
          case 'pending':
            var index = openOrdersSortedList.indexWhere((openOrder) {
              return openOrder.id == data['order']['id'];
            });
            if (index == -1) {
              snackbarController = new SnackbarController(
                  title: 'Success', message: 'success.order.created'.tr);
              snackbarController.showSnackbar();
            }
            break;
          case 'done':
            snackbarController = new SnackbarController(
                title: 'Success', message: 'success.order.done'.tr);
            snackbarController.showSnackbar();
            break;
          case 'reject':
            snackbarController = new SnackbarController(
                title: 'Error', message: 'error.order.rejected'.tr);
            snackbarController.showSnackbar();
            break;
          default:
            break;
        }
        List<OpenOrder> newOrdersList =
            WsHelper.insertOrUpdate(openOrdersList, data['order']);
        if (hideOtherOrders.value) {
          var list = newOrdersList.where((openOrder) {
            return openOrder.market.toLowerCase() ==
                formatedMarket.id.toLowerCase();
          });
          openOrdersSortedList.assignAll(list);
        } else {
          openOrdersSortedList.assignAll(openOrdersList);
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
