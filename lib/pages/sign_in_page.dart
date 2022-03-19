import 'package:flutter/material.dart';
import 'package:hevento/model/app_user.dart';
import 'package:hevento/model/person.dart';
import 'package:hevento/model/space.dart';
import 'package:hevento/services/auth_service.dart';
import 'package:hevento/services/enums/user_type.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AppUser? appUser = Provider.of<AppUser?>(context);
    return Center(
      child: appUser != null
          ? Center(
              child: StreamBuilder(
                  stream: appUser is Space ? appUser.self : (appUser as Person).self,
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? const LinearProgressIndicator()
                        : Text("Already signed in as ${appUser is Space ? appUser.name : (appUser as Person).name}");
                  }),
            )
          : Form(
              child: SizedBox(
                width: 500,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Sign In"),
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
                          child: const Text("Sign In as Space"),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await Provider.of<AuthService>(context, listen: false)
                                .signIn(_emailController.text, _passwordController.text, UserType.person);
                          },
                          child: const Text("Sign In as User"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
