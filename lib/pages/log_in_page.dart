import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hevento/model/person.dart';
import 'package:hevento/services/auth_service.dart';
import 'package:hevento/services/constants.dart';
import 'package:hevento/widgets/title_image.dart';
import 'package:provider/provider.dart';

import '../routing/custom_router_delegate.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? error;
  bool _passwordVisible = false;
  bool loading = false;

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
          child: Row(children: [
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
                        const TitleImage(),
                        const SizedBox(height: 30),
                        const Text("Dobro došli !", style: titleStyle),
                        const Text("Prijavi se na svoj profil", style: subTitleStyle),
                        const SizedBox(height: 170),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * (constraints.maxWidth > kNarrow ? 0.35 : 0.7),
                          child: TextFormField(
                            cursorColor: darkGreen,
                            decoration: const InputDecoration(
                              icon: Icon(
                                Icons.person_add_alt,
                                color: darkGreen,
                                size: 30,
                              ),
                              hintText: "Korisničko ime",
                              hintStyle: TextStyle(fontWeight: FontWeight.bold),
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: darkGreen, width: 2.0)),
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: darkGreen, width: 2.0)),
                            ),
                            controller: _usernameController,
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        const SizedBox(height: 80),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * (constraints.maxWidth > kNarrow ? 0.35 : 0.7),
                          child: TextFormField(
                            cursorColor: darkGreen,
                            decoration: InputDecoration(
                              icon: const Icon(FontAwesomeIcons.lock, color: darkGreen),
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
                            obscureText: !_passwordVisible,
                          ),
                        ),
                        const SizedBox(height: 100),
                        loading
                            ? loader
                            : Container(
                                height: 50,
                                width: max(MediaQuery.of(context).size.width * 0.1, 100),
                                decoration: BoxDecoration(color: darkGreen, borderRadius: BorderRadius.circular(10)),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    setState(() {
                                      loading = true;
                                    });
                                    String? result = await context.read<AuthService>().signIn(
                                          username: _usernameController.text,
                                          password: _passwordController.text,
                                        );
                                    if (result == null) context.read<CustomRouterDelegate>().goToLastPage();
                                    setState(() {
                                      error = result;
                                      loading = false;
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
