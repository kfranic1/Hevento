import 'package:flutter/material.dart';
import 'package:hevento/services/auth_service.dart';
import 'package:provider/provider.dart';

class PartnerPage extends StatelessWidget {
  PartnerPage({Key? key}) : super(key: key);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                decoration: const InputDecoration(hintText: "name"),
                controller: _nameController,
                keyboardType: TextInputType.emailAddress,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: "email"),
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: "password"),
                controller: _passwordController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Provider.of<AuthService>(context, listen: false).signUpSpace(_emailController.text, _passwordController.text, _nameController.text);
                },
                child: const Text("Pošalji"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
