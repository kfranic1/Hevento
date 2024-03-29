import 'package:flutter/material.dart';
import 'package:hevento/routing/custom_router_delegate.dart';
import 'package:provider/provider.dart';

class TitleImage extends StatelessWidget {
  const TitleImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      child: InkWell(
        onTap: () => context.read<CustomRouterDelegate>().goToHome(),
        child: Image.asset(
          './assets/images/logo.png',
          height: 40,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
