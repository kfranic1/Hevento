import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hevento/model/person.dart';
import 'package:hevento/model/space.dart';
import 'package:hevento/routing/custom_router_delegate.dart';
import 'package:hevento/services/auth_service.dart';
import 'package:hevento/services/constants.dart';
import 'package:provider/provider.dart';

class AuthButtons extends StatelessWidget {
  const AuthButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Person? appUser = context.watch<Person?>();
    return LayoutBuilder(builder: (context, constraints) {
      return SizedBox(
        width: max(375, constraints.maxWidth * .2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (appUser == null) ...[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => context.read<CustomRouterDelegate>().goToLogin(),
                    child: const Text(
                      "Imam profil",
                      textAlign: TextAlign.center,
                    ),
                    style: ElevatedButton.styleFrom(primary: darkGreen),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => context.read<CustomRouterDelegate>().goToRegister(),
                    child: const Text(
                      "Registriraj se",
                      textAlign: TextAlign.center,
                    ),
                    style: ElevatedButton.styleFrom(primary: darkGreen),
                  ),
                ),
              ),
            ] else ...[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    //width: max(175, constraints.maxWidth * 0.25),
                    child: ElevatedButton(
                      onPressed: () async => await context.read<AuthService>().signOut(),
                      child: const Text(
                        "Odjava",
                        textAlign: TextAlign.center,
                      ),
                      style: ElevatedButton.styleFrom(primary: darkGreen),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    //width: 175,
                    child: ElevatedButton(
                      onPressed: () => context.read<CustomRouterDelegate>().goToDashboard(),
                      style: ElevatedButton.styleFrom(primary: darkGreen),
                      child: StreamBuilder(
                          stream: appUser.self,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) return const Text("");
                            return Text(
                              context.read<List<Space>>().any((element) => element.owner.id == appUser.id) ? "Nadzorna ploča" : "Postani partner",
                              textAlign: TextAlign.center,
                            );
                          }),
                    ),
                  ),
                ),
              ),
            ]
          ],
        ),
      );
    });
  }
}
