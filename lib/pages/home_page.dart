import 'package:flutter/material.dart';
import 'package:hevento/routes.dart';

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
            onPressed: () => Navigator.pushNamed(context, Routes.partner),
            child: const Text("Postani partner"),
          ),
        ],
      ),
    );
  }
}
