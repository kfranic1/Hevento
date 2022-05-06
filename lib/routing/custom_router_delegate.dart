import 'package:flutter/material.dart';
import 'package:hevento/model/space.dart';
import 'package:hevento/pages/register_page.dart';
import 'package:hevento/pages/space/space_page.dart';
import 'package:hevento/pages/home/home_page.dart';
import 'package:hevento/routing/configuraiton.dart';
import 'package:hevento/pages/partner_page.dart';
import 'package:hevento/pages/log_in_page.dart';
import 'package:hevento/routing/routes.dart';
import 'package:hevento/services/constants.dart';
import 'package:hevento/services/extensions/map_extensions.dart';
import 'package:hevento/services/extensions/string_extension.dart';
import 'package:hevento/widgets/custom_divider.dart';
import 'package:hevento/widgets/custom_scroll_behavior.dart';
import 'package:hevento/widgets/space_list_item.dart';
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
    return MaterialApp(
      scrollBehavior: CustomScrollBehavior(),
      theme: ThemeData(
        fontFamily: 'Roboto',
        primarySwatch: darkGreenMaterialColor,
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
          future: Space.getSpaces(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            List<Space> spaces = snapshot.data as List<Space>;
            return MultiProvider(
              providers: [
                Provider<List<Space>>(create: (context) => spaces),
                Provider<List<SpaceListItem>>(create: (context) => spaces.map((e) => SpaceListItem(space: e)).toList()),
                Provider<AppBar>(
                  create: (context) => AppBar(
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    centerTitle: false,
                    leadingWidth: 0,
                    title: GestureDetector(
                      child: Image.asset('./assets/images/title.png'),
                      onTap: () => context.read<CustomRouterDelegate>().goToHome(),
                    ),
                    toolbarHeight: 80,
                    backgroundColor: lightGreen,
                    bottom: const PreferredSize(
                      preferredSize: Size(double.infinity, 2),
                      child: CustomDivider(
                        divider: Divider(
                          thickness: 2,
                          color: darkGreen,
                          indent: 0,
                          endIndent: 0,
                          height: 2,
                        ),
                        right: lightGreen,
                      ),
                    ),
                  ),
                ),
              ],
              child: Navigator(
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
                            return SpacePage(space: spaces.firstWhere((element) => element.id == _configuration.pathParams!["id"]));
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
              ),
            );
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
