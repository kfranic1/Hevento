import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hevento/services/auth_service.dart';
import 'package:hevento/model/space.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

import 'generated/firebase_options.dart';
import 'routing/custom_route_information_parser.dart';
import 'routing/custom_router_delegate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static final RouteInformationParser<Object> _routeInformationParser = CustomRouteInformationParser();
  static final RouterDelegate<Object> _routerDelegate = CustomRouterDelegate();

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
        Provider<RouteInformationParser<Object>>(
          create: (context) => _routeInformationParser,
        ),
        ListenableProvider<RouterDelegate<Object>>(
          create: (context) => _routerDelegate,
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
                onPressed: () => (Provider.of<RouterDelegate<Object>>(context, listen: false) as CustomRouterDelegate).goToHome(),
                child: const Text("Home"),
              ),
              ElevatedButton(
                onPressed: () => (Provider.of<RouterDelegate<Object>>(context, listen: false) as CustomRouterDelegate).goToPartner(),
                child: const Text("Postani partner"),
              ),
              ElevatedButton(
                onPressed: () => (Provider.of<RouterDelegate<Object>>(context, listen: false) as CustomRouterDelegate).goToTest(),
                child: const Text("Test"),
              ),
              ElevatedButton(
                onPressed: () async => print(await Provider.of<AuthService>(context, listen: false).signOut()),
                child: const Text("logout"),
              ),
            ],
          ),
          child: MaterialApp.router(
            title: 'Hevento',
            theme: ThemeData(
              primarySwatch: Colors.green,
            ),
            debugShowCheckedModeBanner: false,
            routeInformationParser: _routeInformationParser,
            routerDelegate: _routerDelegate,
          ),
        );
      }),
    );
  }
}
