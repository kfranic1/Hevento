import 'package:flutter/material.dart';
import 'package:hevento/model/space.dart';
import 'package:hevento/pages/space_page.dart';
import 'package:hevento/widgets/custom_app_bar.dart';
import 'package:hevento/pages/home_page.dart';
import 'package:hevento/routing/configuraiton.dart';
import 'package:hevento/pages/partner_page.dart';
import 'package:hevento/pages/log_in_page.dart';
import 'package:hevento/routing/routes.dart';
import 'package:hevento/services/extensions/map_extensions.dart';
import 'package:hevento/services/extensions/string_extension.dart';
import 'package:hevento/widgets/custom_scroll_behavior.dart';
import 'package:provider/provider.dart';

class CustomRouterDelegate extends RouterDelegate<Configuration> with ChangeNotifier, PopNavigatorRouterDelegateMixin<Configuration>, Routes {
  Configuration _configuration = Configuration.home();

  @override
  GlobalKey<NavigatorState> get navigatorKey => GlobalKey<NavigatorState>();

  @override
  Configuration get currentConfiguration => _configuration;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: CustomScrollBehavior(),
      theme: ThemeData(fontFamily: 'Roboto'),
      debugShowCheckedModeBanner: false,
      home: Column(
        children: [
          const CustomAppBar(),
          Expanded(
            child: FutureBuilder(
                future: Space.getSpaces(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  List<Space> spaces = snapshot.data as List<Space>;
                  return Provider<List<Space>>(
                    create: (context) => spaces,
                    child: Navigator(
                      key: navigatorKey,
                      pages: [
                        if (_configuration.isHomePage)
                          const MaterialPage(
                            key: ValueKey('HomePage'),
                            child: HomePage(),
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
                                case Routes.space:
                                  return SpacePage(space: spaces.firstWhere((element) => element.id == _configuration.pathParams!["id"]));
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
                    ),
                  );
                }),
          ),
        ],
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

  @override
  void goToSpace({Map<String, String>? params = const {"id": "0"}}) {
    setNewRoutePath(Configuration.otherPage(Routes.space + params.toStringFromParams()));
    notifyListeners();
  }
}
