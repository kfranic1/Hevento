import 'package:flutter/material.dart';

class PartnerPage extends StatelessWidget {
  final VoidCallback goToTest;
  PartnerPage({Key? key, required this.goToTest}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 200,
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(hintText: "email"),
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: goToTest,
                child: const Text("Pošalji"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
