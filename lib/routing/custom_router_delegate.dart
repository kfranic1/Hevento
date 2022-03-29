import 'package:flutter/material.dart';
import 'package:hevento/pages/landing_page.dart';
import 'package:hevento/routing/configuraiton.dart';
import 'package:hevento/pages/partner_page.dart';
import 'package:hevento/pages/log_in_page.dart';
import 'package:hevento/routing/routes.dart';
import 'package:hevento/services/constants.dart';
import 'package:provider/provider.dart';
import 'package:hevento/services/extensions/map_extensions.dart';
import 'package:hevento/services/extensions/string_extension.dart';

class CustomRouterDelegate extends RouterDelegate<Configuration> with ChangeNotifier, PopNavigatorRouterDelegateMixin<Configuration>, Routes {
  Configuration _configuration = Configuration.home();

  @override
  GlobalKey<NavigatorState> get navigatorKey => GlobalKey<NavigatorState>();

  @override
  Configuration get currentConfiguration => _configuration;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Roboto'),
      debugShowCheckedModeBanner: false,
      home: LayoutBuilder(
        builder: (context, constraints) => Scaffold(
          bottomNavigationBar: Container(height: 100, color: Colors.grey),
          extendBodyBehindAppBar: true,
          appBar: constraints.maxWidth < kNarrow ? AppBar() : context.watch<AppBar>(),
          drawer: constraints.maxWidth < kNarrow ? Drawer(child: Image.asset('./assets/images/title.png')) : null,
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
                      switch (_configuration.pathName!.removeParams()) {
                        case Routes.partner:
                          return PartnerPage(params: _configuration.pathParams.toString());
                        case Routes.test:
                          return LogInPage();
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
        ),
      ),
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
  void goToPartner({Map<String, String>? params}) {
    setNewRoutePath(Configuration.otherPage(Routes.partner + params.toStringFromParams()));
    notifyListeners();
  }

  @override
  void goToTest({Map<String, String>? params}) {
    setNewRoutePath(Configuration.otherPage(Routes.test + params.toStringFromParams()));
    notifyListeners();
  }
}
