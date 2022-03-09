import 'package:flutter/material.dart';
import 'package:hevento/configuraiton.dart';
import 'package:hevento/pages/partner_page.dart';
import 'package:hevento/pages/test.dart';
import 'package:hevento/routes.dart';

import 'pages/home_page.dart';

class CustomRouterDelegate extends RouterDelegate<Configuration> with ChangeNotifier, PopNavigatorRouterDelegateMixin<Configuration> {
  Configuration _configuration = Configuration.home();

  @override
  GlobalKey<NavigatorState> get navigatorKey => GlobalKey<NavigatorState>();

  @override
  Configuration get currentConfiguration => _configuration;

  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: navigatorKey,
        pages: [
          if (_configuration.isHomePage)
            const MaterialPage(
              key: ValueKey('HomePage'),
              child: Scaffold(
                body: LandingPage(),
              ),
            ),
          if (_configuration.isOtherPage)
            MaterialPage(
              key: ValueKey(_configuration.pathName),
              child: Scaffold(
                body: Builder(builder: (context) {
                  switch (_configuration.pathName) {
                    case Routes.partner:
                      return PartnerPage();
                    case Routes.test:
                      return const Testing();
                    default:
                      return const LandingPage();
                  }
                }),
              ),
            ),
        ],
        onPopPage: (route, result) {
          if (!route.didPop(result)) return false;

          _configuration = Configuration.home();
          notifyListeners();

          return true;
        });
  }

  @override
  Future<void> setNewRoutePath(Configuration configuration) async {
    _configuration = configuration;
  }

  void goToHome() {
    setNewRoutePath(Configuration.home());
    notifyListeners();
  }

  void goToPartner() {
    setNewRoutePath(Configuration.otherPage(Routes.partner));
    notifyListeners();
  }

  void goToTest() {
    setNewRoutePath(Configuration.otherPage(Routes.test));
    notifyListeners();
  }
}
