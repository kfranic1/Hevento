import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hevento/model/person.dart';
import 'package:hevento/services/auth_service.dart';
import 'package:hevento/services/constants.dart';
import 'package:provider/provider.dart';

import '../routing/custom_router_delegate.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? error;

  @override
  Widget build(BuildContext context) {
    Person? appUser = Provider.of<Person?>(context);
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Center(
          child: appUser != null
              ? const Center(child: Text("Already signed in"))
              : Row(children: [
                  if (constraints.maxWidth > kNarrow)
                    Expanded(
                      child: Image.asset(
                        'images/loginImage.jpg',
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Dobro došli !", style: titleStyle),
                              const Text("Prijavi se na svoj profil", style: subTitleStyle),
                              const SizedBox(height: 210),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * (constraints.maxWidth > kNarrow ? 0.35 : 0.7),
                                child: TextFormField(
                                  cursorColor: darkGreen,
                                  decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.person_add_alt,
                                      color: darkGreen,
                                      size: 30,
                                    ),
                                    hintText: "example@ex.com",
                                    hintStyle: const TextStyle(fontWeight: FontWeight.bold),
                                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: darkGreen, width: 2.0)),
                                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: darkGreen, width: 2.0)),
                                  ),
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                              const SizedBox(height: 80),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * (constraints.maxWidth > kNarrow ? 0.35 : 0.7),
                                child: TextFormField(
                                  cursorColor: darkGreen,
                                  decoration: InputDecoration(
                                    icon: Icon(FontAwesomeIcons.lock, color: darkGreen),
                                    hintText: "Lozinka",
                                    hintStyle: const TextStyle(fontWeight: FontWeight.bold),
                                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: darkGreen, width: 2.0)),
                                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: darkGreen, width: 2.0)),
                                  ),
                                  controller: _passwordController,
                                  obscureText: true,
                                ),
                              ),
                              const SizedBox(height: 220),
                              Container(
                                height: MediaQuery.of(context).size.height * 0.05,
                                width: max(MediaQuery.of(context).size.width * 0.1, 100),
                                decoration: BoxDecoration(color: darkGreen, borderRadius: BorderRadius.circular(10)),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    String? result = await Provider.of<AuthService>(context, listen: false).signIn(
                                      _emailController.text,
                                      _passwordController.text,
                                    );
                                    if (result == null) context.read<CustomRouterDelegate>().goToHome();
                                    setState(() {
                                      error = result;
                                    });
                                  },
                                  child: const Text(
                                    "Prijava",
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
                ]),
        ),
      );
    });
  }
}
