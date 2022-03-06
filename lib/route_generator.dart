import 'package:flutter/material.dart';
import 'package:hevento/pages/home_page.dart';
import 'package:hevento/pages/partner_page.dart';
import 'package:hevento/routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    print(settings.name);
    switch (settings.name) {
      case Routes.home:
        return _GeneratePageRoute(const LandingPage(), settings.name!);
      case Routes.partner:
        return _GeneratePageRoute(PartnerPage(), settings.name!);
      default:
        return _GeneratePageRoute(const LandingPage(), settings.name!);
    }
  }
}

class _GeneratePageRoute extends PageRouteBuilder {
  final Widget widget;
  final String routeName;
  _GeneratePageRoute(this.widget, this.routeName)
      : super(
            settings: RouteSettings(name: routeName),
            pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
              return widget;
            },
            transitionDuration: const Duration(milliseconds: 500),
            transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
              return SlideTransition(
                textDirection: TextDirection.rtl,
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            });
}
