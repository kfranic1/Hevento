import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hevento/model/person.dart';
import 'package:hevento/model/space.dart';
import 'package:hevento/routing/custom_router_delegate.dart';
import 'package:hevento/services/auth_service.dart';
import 'package:hevento/services/constants.dart';
import 'package:hevento/widgets/custom_divider.dart';
import 'package:hevento/widgets/title_image.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Person? appUser = context.watch<Person?>();
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            SizedBox(
              height: 80,
              child: Row(
                children: [
                  SizedBox(
                    width: constraints.maxWidth - max(constraints.maxWidth * 2 / 7, 400),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            //TODO remove 0 *
                            padding: EdgeInsets.only(left: 0 * constraints.maxWidth * 0.02),
                            child: const TitleImage(),
                          ),
                          const Expanded(child: SizedBox()),
                          if (appUser == null)
                            TextButton(
                              onPressed: () => context.read<CustomRouterDelegate>().goToLogin(),
                              child: const Text(
                                "Imam profil",
                                style: TextStyle(color: Colors.black),
                              ),
                            )
                          else
                            StreamBuilder(
                                stream: appUser.self,
                                builder: (context, snapshot) {
                                  return Text(!snapshot.hasData ? "" : "Prijavljen kao ${appUser.username}");
                                })
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
                                onPressed: () async => await context.read<AuthService>().signOut(),
                                child: const Text("Odjava"),
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
                                onPressed: () => context.read<CustomRouterDelegate>().goToDashboard(),
                                style: ElevatedButton.styleFrom(primary: darkGreen),
                                child: StreamBuilder(
                                    stream: appUser.self,
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) return const Text("");
                                      return Text(
                                        context.read<List<Space>>().any((element) => element.owner.id == appUser.id)
                                            ? "Nadzorna ploča"
                                            : "Postani partner",
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
            const CustomDivider(
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
