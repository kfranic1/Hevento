import 'package:flutter/material.dart';
import 'package:hevento/custom_router_delegate.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Hevento",
            style: TextStyle(
              color: Colors.amber,
              fontSize: 40,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () => (Provider.of<RouterDelegate<Object>>(context, listen: false) as CustomRouterDelegate).goToPartner(),
            child: const Text("Postani partner"),
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () => (Provider.of<RouterDelegate<Object>>(context, listen: false) as CustomRouterDelegate).goToTest(),
            child: const Text("Test"),
          ),
        ],
      ),
    );
  }
}
