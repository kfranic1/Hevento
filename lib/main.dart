import 'package:flutter/material.dart';
import 'package:hevento/custom_router_delegate.dart';
import 'package:url_strategy/url_strategy.dart';

import 'custom_route_information_parser.dart';

void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static final RouteInformationParser<Object> routeInformationParser = CustomRouteInformationParser();
  static final RouterDelegate<Object> routerDelegate = CustomRouterDelegate();
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Hevento',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      routeInformationParser: routeInformationParser,
      routerDelegate: routerDelegate,
    );
  }
}
