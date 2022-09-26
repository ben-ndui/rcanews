

// @CupertinoAutoRouter
// @AdaptiveAutoRouter
// @CustomAutoRouter
import 'package:auto_route/auto_route.dart';
import 'package:rcanews/pages/article/create_article.dart';
import 'package:rcanews/pages/authentication/login_screen.dart';
import 'package:rcanews/pages/drawer/drawer_details.dart';
import 'package:rcanews/pages/home/home_details.dart';
import 'package:rcanews/pages/home/home_screen.dart';
import 'package:rcanews/pages/splash/splash_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Pages,Route',
  routes: <AutoRoute>[
    CustomRoute(page: SplashScreen, name: "Splash", path: "/rcanews/splash", initial: true, transitionsBuilder: TransitionsBuilders.fadeIn),
    CustomRoute(page: LoginScreen, name: "Login", path: "/rcanews/connexion", transitionsBuilder: TransitionsBuilders.fadeIn),
    CustomRoute(page: CreateArticle, name: "Article", path: "/rcanews/article", transitionsBuilder: TransitionsBuilders.slideTop),
    CustomRoute(page: HomeScreen, name: "Home", path: "/rcanews/accueil", transitionsBuilder: TransitionsBuilders.fadeIn),
    CustomRoute(page: HomeDetails, name: "HomeDetail", path: "/rcanews/accueil/details:id", transitionsBuilder: TransitionsBuilders.slideBottom),
    CustomRoute(page: DrawerDetails, name: "DrawerScreen", path: "/rcanews/paramètre", transitionsBuilder: TransitionsBuilders.slideLeft),
  ],
)
class $AppRouter {}