import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hevento/model/person.dart';
import 'package:hevento/routing/custom_router_delegate.dart';
import 'package:hevento/services/auth_service.dart';
import 'package:hevento/services/constants.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? error;
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    Person? appUser = context.watch<Person?>();
    if (appUser != null) {
      WidgetsBinding.instance?.addPostFrameCallback((_) => context.read<CustomRouterDelegate>().goToLastPage());
      return loader;
    }
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (constraints.maxWidth > kNarrow)
                Expanded(
                  child: Image.asset(
                    'images/registerImage.jpg',
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height,
                  ),
                ),
              if (constraints.maxWidth > kNarrow) const SizedBox(width: 50),
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: Form(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "Dobro došli !",
                            style: titleStyle,
                          ),
                          const Text("Kreiraj svoj profil", style: subTitleStyle),
                          const SizedBox(height: 100),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * (constraints.maxWidth > kNarrow ? 0.35 : 0.7),
                            child: TextFormField(
                              cursorColor: darkGreen,
                              decoration: const InputDecoration(
                                  hintText: "Ime i prezime: ",
                                  hintStyle: TextStyle(fontWeight: FontWeight.bold),
                                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: darkGreen, width: 2.0)),
                                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: darkGreen, width: 2.0))),
                              controller: _nameController,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * (constraints.maxWidth > kNarrow ? 0.35 : 0.7),
                            child: TextFormField(
                              cursorColor: darkGreen,
                              decoration: const InputDecoration(
                                  hintText: "email: example@ex.com",
                                  hintStyle: TextStyle(fontWeight: FontWeight.bold),
                                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: darkGreen, width: 2.0)),
                                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: darkGreen, width: 2.0))),
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * (constraints.maxWidth > kNarrow ? 0.35 : 0.7),
                            child: TextFormField(
                              cursorColor: darkGreen,
                              decoration: const InputDecoration(
                                  hintText: "Korisničko ime",
                                  hintStyle: TextStyle(fontWeight: FontWeight.bold),
                                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: darkGreen, width: 2.0)),
                                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: darkGreen, width: 2.0))),
                              controller: _usernameController,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * (constraints.maxWidth > kNarrow ? 0.35 : 0.7),
                            child: TextFormField(
                              obscureText: !_passwordVisible,
                              cursorColor: darkGreen,
                              decoration: InputDecoration(
                                hintText: "Lozinka",
                                hintStyle: const TextStyle(fontWeight: FontWeight.bold),
                                enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: darkGreen, width: 2.0)),
                                focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: darkGreen, width: 2.0)),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                              ),
                              controller: _passwordController,
                            ),
                          ),
                          const SizedBox(height: 85),
                          Container(
                            height: 50,
                            width: max(MediaQuery.of(context).size.width * 0.2, 200),
                            decoration: BoxDecoration(color: darkGreen, borderRadius: BorderRadius.circular(10)),
                            child: ElevatedButton(
                              onPressed: () async {
                                Person newPerson = Person('');
                                newPerson.name = _nameController.text;
                                newPerson.email = _emailController.text;
                                newPerson.username = _usernameController.text;
                                String? result = await Provider.of<AuthService>(context, listen: false).signUp(
                                  _emailController.text,
                                  _passwordController.text,
                                  newPerson,
                                );
                                if (result == null) context.read<CustomRouterDelegate>().goToHome();
                                setState(() {
                                  error = result;
                                });
                              },
                              child: const Text(
                                "Kreiraj profil",
                                style: buttonTxtStyle,
                              ),
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(darkGreen)),
                            ),
                          ),
                          const SizedBox(height: 20),
                          if (error != null) Text(error!),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
