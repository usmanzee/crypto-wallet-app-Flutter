import 'package:crypto_template/controllers/HomeController.dart';
import 'package:crypto_template/controllers/error_controller.dart';
import 'package:crypto_template/models/formated_market.dart';
import 'package:crypto_template/models/open_order.dart';
import 'package:crypto_template/repository/open_orders_repository.dart';
import 'package:get/get.dart';

class OpenOrdersController extends GetxController {
  HomeController homeController = Get.find();
  final FormatedMarket formatedMarket;
  OpenOrdersController({this.formatedMarket});
  ErrorController errorController = new ErrorController();

  var isLoading = false.obs;
  var openOrdersList = List<OpenOrder>().obs;

  @override
  void onInit() {
    if (homeController.isLoggedIn) {
      fetchOpenOrders();
    }
    super.onInit();
  }

  void fetchOpenOrders() async {
    OpenOrdersRepository _openOrdersRepository = new OpenOrdersRepository();
    try {
      isLoading(true);
      var openOrders =
          await _openOrdersRepository.fetchOpenOrders(formatedMarket.id);
      openOrdersList.assignAll(openOrders);
      isLoading(false);
    } catch (error) {
      print(error);
      isLoading(false);
      errorController.handleError(error);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
