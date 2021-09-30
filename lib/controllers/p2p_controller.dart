import 'dart:async';

import 'package:b4u_wallet/controllers/error_controller.dart';
import 'package:b4u_wallet/models/balance.dart';
import 'package:b4u_wallet/models/created_offer_response.dart';
import 'package:b4u_wallet/models/p2p_add_offer_model.dart';
import 'package:b4u_wallet/models/p2p_currency.dart';
import 'package:b4u_wallet/models/p2p_offer/p2p_offer.dart';
import 'package:b4u_wallet/models/p2p_offer/p2p_offer_add_response.dart';
import 'package:b4u_wallet/models/payment_method/payment_method.dart';
import 'package:b4u_wallet/models/payment_method/payment_method_data.dart';
import 'package:b4u_wallet/models/payment_method/payment_method_detail.dart';
import 'package:b4u_wallet/models/payment_method/selected_method_for_offer_model.dart';
import 'package:b4u_wallet/repository/p2p_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class P2pController extends GetxController {
  ErrorController errorController = ErrorController();
  P2pRepository _p2pRepository = P2pRepository();
  RxBool isLoading = true.obs;
  RxString selectedCurrency = 'UAH'.obs;

  //p2p bottomNav Index
  RxInt initialIndex = 0.obs;

  //buy sell page or express page
  RxBool buySellOrExpress = true.obs;

  // true means buy and false means sell
  RxBool buyOrSellP2p = true.obs;
  RxBool buyOrSellExpress = true.obs;

  // history filters
  RxString typeSelected = 'All'.obs;
  RxString statusSelected = 'All'.obs;

  //profile page
  RxInt user30DaysTrades = 0.obs;
  RxInt averageReleaseTime = 0.obs;
  RxInt averagePayTime = 0.obs;
  RxDouble user30DaysCompletionRate = 0.00.obs;

  /* RxList<P2POffer> p2pOffersBuy = <P2POffer>[].obs;
  RxList<P2POffer> p2pOffersSell = <P2POffer>[].obs;*/
  //usdt list
  RxList<P2POffer> usdBuy = <P2POffer>[].obs;
  RxList<P2POffer> usdSell = <P2POffer>[].obs;

  //btc list
  RxList<P2POffer> btcBuy = <P2POffer>[].obs;
  RxList<P2POffer> btcSell = <P2POffer>[].obs;

  //trst list
  RxList<P2POffer> trstBuy = <P2POffer>[].obs;
  RxList<P2POffer> trstSell = <P2POffer>[].obs;

  //usdt list
  RxList<P2POffer> ethBuy = <P2POffer>[].obs;
  RxList<P2POffer> ethSell = <P2POffer>[].obs;

  //selected offer parameters
  P2POffer selectedOffer;
  RxString lowerLimitInAsset = ''.obs;
  RxString upperLimitInAsset = ''.obs;
  //asset price in fiat to be used ofr if he orders in the crypto
  RxString oneAssetInFiat = ''.obs;
  RxInt offerTime = 0.obs;
  Timer timer;

  void startTimer({@required int time}) {
    final st = 60 * time;
    int _start = st;
    const oneSec = const Duration(seconds: 1);
    timer =  Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
            timer.cancel();
        } else {
          offerTime.value = _start;
          print(offerTime.value);
            _start--;
        }
      },
    );
  }

  //express transaction by crypto or cash, true means by crypto and false means by cash
  RxBool cryptoOrCash = true.obs;

  // trade variables
  RxString allAmountForQuote = ''.obs;
  CreatedOrderResponse createdOrderResponse;

  //for the feedback reviews changing
  RxString reviewChosen = 'All'.obs;

  // notifications page
  RxBool ordersEmailEnable = true.obs;
  RxBool ordersSmsEnable = true.obs;
  RxBool ordersAppNotificationsEnable = true.obs;
  RxBool appealsEmailEnable = true.obs;
  RxBool appealsSmsEnable = true.obs;
  RxBool appealsAppNotificationsEnable = true.obs;
  RxBool securityEmailEnable = true.obs;
  RxBool securitySmsEnable = true.obs;
  RxBool securityAppNotificationsEnable = true.obs;

  //select currency page listview scrollController
  ScrollController scrollController;
  RxBool showTopButton = false.obs;
  final byCryptoFormKey = GlobalKey<FormState>();
  final byFiatFormKey = GlobalKey<FormState>();

  //selected current offer variables

  //change the limit and other variables on tab swipe
  RxBool fiatOrCrypto = true.obs;

  //pending transaction page
  RxBool clientContainer = true.obs;
  RxBool paymentContainer = true.obs;

  // payment method page
  RxBool termsContainer = true.obs;
  RxBool dialogConfirm = false.obs;

  //p2p payment release page
  RxBool pContainer = true.obs;

  //extra for just view will be deleted
  RxList<Widget> a = <Widget>[].obs;
  RxInt radioValue = 0.obs;
  RxString selectedReason = 'Tap here to select a reason...'.obs;
  RxBool buyerOrSeller = true.obs;

  //post normal ad page variables
  RxList<P2POffer> userAddedP2pOffers = <P2POffer>[].obs;
  RxBool secondPage = false.obs;
  RxBool thirdPage = false.obs;

  //offer to be added
  P2pAddOfferModel p2pAddOfferModel;

  //post normal add first page
  RxString firstBuySell = 'Buy'.obs;
  RxString firstFixedFloating = 'Fixed'.obs;
  RxString firstSelectedAsset = 'btc'.obs;
  RxString firstSelectedFiat = 'btc'.obs;
  RxString firstYourPrice = ''.obs;
  RxString firstHighestOrderPrice = ''.obs;
  RxString firstFixedPrice = '0.00'.obs;
  RxDouble firstLowestOnePercent = 0.00.obs;
  RxString firstFloatingPrice = '100.00'.obs;
  RxBool firstShowWarning = false.obs;
  RxString firstLowestPrize = '0.00'.obs;
  RxList<P2PCurrency> firstAssetListWithInfo = <P2PCurrency>[].obs;
  RxList<String> firstAssetList = <String>[].obs;
  final fixedTextController = TextEditingController(text: '0.00');
  final floatingTextController = TextEditingController(text: '100.00');

  //post normal add second page
  final secondFormKey = GlobalKey<FormState>();
  RxString secondSelectedAsset = ''.obs;
  final secondTotalAmountTextController = TextEditingController(text: '1');
  RxString secondAddedAmountInFiat = '1'.obs;
  RxString secondAddedAmountInAsset = ''.obs;
  RxString secondSelectedFiat = ''.obs;
  RxInt secondTimeLimitInt = 15.obs;
  RxString secondTimeLimitString = '15'.obs;
  RxDouble secondReservedFee = 0.07.obs;
  RxBool secondShowReservedFee = false.obs;
  RxList<Balance> fetchedBalances = <Balance>[].obs;
  RxString secondAvailableAmount = ''.obs;
  RxList<SelectedMethodForOfferModel> selectedMethodForOffer =
      <SelectedMethodForOfferModel>[].obs;
  final secondOrderLimitFirstController = TextEditingController();
  final secondOrderLimitSecondController = TextEditingController();

  //post normal add third page
  RxBool thirdKyc = true.obs;
  RxBool thirdRegisteredDays = false.obs;
  RxBool thirdBtc = false.obs;
  RxInt thirdOnlineOffline = 1.obs;
  final thirdTermsController = TextEditingController();
  final thirdAutoReplyController = TextEditingController();

  //added offer response
  P2POfferAddResponse p2pOfferAddResponse;

  // add payment method process variables
  RxList<PaymentMethod> publicPaymentMethodList = <PaymentMethod>[].obs;
  RxList<PaymentMethodData> addedPaymentMethodsList = <PaymentMethodData>[].obs;

  // RxBool paymentMethodsAdded = false.obs;
  RxString selectedMethodName = ''.obs;
  RxString selectedMethodSlug = ''.obs;
  RxList<PaymentMethodDetail> selectedPaymentMethodDetails =
      <PaymentMethodDetail>[].obs;

  @override
  void onClose() {
    scrollController.dispose();
    timer.cancel();
    super.onClose();
  }

  @override
  void onReady() async {
    await fetchAllLists(true);
    fetchUserP2pAddedOffers();
    fetchCurrencies();
    fetchPublicPaymentMethodList();
    fetchP2pBalances();
    fetchAllAddedPaymentMethods();
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.offset >= 300) {
        // print(scrollController.offset);
        showTopButton.value = true;
      } else {
        // print(scrollController.offset);
        showTopButton.value = false;
      }
    });
    // ever(isLoading, fetchAllLists);
    super.onReady();
  }

  @override
  void onInit() {
    // fetchP2pOffers();
    super.onInit();
  }

  Future<void> fetchAllLists(bool val) async {
    isLoading(val);
    await fetchP2pOffers(category: 'usd', buyList: usdBuy, sellList: usdSell);
    await fetchP2pOffers(category: 'eth', buyList: ethBuy, sellList: ethSell);
    await fetchP2pOffers(
        category: 'trst', buyList: trstBuy, sellList: trstSell);
    await fetchP2pOffers(category: 'btc', buyList: btcBuy, sellList: btcSell);
    isLoading(false);
  }

  Future<bool> fetchP2pOffers({
    String category,
    RxList<P2POffer> buyList,
    RxList<P2POffer> sellList,
  }) async {
    // isLoading(true);
    try {
      final response = await _p2pRepository.fetchP2pOffers(category: category);
      if (response.length > 0) {
        response.forEach((e) {
          e.side == 'buy' ? buyList.add(e) : sellList.add(e);
        });
        // isLoading(false);
        return true;
      }
    } catch (error) {
      errorController.handleError(error);
      // isLoading(false);

      return false;
    }
    return false;
  }

  void fetchUserP2pAddedOffers() async {
    try {
      final response = await _p2pRepository.fetchUserP2pAddedOffers();
      if (response.length > 0) {
        response.forEach((e) {
          userAddedP2pOffers.add(e);
        });
        // isLoading(false);
      }
    } catch (error) {
      errorController.handleError(error);
      // isLoading(false);
    }
  }

  Future<bool> addP2pOffer({var body}) async {
    try {
      final response = await _p2pRepository.addP2pOffer(body: body);
      if (response.id != null) {
        p2pOfferAddResponse = response;
        return true;
      }
    } catch (error) {
      errorController.handleError(error);
      // isLoading(false);

      return false;
    }
    return false;
  }

  //fetch the current rate of the asset in the fiat
  void fetchExchangeRateForSingleAsset() async {
    final Map<String, dynamic> body = {
      'qoute_currency': firstSelectedAsset.value,
      'base_currency': firstSelectedFiat.value,
      'qoute_amount': '1',
    };
    try {
      final res = await _p2pRepository.fetchExchangeRate(body: body);
      if (res != null) {
        final val = double.parse(res).toStringAsFixed(2);
        firstLowestPrize.value = val;
        fixedTextController.text = val;
        firstFixedPrice.value = val;
        firstLowestOnePercent.value =
            double.parse((double.parse(val) / 100.00).toStringAsFixed(2));
        // availableAmount.value = fetchedBalances[index].balance;
        fetchedBalances.forEach((element) {
          if (firstSelectedAsset.value == element.currency) {
            secondAddedAmountInAsset.value =
                secondAvailableAmount.value = element.balance;
            Get.back();
          }
        });
      }
    } catch (error) {
      errorController.handleError(error);
      Get.back();
      // isLoading(false);
    }
  }

  //fetch all p2p asset currencies
  void fetchCurrencies() async {
    try {
      final res = await _p2pRepository.fetchCurrencies();
      if (res != null) {
        res.forEach((e) {
          firstAssetListWithInfo.add(e);
        });
        // print('currencies are fetched');
      }
    } catch (error) {
      errorController.handleError(error);
      // isLoading(false);
    }
  }

  //fetch the all of the payment methods list
  void fetchPublicPaymentMethodList() async {
    try {
      final res = await _p2pRepository.fetchPaymentMethodList();
      if (res.length > 0) {
        res.forEach((e) {
          publicPaymentMethodList.add(e);
        });
      }
    } catch (error) {
      errorController.handleError(error);
    }
  }

  //fetch the selected public payment method details
  Future<bool> selectedPublicMethodDetails(
      {@required String selectedMethod}) async {
    selectedPaymentMethodDetails = <PaymentMethodDetail>[].obs;
    try {
      final res = await _p2pRepository.selectedPublicMethodDetails(
          selectedMethod: selectedMethod);
      if (res.length > 0) {
        res.forEach((e) {
          selectedPaymentMethodDetails.add(e);
        });
        return true;
      }
      return false;
    } catch (error) {
      errorController.handleError(error);
      return false;
    }
  }

  // fetch the all of the added payment methods added by the user
  void fetchAllAddedPaymentMethods() async {
    try {
      final res = await _p2pRepository.fetchAllAddedPaymentMethods();
      if (res.length > 0) {
        res.forEach((e) {
          addedPaymentMethodsList.add(e);
          // addedPaymentMethodsList.refresh();
        });
        // paymentMethodsAdded.value = true;
      }
    } catch (error) {
      errorController.handleError(error);
    }
  }

  //refresh all of the added payment methods
  void refreshAllAddedPaymentMethods() {
    addedPaymentMethodsList = <PaymentMethodData>[].obs;
    fetchAllAddedPaymentMethods();
    // addedPaymentMethodsList.refresh();
    update();
    print('done');
  }

  //add a payment method to the account
  Future<bool> addPaymentMethod(dynamic body) async {
    try {
      final res = await _p2pRepository.addPaymentMethod(body);
      if (res) {
        return true;
      }
      return false;
    } catch (error) {
      errorController.handleError(error);
      return false;
    }
  }

  void fetchP2pBalances() async {
    try {
      final res = await _p2pRepository.fetchP2PBalances();
      if (res.length > 0) {
        res.forEach((element) {
          fetchedBalances.add(element);
          firstAssetList.add(element.currency);
        });
      }
    } catch (error) {
      errorController.handleError(error);
    }
  }

  // clear all used variables after posting an offer
  void resetOfferAddVariables() {
    secondTotalAmountTextController.text = '1';
    firstFixedPrice.value = '0';
    firstSelectedFiat.value = 'btc';
    firstSelectedAsset.value = 'btc';
    secondOrderLimitFirstController.text = '';
    secondOrderLimitSecondController.text = '';
    firstBuySell.value = 'Buy';
    secondTimeLimitInt.value = 15;
    thirdTermsController.text = '';
    thirdAutoReplyController.text = '';
    secondPage.value = false;
    secondShowReservedFee.value = false;
    thirdPage.value = false;
  }

  //fetch the current selected offer quote currency from wallet
  void fetchCurrentQuoteBalance({@required String unit}) {
    fetchedBalances.forEach((element) {
      if (unit.toLowerCase() == element.currency.toLowerCase()) {
        allAmountForQuote.value = element.balance;
        Get.back();
      }
    });
  }

  //fetch the current rate of the limit fiat in the asset
  void fetchAssetAgainstProvidedFiat({
    @required RxString lower,
    @required RxString upper,
    @required String lowerLimit,
    @required String upperLimit,
    @required String quote,
    @required String base,
  }) async {
    final Map<String, dynamic> body = {
      'qoute_currency': quote,
      'base_currency': base,
      'qoute_amount': '1',
    };
    try {
      final res = await _p2pRepository.fetchExchangeRate(body: body);
      if (res != null) {
        oneAssetInFiat.value = res;
        final val = double.parse(res);
        lower.value = (double.parse(lowerLimit) / val).toStringAsFixed(6);
        upper.value = (double.parse(upperLimit) / val).toStringAsFixed(6);
      }
    } catch (error) {
      errorController.handleError(error);
      // isLoading(false);
    }
  }

  //create the order against the selected offer
  Future<bool> createOrderP2p(
      {@required double amount, @required int offerId}) async {
    final body = {
      'amount': amount,
      'offer_id': offerId,
    };
    try {
      final res = await _p2pRepository.createOffer(body: body);
      if (res.id != null) {
        createdOrderResponse = res;
        print(createdOrderResponse.toJson());
        return true;
      } else {
        return false;
      }
    } catch (error) {
      errorController.handleError(error);
      return false;
    }
  }
}
