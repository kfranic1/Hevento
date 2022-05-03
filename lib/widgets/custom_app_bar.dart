import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hevento/model/person.dart';
import 'package:hevento/routing/custom_router_delegate.dart';
import 'package:hevento/services/auth_service.dart';
import 'package:hevento/services/constants.dart';
import 'package:hevento/widgets/custom_divider.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Person? appUser = context.watch<Person?>();
    return LayoutBuilder(
      builder: (context, constraints) {
        return constraints.maxWidth < kNarrow
            ? const SizedBox(height: 0, width: 0)
            : Column(
                children: [
                  SizedBox(
                    height: 80,
                    child: Row(
                      children: [
                        SizedBox(
                          width: constraints.maxWidth - max(constraints.maxWidth * 2 / 7, 400),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  child: Image.asset('./assets/images/title.png'),
                                  onTap: () => context.read<CustomRouterDelegate>().goToHome(),
                                ),
                                const Expanded(child: SizedBox()),
                                if (appUser == null)
                                  TextButton(
                                    onPressed: () => context.read<CustomRouterDelegate>().goToLogin(),
                                    child: const Text(
                                      "Imam profil",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 80,
                          width: max(constraints.maxWidth * 2 / 7, 400),
                          color: lightGreen,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (appUser == null)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: 175,
                                    child: ElevatedButton(
                                      onPressed: () => context.read<CustomRouterDelegate>().goToRegister(),
                                      child: const Text("Registriraj se"),
                                      style: ElevatedButton.styleFrom(primary: darkGreen),
                                    ),
                                  ),
                                ),
                              if (appUser != null)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: 175,
                                    child: ElevatedButton(
                                      onPressed: () async => await Provider.of<AuthService>(context, listen: false).signOut(),
                                      child: const Text("Sign out"),
                                      style: ElevatedButton.styleFrom(primary: darkGreen),
                                    ),
                                  ),
                                ),
                              const SizedBox(width: 15),
                              if (appUser != null)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: 175,
                                    child: ElevatedButton(
                                      onPressed: () => context.read<CustomRouterDelegate>().goToPartner(),
                                      style: ElevatedButton.styleFrom(primary: darkGreen),
                                      child: StreamBuilder(
                                          stream: appUser.self,
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData) return const Center(child: LinearProgressIndicator());
                                            return Text(
                                              appUser.mySpaces.isEmpty ? "Postani partner" : "Nadzorna ploča",
                                              textAlign: TextAlign.center,
                                            );
                                          }),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomDivider(
                    divider: Divider(
                      thickness: 2,
                      color: darkGreen,
                      indent: 0,
                      endIndent: 0,
                      height: 2,
                    ),
                    right: lightGreen,
                  ),
                ],
              );
      },
    );
  }
}
