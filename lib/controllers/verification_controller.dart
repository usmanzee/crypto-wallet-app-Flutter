import 'dart:async';

import 'package:crypto_template/controllers/HomeController.dart';
import 'package:crypto_template/controllers/SnackbarController.dart';
import 'package:crypto_template/controllers/error_controller.dart';
import 'package:crypto_template/models/verification_label.dart';
import 'package:crypto_template/repository/user_repository.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class VerificationController extends GetxController {
  var nationalities = [
    'Afghan',
    'Albanian',
    'Algerian',
    'American',
    'Andorran',
    'Angolan',
    'Antiguans',
    'Argentinean',
    'Armenian',
    'Australian',
    'Austrian',
    'Azerbaijani',
    'Bahamian',
    'Bahraini',
    'Bangladeshi',
    'Barbadian',
    'Barbudans',
    'Batswana',
    'Belarusian',
    'Belgian',
    'Belizean',
    'Beninese',
    'Bhutanese',
    'Bolivian',
    'Bosnian',
    'Brazilian',
    'British',
    'Bruneian',
    'Bulgarian',
    'Burkinabe',
    'Burmese',
    'Burundian',
    'Cambodian',
    'Cameroonian',
    'Canadian',
    'Cape Verdean',
    'Central African',
    'Chadian',
    'Chilean',
    'Chinese',
    'Colombian',
    'Comoran',
    'Congolese',
    'Costa Rican',
    'Croatian',
    'Cuban',
    'Cypriot',
    'Czech',
    'Danish',
    'Djibouti',
    'Dominican',
    'Dutch',
    'East Timorese',
    'Ecuadorean',
    'Egyptian',
    'Emirian',
    'Equatorial Guinean',
    'Eritrean',
    'Estonian',
    'Ethiopian',
    'Fijian',
    'Filipino',
    'Finnish',
    'French',
    'Gabonese',
    'Gambian',
    'Georgian',
    'German',
    'Ghanaian',
    'Greek',
    'Grenadian',
    'Guatemalan',
    'Guinea-Bissauan',
    'Guinean',
    'Guyanese',
    'Haitian',
    'Herzegovinian',
    'Honduran',
    'Hungarian',
    'I-Kiribati',
    'Icelander',
    'Indian',
    'Indonesian',
    'Iranian',
    'Iraqi',
    'Irish',
    'Israeli',
    'Italian',
    'Ivorian',
    'Jamaican',
    'Japanese',
    'Jordanian',
    'Kazakhstani',
    'Kenyan',
    'Kittian and Nevisian',
    'Kuwaiti',
    'Kyrgyz',
    'Laotian',
    'Latvian',
    'Lebanese',
    'Liberian',
    'Libyan',
    'Liechtensteiner',
    'Lithuanian',
    'Luxembourger',
    'Macedonian',
    'Malagasy',
    'Malawian',
    'Malaysian',
    'Maldivan',
    'Malian',
    'Maltese',
    'Marshallese',
    'Mauritanian',
    'Mauritian',
    'Mexican',
    'Micronesian',
    'Moldovan',
    'Monacan',
    'Mongolian',
    'Moroccan',
    'Mosotho',
    'Motswana',
    'Mozambican',
    'Namibian',
    'Nauruan',
    'Nepalese',
    'New Zealander',
    'Nicaraguan',
    'Nigerian',
    'Nigerien',
    'North Korean',
    'Northern Irish',
    'Norwegian',
    'Omani',
    'Pakistani',
    'Palauan',
    'Panamanian',
    'Papua New Guinean',
    'Paraguayan',
    'Peruvian',
    'Polish',
    'Portuguese',
    'Qatari',
    'Romanian',
    'Russian',
    'Rwandan',
    'Saint Lucian',
    'Salvadoran',
    'Samoan',
    'San Marinese',
    'Sao Tomean',
    'Saudi',
    'Scottish',
    'Senegalese',
    'Serbian',
    'Seychellois',
    'Sierra Leonean',
    'Singaporean',
    'Slovakian',
    'Slovenian',
    'Solomon Islander',
    'Somali',
    'South African',
    'South Korean',
    'Spanish',
    'Sri Lankan',
    'Sudanese',
    'Surinamer',
    'Swazi',
    'Swedish',
    'Swiss',
    'Syrian',
    'Taiwanese',
    'Tajik',
    'Tanzanian',
    'Thai',
    'Togolese',
    'Tongan',
    'Trinidadian/Tobagonian',
    'Tunisian',
    'Turkish',
    'Tuvaluan',
    'Ugandan',
    'Ukrainian',
    'Uruguayan',
    'Uzbekistani',
    'Venezuelan',
    'Vietnamese',
    'Welsh',
    'Yemenite',
    'Zambian',
    'Zimbabwean',
  ].obs;
  var countries = [
    "Afghanistan",
    "Albania",
    "Algeria",
    "Andorra",
    "Angola",
    "Anguilla",
    "Antigua &amp; Barbuda",
    "Argentina",
    "Armenia",
    "Aruba",
    "Australia",
    "Austria",
    "Azerbaijan",
    "Bahamas",
    "Bahrain",
    "Bangladesh",
    "Barbados",
    "Belarus",
    "Belgium",
    "Belize",
    "Benin",
    "Bermuda",
    "Bhutan",
    "Bolivia",
    "Bosnia &amp; Herzegovina",
    "Botswana",
    "Brazil",
    "British Virgin Islands",
    "Brunei",
    "Bulgaria",
    "Burkina Faso",
    "Burundi",
    "Cambodia",
    "Cameroon",
    "Cape Verde",
    "Cayman Islands",
    "Chad",
    "Chile",
    "China",
    "Colombia",
    "Congo",
    "Cook Islands",
    "Costa Rica",
    "Cote D Ivoire",
    "Croatia",
    "Cruise Ship",
    "Cuba",
    "Cyprus",
    "Czech Republic",
    "Denmark",
    "Djibouti",
    "Dominica",
    "Dominican Republic",
    "Ecuador",
    "Egypt",
    "El Salvador",
    "Equatorial Guinea",
    "Estonia",
    "Ethiopia",
    "Falkland Islands",
    "Faroe Islands",
    "Fiji",
    "Finland",
    "France",
    "French Polynesia",
    "French West Indies",
    "Gabon",
    "Gambia",
    "Georgia",
    "Germany",
    "Ghana",
    "Gibraltar",
    "Greece",
    "Greenland",
    "Grenada",
    "Guam",
    "Guatemala",
    "Guernsey",
    "Guinea",
    "Guinea Bissau",
    "Guyana",
    "Haiti",
    "Honduras",
    "Hong Kong",
    "Hungary",
    "Iceland",
    "India",
    "Indonesia",
    "Iran",
    "Iraq",
    "Ireland",
    "Isle of Man",
    "Israel",
    "Italy",
    "Jamaica",
    "Japan",
    "Jersey",
    "Jordan",
    "Kazakhstan",
    "Kenya",
    "Kuwait",
    "Kyrgyz Republic",
    "Laos",
    "Latvia",
    "Lebanon",
    "Lesotho",
    "Liberia",
    "Libya",
    "Liechtenstein",
    "Lithuania",
    "Luxembourg",
    "Macau",
    "Macedonia",
    "Madagascar",
    "Malawi",
    "Malaysia",
    "Maldives",
    "Mali",
    "Malta",
    "Mauritania",
    "Mauritius",
    "Mexico",
    "Moldova",
    "Monaco",
    "Mongolia",
    "Montenegro",
    "Montserrat",
    "Morocco",
    "Mozambique",
    "Namibia",
    "Nepal",
    "Netherlands",
    "Netherlands Antilles",
    "New Caledonia",
    "New Zealand",
    "Nicaragua",
    "Niger",
    "Nigeria",
    "Norway",
    "Oman",
    "Pakistan",
    "Palestine",
    "Panama",
    "Papua New Guinea",
    "Paraguay",
    "Peru",
    "Philippines",
    "Poland",
    "Portugal",
    "Puerto Rico",
    "Qatar",
    "Reunion",
    "Romania",
    "Russia",
    "Rwanda",
    "Saint Pierre &amp; Miquelon",
    "Samoa",
    "San Marino",
    "Satellite",
    "Saudi Arabia",
    "Senegal",
    "Serbia",
    "Seychelles",
    "Sierra Leone",
    "Singapore",
    "Slovakia",
    "Slovenia",
    "South Africa",
    "South Korea",
    "Spain",
    "Sri Lanka",
    "St Kitts &amp; Nevis",
    "St Lucia",
    "St Vincent",
    "St. Lucia",
    "Sudan",
    "Suriname",
    "Swaziland",
    "Sweden",
    "Switzerland",
    "Syria",
    "Taiwan",
    "Tajikistan",
    "Tanzania",
    "Thailand",
    "Timor L'Este",
    "Togo",
    "Tonga",
    "Trinidad &amp; Tobago",
    "Tunisia",
    "Turkey",
    "Turkmenistan",
    "Turks &amp; Caicos",
    "Uganda",
    "Ukraine",
    "United Arab Emirates",
    "United Kingdom",
    "Uruguay",
    "Uzbekistan",
    "Venezuela",
    "Vietnam",
    "Virgin Islands (US)",
    "Yemen",
    "Zambia",
    "Zimbabwe"
  ].obs;

  TextEditingController phoneTextController;
  TextEditingController pinCodeTextController;

  TextEditingController firstNameTextController;
  TextEditingController lastNameTextController;
  TextEditingController dateOfBirthTextController;
  TextEditingController nationalityTextController;
  TextEditingController residencyTextController;
  TextEditingController addressTextController;
  TextEditingController cityTextController;
  TextEditingController postCodeTextController;

  HomeController homeController = Get.find();

  var isLoadingLables = false.obs;
  var _codeSent = false.obs;
  var _codeCountDownCompleted = false.obs;
  var labelsList = List<VerificationLabel>().obs;
  var _codeCountDown = 10.obs;
  var phoneNumberText = ''.obs;
  var selectedNationality = ''.obs;
  var selectedCountry = ''.obs;

  final _currentStep = 0.obs;
  get currentStep => this._currentStep.value;
  set currentStep(index) => this._currentStep.value = index;

  SnackbarController snackbarController;
  ErrorController errorController = new ErrorController();

  get codeCountDownCompleted => this._codeCountDownCompleted.value;
  set codeCountDownCompleted(value) =>
      this._codeCountDownCompleted.value = value;

  get codeSent => this._codeSent.value;
  set codeSent(value) => this._codeSent.value = value;

  get codeCountDown => this._codeCountDown.value;
  set codeCountDown(value) => this._codeCountDown.value = value;
  Timer _timer;

  @override
  void onInit() {
    phoneTextController = TextEditingController();
    pinCodeTextController = TextEditingController();

    firstNameTextController = TextEditingController();
    lastNameTextController = TextEditingController();
    dateOfBirthTextController = TextEditingController();
    nationalityTextController = TextEditingController();
    residencyTextController = TextEditingController();
    addressTextController = TextEditingController();
    cityTextController = TextEditingController();
    postCodeTextController = TextEditingController();

    selectedNationality.value = nationalities[0];
    selectedCountry.value = countries[0];

    nationalityTextController.text = nationalities[0];
    residencyTextController.text = countries[0];

    fetchLabels();

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void fetchLabels() async {
    UserRepository _userRepository = new UserRepository();
    try {
      isLoadingLables(true);
      var response = await _userRepository.fetchLables();
      labelsList.assignAll(response);

      isLoadingLables(false);
    } catch (error) {
      isLoadingLables(false);
      errorController.handleError(error);
    }
  }

  void startCodeSentCountDown() {
    _timer?.cancel();
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (codeCountDown == 0) {
          timer.cancel();
        } else {
          codeCountDown = codeCountDown - 1;
        }
      },
    );
  }

  void sendPhoneVerificationCode() async {
    UserRepository _userRepository = new UserRepository();
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    codeCountDown = 60;
    startCodeSentCountDown();
    try {
      var reqObj = {'phone_number': phoneNumberText.value};
      var response = await _userRepository.sendPhoneVerificationCode(reqObj);
      print(response);
      codeSent = true;
      Get.back();
      snackbarController = new SnackbarController(
          title: 'Success', message: 'success.phone.verification.send');
      snackbarController.showSnackbar();
    } catch (error) {
      Get.back();
      errorController.handleError(error);
    }
  }

  void reSendPhoneVerificationCode() async {
    UserRepository _userRepository = new UserRepository();
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    codeCountDown = 60;
    codeSent = true;
    startCodeSentCountDown();
    try {
      var reqObj = {'phone_number': phoneNumberText.value};
      var response = await _userRepository.sendPhoneVerificationCode(reqObj);
      codeSent = true;
      print(response);
      Get.back();
      snackbarController = new SnackbarController(
          title: 'Success', message: 'success.phone.verification.send');
      snackbarController.showSnackbar();
    } catch (error) {
      Get.back();
      errorController.handleError(error);
    }
  }

  void verifyPhonePinCode() async {
    UserRepository _userRepository = new UserRepository();
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    try {
      var reqObj = {
        'phone_number': phoneNumberText.value,
        'verification_code': pinCodeTextController.text
      };
      var response = await _userRepository.verifyPhonePinCode(reqObj);
      homeController.user.value.level = 2;
      homeController.user.refresh();
      print(response);
      Get.back();
      snackbarController = new SnackbarController(
          title: 'Success', message: 'success.phone.confirmed');
      snackbarController.showSnackbar();
    } catch (error) {
      Get.back();
      errorController.handleError(error);
    }
  }

  void verifyIdentity() async {
    UserRepository _userRepository = new UserRepository();
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    try {
      var reqObj = {
        'first_name': firstNameTextController.text,
        'last_name': lastNameTextController.text,
        'dob': dateOfBirthTextController.text,
        'country': residencyTextController.text,
        'metadata': {
          'nationality': nationalityTextController.text,
        },
        'address': addressTextController.value,
        'city': cityTextController.text,
        'postcode': postCodeTextController.text,
      };
      var response = await _userRepository.verifyIdentity(reqObj);
      homeController.user.value.level = 3;
      homeController.user.refresh();
      print(response);
      Get.back();
      snackbarController = new SnackbarController(
          title: 'Success', message: 'success.phone.confirmed');
      snackbarController.showSnackbar();
    } catch (error) {
      Get.back();
      errorController.handleError(error);
    }
  }

  @override
  void onClose() {
    phoneTextController?.dispose();
    pinCodeTextController?.dispose();

    firstNameTextController?.dispose();
    lastNameTextController?.dispose();
    dateOfBirthTextController?.dispose();
    nationalityTextController?.dispose();
    residencyTextController?.dispose();
    addressTextController?.dispose();
    cityTextController?.dispose();
    postCodeTextController?.dispose();

    _timer?.cancel();
    super.onClose();
  }
}
