// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:crypto_template/views/home/on_Boarding.dart';
// import 'package:crypto_template/views/home/splash.dart';
// import 'package:crypto_template/views/setting/themes.dart';

// /// Run first apps open
// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   final Widget child;

//   MyApp({Key key, this.child}) : super(key: key);

//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   /// Create _themeBloc for double theme (Dark and White theme)
//   ThemeBloc _themeBloc;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _themeBloc = ThemeBloc();
//   }

//   @override
//   Widget build(BuildContext context) {
//     /// To set orientation always portrait
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);

//     /// StreamBuilder for themeBloc
//     return StreamBuilder<ThemeData>(
//       initialData: _themeBloc.initialTheme().data,
//       stream: _themeBloc.themeDataStream,
//       builder: (BuildContext context, AsyncSnapshot<ThemeData> snapshot) {
//         return MaterialApp(
//           title: 'Crypto Apps',
//           theme: snapshot.data,
//           debugShowCheckedModeBanner: false,
//           home: SplashScreen(
//             themeBloc: _themeBloc,
//           ),

//           /// Move splash screen to onBoarding Layout
//           /// Routes
//           ///
//           routes: <String, WidgetBuilder>{
//             "onBoarding": (BuildContext context) =>
//                 new OnBoarding(themeBloc: _themeBloc)
//           },
//         );
//       },
//     );
//   }
// }

import 'package:crypto_template/bindings/root_binding.dart';
import 'package:crypto_template/bindings/socket_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crypto_template/utils/router.dart' as RouterFile;
import 'package:crypto_template/views/setting/themes.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SocketBinding().dependencies();
  // RootBinding().dependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'B4U Wallet',
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.downToUp,
      getPages: RouterFile.Router.route,
      initialRoute: '/splash',
      theme: Themes.lightTheme,
    );
  }
}
