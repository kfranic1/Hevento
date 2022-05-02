import 'package:flutter/material.dart';
import 'package:hevento/model/app_user.dart';
import 'package:hevento/model/person.dart';
import 'package:hevento/model/space.dart';
import 'package:hevento/services/auth_service.dart';
import 'package:hevento/services/enums/user_type.dart';
import 'package:provider/provider.dart';

class PartnerPage extends StatelessWidget {
  final String? params;
  PartnerPage({Key? key, this.params}) : super(key: key);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AppUser? appUser = Provider.of<AppUser?>(context);
    return Scaffold(
      body: Center(
        child: appUser != null
            ? const Center(
                child: Text(
                    "Already signed in"), /*StreamBuilder(
                    stream: appUser.self,
                    builder: (context, snapshot) {
                      return !snapshot.hasData
                          ? const LinearProgressIndicator()
                          : const Text("Already signed in as ${appUser is Space ? appUser.name : (appUser as Person).name}");
                    }),*/
              )
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
                            decoration: const InputDecoration(hintText: "name"),
                            controller: _nameController,
                          ),
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
                                  Space newSpace = Space('');
                                  newSpace.name = _nameController.text;
                                  Provider.of<AuthService>(context, listen: false).signUp(
                                    _emailController.text,
                                    _passwordController.text,
                                    UserType.space,
                                    space: newSpace,
                                  );
                                },
                                child: const Text("Sign Up as Space"),
                              ),
                              const SizedBox(width: 20),
                              ElevatedButton(
                                onPressed: () {
                                  Person newPerson = Person('');
                                  newPerson.name = _nameController.text;
                                  newPerson.email = _emailController.text;
                                  Provider.of<AuthService>(context, listen: false).signUp(
                                    _emailController.text,
                                    _passwordController.text,
                                    UserType.person,
                                    person: newPerson,
                                  );
                                },
                                child: const Text("Sign Up as User"),
                              ),
                            ],
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
