import 'package:flutter/material.dart';
import 'package:hevento/model/app_user.dart';
import 'package:hevento/services/auth_service.dart';
import 'package:hevento/services/enums/user_type.dart';
import 'package:provider/provider.dart';

class LogInPage extends StatelessWidget {
  LogInPage({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AppUser? appUser = Provider.of<AppUser?>(context);
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Provider.of<AuthService>(context, listen: false).signIn(_emailController.text, _passwordController.text, UserType.space);
                            },
                            child: const Text("Log In as Space"),
                          ),
                          const SizedBox(width: 20),
                          ElevatedButton(
                            onPressed: () async {
                              await Provider.of<AuthService>(context, listen: false)
                                  .signIn(_emailController.text, _passwordController.text, UserType.person);
                            },
                            child: const Text("Log In as User"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
