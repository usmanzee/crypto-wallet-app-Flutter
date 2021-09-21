import 'package:b4u_wallet/utils/transalations/messages.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:b4u_wallet/bindings/socket_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:b4u_wallet/utils/router.dart' as RouterFile;
import 'package:b4u_wallet/views/setting/themes.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  await DotEnv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SocketBinding().dependencies();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final isLightTheme = GetStorage().read('isLightTheme');
  final langCode = GetStorage().read('lang_code');
  final countryCode = GetStorage().read('country_code');
  @override
  Widget build(BuildContext context) {
    return OKToast(
        child: GetMaterialApp(
      title: 'B4U Wallet',
      debugShowCheckedModeBanner: false,
      translations: Messages(),
      locale: langCode == null && countryCode == null
          ? Locale('en', 'US')
          : Locale(langCode, countryCode),
      defaultTransition: Transition.leftToRight,
      getPages: RouterFile.Router.route,
      initialRoute: '/splash',
      routingCallback: (routing) {},
      theme: isLightTheme == null || isLightTheme
          ? Themes.lightTheme
          : Themes.darkTheme,
    ));
  }
}
