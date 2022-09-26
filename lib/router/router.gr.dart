// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;

import '../pages/article/create_article.dart' as _i3;
import '../pages/authentication/login_screen.dart' as _i2;
import '../pages/drawer/drawer_details.dart' as _i6;
import '../pages/home/home_details.dart' as _i5;
import '../pages/home/home_screen.dart' as _i4;
import '../pages/splash/splash_screen.dart' as _i1;

class AppRouter extends _i7.RootStackRouter {
  AppRouter([_i8.GlobalKey<_i8.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    Splash.name: (routeData) {
      return _i7.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.SplashScreen(),
        transitionsBuilder: _i7.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    Login.name: (routeData) {
      return _i7.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i2.LoginScreen(),
        transitionsBuilder: _i7.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    Article.name: (routeData) {
      return _i7.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i3.CreateArticle(),
        transitionsBuilder: _i7.TransitionsBuilders.slideTop,
        opaque: true,
        barrierDismissible: false,
      );
    },
    Home.name: (routeData) {
      return _i7.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i4.HomeScreen(),
        transitionsBuilder: _i7.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    HomeDetail.name: (routeData) {
      return _i7.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i5.HomeDetails(),
        transitionsBuilder: _i7.TransitionsBuilders.slideBottom,
        opaque: true,
        barrierDismissible: false,
      );
    },
    DrawerScreen.name: (routeData) {
      return _i7.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i6.DrawerDetails(),
        transitionsBuilder: _i7.TransitionsBuilders.slideLeft,
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i7.RouteConfig> get routes => [
        _i7.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/rcanews/splash',
          fullMatch: true,
        ),
        _i7.RouteConfig(
          Splash.name,
          path: '/rcanews/splash',
        ),
        _i7.RouteConfig(
          Login.name,
          path: '/rcanews/connexion',
        ),
        _i7.RouteConfig(
          Article.name,
          path: '/rcanews/article',
        ),
        _i7.RouteConfig(
          Home.name,
          path: '/rcanews/accueil',
        ),
        _i7.RouteConfig(
          HomeDetail.name,
          path: '/rcanews/accueil/details:id',
        ),
        _i7.RouteConfig(
          DrawerScreen.name,
          path: '/rcanews/paramètre',
        ),
      ];
}

/// generated route for
/// [_i1.SplashScreen]
class Splash extends _i7.PageRouteInfo<void> {
  const Splash()
      : super(
          Splash.name,
          path: '/rcanews/splash',
        );

  static const String name = 'Splash';
}

/// generated route for
/// [_i2.LoginScreen]
class Login extends _i7.PageRouteInfo<void> {
  const Login()
      : super(
          Login.name,
          path: '/rcanews/connexion',
        );

  static const String name = 'Login';
}

/// generated route for
/// [_i3.CreateArticle]
class Article extends _i7.PageRouteInfo<void> {
  const Article()
      : super(
          Article.name,
          path: '/rcanews/article',
        );

  static const String name = 'Article';
}

/// generated route for
/// [_i4.HomeScreen]
class Home extends _i7.PageRouteInfo<void> {
  const Home()
      : super(
          Home.name,
          path: '/rcanews/accueil',
        );

  static const String name = 'Home';
}

/// generated route for
/// [_i5.HomeDetails]
class HomeDetail extends _i7.PageRouteInfo<void> {
  const HomeDetail()
      : super(
          HomeDetail.name,
          path: '/rcanews/accueil/details:id',
        );

  static const String name = 'HomeDetail';
}

/// generated route for
/// [_i6.DrawerDetails]
class DrawerScreen extends _i7.PageRouteInfo<void> {
  const DrawerScreen()
      : super(
          DrawerScreen.name,
          path: '/rcanews/paramètre',
        );

  static const String name = 'DrawerScreen';
}
