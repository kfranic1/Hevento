import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            "Hevento",
            style: TextStyle(
              color: Colors.amber,
              fontSize: 40,
            ),
          ),
        ],
      ),
    );
  }
}
