import 'package:flutter/material.dart';
import 'package:hevento/model/person.dart';
import 'package:hevento/routing/custom_router_delegate.dart';
import 'package:hevento/services/auth_service.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Person? appUser = Provider.of<Person?>(context);
    return Scaffold(
      body: Center(
        child: appUser != null
            ? const Center(child: Text("Already signed in"))
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    child: SizedBox(
                      width: 500,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Sign Up"),
                          TextFormField(
                            decoration: const InputDecoration(hintText: "full name"),
                            controller: _nameController,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(hintText: "email"),
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(hintText: "username"),
                            controller: _usernameController,
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
                                Person newPerson = Person('');
                                newPerson.name = _nameController.text;
                                newPerson.email = _emailController.text;
                                newPerson.username = _usernameController.text;
                                await Provider.of<AuthService>(context, listen: false).signUp(
                                  _emailController.text,
                                  _passwordController.text,
                                  newPerson,
                                );
                                context.read<CustomRouterDelegate>().goToHome();
                              },
                              child: const Text("Sign Up as User"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
