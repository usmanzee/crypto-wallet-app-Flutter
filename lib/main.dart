import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:crypto_template/bindings/socket_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crypto_template/utils/router.dart' as RouterFile;
import 'package:crypto_template/views/setting/themes.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
// import 'package:upgrader/upgrader.dart';

Future<void> main() async {
  await DotEnv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SocketBinding().dependencies();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
        child: GetMaterialApp(
      title: 'B4U Wallet',
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.downToUp,
      getPages: RouterFile.Router.route,
      initialRoute: '/splash',
      theme: Themes.lightTheme,
    )
        // UpgradeAlert(
        //   child: GetMaterialApp(
        //     title: 'B4U Wallet',
        //     debugShowCheckedModeBanner: false,
        //     defaultTransition: Transition.downToUp,
        //     getPages: RouterFile.Router.route,
        //     initialRoute: '/splash',
        //     theme: Themes.lightTheme,
        //   ),
        // ),
        );
  }
}
