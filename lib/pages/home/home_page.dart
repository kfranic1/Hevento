import 'package:flutter/material.dart';
import 'package:hevento/pages/home/home_page_primary.dart';
import 'package:hevento/pages/home/home_page_secondary.dart';
import 'package:hevento/widgets/custom_app_bar.dart';
import 'package:hevento/widgets/page_wrapper.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PageWrapper(
      primary: HomePagePrimary(),
      customAppBar: CustomAppBar(),
      secondary: HomePageSecondary(),
    );
  }
}
