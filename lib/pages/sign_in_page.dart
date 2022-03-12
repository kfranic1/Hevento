import 'package:flutter/material.dart';
import 'package:hevento/model/space.dart';
import 'package:hevento/services/auth_service.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Space? space = Provider.of<Space?>(context);
    return Center(
      child: SizedBox(
        width: 200,
        child: space != null
            ? Center(
                child: StreamBuilder(
                    stream: space.self,
                    builder: (context, snapshot) {
                      return !snapshot.hasData ? const LinearProgressIndicator() : Text("Already signed in as ${space.name}");
                    }),
              )
            : Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                        Provider.of<AuthService>(context, listen: false).signInSpace(_emailController.text, _passwordController.text);
                      },
                      child: const Text("Sign In"),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
