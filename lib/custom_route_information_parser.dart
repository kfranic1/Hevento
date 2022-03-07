import 'package:flutter/material.dart';
import 'package:hevento/configuraiton.dart';

class CustomRouteInformationParser extends RouteInformationParser<Configuration> {
  @override
  Future<Configuration> parseRouteInformation(RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);

    if (uri.pathSegments.isEmpty) return Configuration.home();
    return Configuration.otherPage(uri.pathSegments.join('/').toString());
  }

  @override
  RouteInformation restoreRouteInformation(Configuration configuration) {
    if (configuration.isHomePage) return const RouteInformation(location: '/');
    if (configuration.isOtherPage) return RouteInformation(location: '/${configuration.pathName}');
    return const RouteInformation(location: '/');
  }
}
