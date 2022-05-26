import 'package:flutter/material.dart';
import 'package:hevento/model/person.dart';
import 'package:hevento/pages/dashboard/dashboard_page_secondary.dart';
import 'package:hevento/pages/dashboard/dashboard_page_primary.dart';
import 'package:hevento/routing/custom_router_delegate.dart';
import 'package:hevento/services/constants.dart';
import 'package:hevento/widgets/page_wrapper.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Person? appUser = context.watch<Person?>();
    if (appUser == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => context.read<CustomRouterDelegate>().goToLogin());
      return loader;
    }
    return const PageWrapper(
      primary: DashboardPagePrimary(),
      secondary: DashboardPageSecondary(),
    );
  }
}
