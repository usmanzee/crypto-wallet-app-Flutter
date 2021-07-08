import 'dart:async';
import 'package:b4u_wallet/models/p2p_offer/p2p_offer.dart';
import 'package:get/get.dart';
import 'package:b4u_wallet/repository/p2p_repository.dart';

class P2pController extends GetxController{

  RxBool isLoading = true.obs;
  // true means buy and false means sell
  RxBool buyOrSell = true.obs;
  RxString typeSelected = 'All'.obs;
  RxString statusSelected = 'All'.obs;
  RxInt user30DaysTrades = 0.obs;
  RxInt averageReleaseTime = 0.obs;
  RxInt averagePayTime = 0.obs;
  RxDouble user30DaysCompletionRate = 0.00.obs;
  RxList<P2POffer> p2pOffers = <P2POffer>[].obs;


  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onInit() {
    fetchP2pOffers();
    super.onInit();
  }

  Future<bool> fetchP2pOffers({String category})async{
    isLoading(true);
    P2pRepository _p2pRepository = P2pRepository();
    final response = await _p2pRepository.fetchP2pOffers();
    if(response.length >0){
      p2pOffers.addAll(response);
      print(p2pOffers.value[0].member.uid);
      isLoading(false);
    }else{
      isLoading(false);
      return false;
    }
  }

}