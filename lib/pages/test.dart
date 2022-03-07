import 'package:flutter/material.dart';
import 'package:hevento/custom_router_delegate.dart';
import 'package:hevento/main.dart';

class Testing extends StatelessWidget {
  const Testing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () => (MyApp.routerDelegate as CustomRouterDelegate).goToHome(),
        child: const Text("Home"),
      ),
    );
  }
}
