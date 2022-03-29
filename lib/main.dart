import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hevento/generated/firebase_options.dart';
import 'package:hevento/model/app_user.dart';
import 'package:hevento/routing/custom_route_information_parser.dart';
import 'package:hevento/routing/custom_router_delegate.dart';
import 'package:hevento/services/auth_service.dart';
import 'package:hevento/services/constants.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (context) => AuthService(FirebaseAuth.instance),
        ),
        StreamProvider<AppUser?>(
          create: (context) => context.read<AuthService>().authStateChanges,
          initialData: null,
        ),
        Provider<CustomRouteInformationParser>(
          create: (context) => CustomRouteInformationParser(),
        ),
        ListenableProvider<CustomRouterDelegate>(
          create: (context) => CustomRouterDelegate(),
        ),
      ],
      child: Builder(builder: (context) {
        AppUser? appUser = Provider.of<AppUser?>(context);
        return Provider.value(
          value: AppBar(
            elevation: 0,
            bottom: PreferredSize(
              child: Container(
                color: Colors.black,
                height: 4.0,
              ),
              preferredSize: const Size.fromHeight(4.0),
            ),
            backgroundColor: Colors.transparent,
            title: Image.asset('images/title.png'),
            actions: [
              /*TextButton(
                onPressed: () => context.read<CustomRouterDelegate>().goToHome(),
                child: const Text(
                  "Home",
                  style: TextStyle(color: Colors.black),
                ),
              ),*/
              if (appUser == null)
                TextButton(
                  onPressed: () => context.read<CustomRouterDelegate>().goToTest(),
                  child: const Text(
                    "Imam profil",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              const SizedBox(width: 30),
              if (appUser == null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 175,
                    child: ElevatedButton(
                      onPressed: () => context.read<CustomRouterDelegate>().goToTest(),
                      child: const Text(
                        "Registriraj se",
                        //style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(primary: darkGreen),
                    ),
                  ),
                ),
              const SizedBox(width: 15),
              if (appUser != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () async => await Provider.of<AuthService>(context, listen: false).signOut(),
                      child: const Text(
                        "Sign out",
                      ),
                      style: ElevatedButton.styleFrom(primary: darkGreen),
                    ),
                  ),
                ),
              const SizedBox(width: 15),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () => context.read<CustomRouterDelegate>().goToPartner(),
                  child: const Center(
                    child: SizedBox(
                      width: 150,
                      child: Text(
                        "Postani partner",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(primary: darkGreen),
                ),
              ),
            ],
          ),
          child: MaterialApp.router(
            title: 'Hevento',
            theme: ThemeData(
              primarySwatch: Colors.green,
            ),
            debugShowCheckedModeBanner: false,
            routeInformationParser: context.read<CustomRouteInformationParser>(),
            routerDelegate: context.read<CustomRouterDelegate>(),
          ),
        );
      }),
    );
  }
}
