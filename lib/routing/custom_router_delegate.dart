import 'package:flutter/material.dart';
import 'package:hevento/routing/configuraiton.dart';
import 'package:hevento/pages/partner_page.dart';
import 'package:hevento/pages/test.dart';
import 'package:hevento/routing/routes.dart';
import 'package:provider/provider.dart';

import '../pages/home_page.dart';

class CustomRouterDelegate extends RouterDelegate<Configuration> with ChangeNotifier, PopNavigatorRouterDelegateMixin<Configuration>, Routes {
  Configuration _configuration = Configuration.home();

  @override
  GlobalKey<NavigatorState> get navigatorKey => GlobalKey<NavigatorState>();

  @override
  Configuration get currentConfiguration => _configuration;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: context.watch<AppBar>(),
      body: Navigator(
          key: navigatorKey,
          pages: [
            if (_configuration.isHomePage)
              const MaterialPage(
                key: ValueKey('HomePage'),
                child: LandingPage(),
              ),
            if (_configuration.isOtherPage)
              MaterialPage(
                key: ValueKey(_configuration.pathName),
                child: Builder(builder: (context) {
                  switch (_configuration.pathName) {
                    case Routes.partner:
                      return PartnerPage();
                    case Routes.test:
                      return Testing();
                    default:
                      return const LandingPage();
                  }
                }),
              ),
          ],
          onPopPage: (route, result) {
            if (!route.didPop(result)) return false;

            _configuration = Configuration.home();
            notifyListeners();

            return true;
          }),
    );
  }

  @override
  Future<void> setNewRoutePath(Configuration configuration) async {
    _configuration = configuration;
  }

  @override
  void goToHome() {
    setNewRoutePath(Configuration.home());
    notifyListeners();
  }

  @override
  void goToPartner() {
    setNewRoutePath(Configuration.otherPage(Routes.partner));
    notifyListeners();
  }

  @override
  void goToTest() {
    setNewRoutePath(Configuration.otherPage(Routes.test));
    notifyListeners();
  }
}
