import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rcanews/core/controllers/article_controller.dart';
import 'package:rcanews/core/controllers/login_controller.dart';
import 'package:rcanews/core/controllers/splash_controller.dart';
import 'package:rcanews/core/services/authentication_services.dart';
import 'package:rcanews/core/widgets/smooth_drawer/smooth_drawer_controller.dart';
import 'package:rcanews/firebase_options.dart';
import 'package:rcanews/router/router.gr.dart';

import 'core/controllers/home_controller.dart';
import 'core/widgets/bottomFloatingNavBar/smooth_custom_floating_bottom_nav_controller.dart';

// make sure you don't initiate your router
// inside of the build function.
final _appRouter = AppRouter();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SplashController()),
        ChangeNotifierProvider(create: (_) => SmoothDrawerController()),
        ChangeNotifierProvider(create: (_) => AuthenticationService()),
        ChangeNotifierProvider(create: (_) => LoginController()),
        ChangeNotifierProvider(create: (_) => HomeController()),
        ChangeNotifierProvider(create: (_) => ArticleController()),
        ChangeNotifierProvider(create: (_) => SmoothBottomCustomFloatingNavController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp.router(
      title: 'RCA News',
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fr', ''), // English, no country code
        Locale('en', ''), // English, no country code
        Locale('es', ''), // Spanish, no country code
      ],
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      debugShowCheckedModeBanner: false,
    );
  }
}
