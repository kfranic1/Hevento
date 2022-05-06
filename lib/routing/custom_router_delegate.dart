import 'package:flutter/material.dart';
import 'package:hevento/model/space.dart';
import 'package:hevento/pages/register_page.dart';
import 'package:hevento/pages/space/space_page.dart';
import 'package:hevento/pages/home/home_page.dart';
import 'package:hevento/routing/configuraiton.dart';
import 'package:hevento/pages/partner_page.dart';
import 'package:hevento/pages/log_in_page.dart';
import 'package:hevento/routing/routes.dart';
import 'package:hevento/services/extensions/map_extensions.dart';
import 'package:hevento/services/extensions/string_extension.dart';
import 'package:provider/provider.dart';

class CustomRouterDelegate extends RouterDelegate<Configuration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<Configuration>
    implements Routes {
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
          MaterialPage(
            key: ValueKey(_configuration.pathName),
            child: const HomePage(),
          ),
        if (_configuration.isOtherPage)
          MaterialPage(
            key: ValueKey(_configuration.pathName),
            child: Builder(builder: (context) {
              switch (_configuration.pathName!.removeParams()) {
                case Routes.partner:
                  return PartnerPage(params: _configuration.pathParams.toString());
                case Routes.login:
                  return const LogInPage();
                case Routes.space:
                  return SpacePage(space: context.read<List<Space>>().firstWhere((element) => element.id == _configuration.pathParams!["id"]));
                case Routes.register:
                  return const RegisterPage();
                default:
                  return const HomePage();
              }
            }),
          ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        _configuration = Configuration.home();
        notifyListeners();
        return true;
      },
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
  void goToLogin({Map<String, String>? params}) {
    setNewRoutePath(Configuration.otherPage(Routes.login + params.toStringFromParams()));
    notifyListeners();
  }

  @override
  void goToSpace({Map<String, String>? params = const {"id": "0"}}) {
    setNewRoutePath(Configuration.otherPage(Routes.space + params.toStringFromParams()));
    notifyListeners();
  }

  @override
  void goToRegister({Map<String, String>? params}) {
    setNewRoutePath(Configuration.otherPage(Routes.register + params.toStringFromParams()));
    notifyListeners();
  }
}
