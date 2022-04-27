import 'package:flutter/material.dart';
import 'package:hevento/helpers/custom_divider.dart';
import 'package:hevento/model/app_user.dart';
import 'package:hevento/pages/landing_page.dart';
import 'package:hevento/routing/configuraiton.dart';
import 'package:hevento/pages/partner_page.dart';
import 'package:hevento/pages/log_in_page.dart';
import 'package:hevento/routing/routes.dart';
import 'package:hevento/services/auth_service.dart';
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
    AppUser? appUser = Provider.of<AppUser?>(context);
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Roboto'),
      debugShowCheckedModeBanner: false,
      home: LayoutBuilder(
        builder: (context, constraints) => Scaffold(
          bottomNavigationBar: Container(height: 100, color: Colors.grey),
          extendBodyBehindAppBar: true,
          //appBar: constraints.maxWidth < kNarrow ? AppBar() : context.watch<AppBar>(),
          drawer: constraints.maxWidth < kNarrow ? Drawer(child: Image.asset('./assets/images/title.png')) : null,
          body: Column(
            children: [
              SizedBox(
                height: 80,
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              child: Image.asset('./assets/images/title.png'),
                              onTap: () => context.read<CustomRouterDelegate>().goToHome(),
                            ),
                            const Expanded(
                              child: SizedBox(),
                            ),
                            if (appUser == null)
                              TextButton(
                                onPressed: () => context.read<CustomRouterDelegate>().goToTest(),
                                child: const Text(
                                  "Imam profil",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Container(
                          height: 80,
                          color: lightGreen,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (appUser == null)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: 175,
                                    child: ElevatedButton(
                                      onPressed: () => context.read<CustomRouterDelegate>().goToTest(),
                                      child: const Text(
                                        "Registriraj se",
                                        //style: TextStyle(color: Colors.white),
                                      ),
                                      style: ElevatedButton.styleFrom(primary: darkGreen),
                                    ),
                                  ),
                                ),
                              if (appUser != null)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: 175,
                                    child: ElevatedButton(
                                      onPressed: () async => await Provider.of<AuthService>(context, listen: false).signOut(),
                                      child: const Text(
                                        "Sign out",
                                      ),
                                      style: ElevatedButton.styleFrom(primary: darkGreen),
                                    ),
                                  ),
                                ),
                              const SizedBox(width: 15),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: 175,
                                  child: ElevatedButton(
                                    onPressed: () => context.read<CustomRouterDelegate>().goToPartner(),
                                    style: ElevatedButton.styleFrom(primary: darkGreen),
                                    child: const Text(
                                      "Postani partner",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
              CustomDivider(
                divider: const Divider(
                  thickness: 2,
                  color: Colors.black,
                  indent: 0,
                  endIndent: 0,
                  height: 2,
                ),
                right: lightGreen,
              ),
              Expanded(
                child: Navigator(
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
            ],
          ),
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
