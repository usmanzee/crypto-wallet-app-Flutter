import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:crypto_template/bindings/socket_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crypto_template/utils/router.dart' as RouterFile;
import 'package:crypto_template/views/setting/themes.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:upgrader/upgrader.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  await DotEnv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SocketBinding().dependencies();

  // Sentry.configureScope(
  //   (scope) => scope.user = User(id: '1234', email: 'jane.doe@example.com'),
  // );
  await SentryFlutter.init(
    (options) => options.dsn =
        'https://8be4739068b14c4ca62ee53fbe2f3261@o175277.ingest.sentry.io/5653237',
    appRunner: () => runApp(MyApp()),
  );
  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: UpgradeAlert(
        child: GetMaterialApp(
          title: 'B4U Wallet',
          debugShowCheckedModeBanner: false,
          defaultTransition: Transition.downToUp,
          getPages: RouterFile.Router.route,
          initialRoute: '/splash',
          theme: Themes.lightTheme,
        ),
      ),
    );
  }
}
