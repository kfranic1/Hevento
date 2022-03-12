import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hevento/generated/firebase_options.dart';
import 'package:hevento/routing/custom_route_information_parser.dart';
import 'package:hevento/routing/custom_router_delegate.dart';
import 'package:hevento/services/auth_service.dart';
import 'package:hevento/model/space.dart';
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
        StreamProvider(
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
        Space? space = Provider.of<Space?>(context);
        return Provider.value(
          value: AppBar(
            title: space == null
                ? const Text("Not logged in")
                : StreamBuilder(
                    stream: space.self,
                    builder: (context, snapshot) {
                      return !snapshot.hasData
                          ? const Center(
                              child: LinearProgressIndicator(),
                            )
                          : Text((snapshot.data as Space).name);
                    }),
            actions: [
              ElevatedButton(
                onPressed: () => context.read<CustomRouterDelegate>().goToHome(),
                child: const Text("Home"),
              ),
              ElevatedButton(
                onPressed: () => context.read<CustomRouterDelegate>().goToPartner(),
                child: const Text("Postani partner"),
              ),
              ElevatedButton(
                onPressed: () => context.read<CustomRouterDelegate>().goToTest(),
                child: const Text("Sing In"),
              ),
              ElevatedButton(
                onPressed: () async => await Provider.of<AuthService>(context, listen: false).signOut(),
                child: const Text("Sign out"),
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
