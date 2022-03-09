import 'package:flutter/material.dart';
import 'package:hevento/custom_router_delegate.dart';
import 'package:provider/provider.dart';

class Testing extends StatelessWidget {
  const Testing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () => (Provider.of<RouterDelegate<Object>>(context, listen: false) as CustomRouterDelegate).goToHome(),
        child: const Text("Home"),
      ),
    );
  }
}
