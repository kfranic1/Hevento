import 'package:flutter/material.dart';
import 'package:hevento/model/person.dart';
import 'package:hevento/services/auth_service.dart';
import 'package:provider/provider.dart';

class LogInPage extends StatelessWidget {
  LogInPage({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Person? appUser = Provider.of<Person?>(context);
    return Scaffold(
      body: Center(
        child: appUser != null
            ? const Center(child: Text("Already signed in"))
            : Form(
                child: SizedBox(
                  width: 500,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Log In"),
                      TextFormField(
                        decoration: const InputDecoration(hintText: "email"),
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(hintText: "password"),
                        controller: _passwordController,
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            await Provider.of<AuthService>(context, listen: false).signIn(
                              _emailController.text,
                              _passwordController.text,
                            );
                          },
                          child: const Text("Log In as User"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
