import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

import 'custom_route_information_parser.dart';
import 'custom_router_delegate.dart';
import 'firebase_options.dart';

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
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<RouteInformationParser<Object>>(create: (_) => _routeInformationParser),
        ListenableProvider<RouterDelegate<Object>>(create: (_) => _routerDelegate),
        Provider<FirebaseFirestore>(create: (_) => _firestore),
        Provider<FirebaseAuth>(create: (_) => _auth),
      ],
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
  }
}
