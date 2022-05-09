import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hevento/generated/firebase_options.dart';
import 'package:hevento/model/filter.dart';
import 'package:hevento/model/person.dart';
import 'package:hevento/model/space.dart';
import 'package:hevento/routing/custom_route_information_parser.dart';
import 'package:hevento/routing/custom_router_delegate.dart';
import 'package:hevento/services/auth_service.dart';
import 'package:hevento/services/constants.dart';
import 'package:hevento/widgets/custom_divider.dart';
import 'package:hevento/widgets/custom_scroll_behavior.dart';
import 'package:hevento/widgets/space_list_item.dart';
import 'package:hevento/widgets/title_image.dart';
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
        StreamProvider<Person?>(
          create: (context) => context.read<AuthService>().authStateChanges,
          initialData: null,
        ),
        Provider<CustomRouteInformationParser>(
          create: (context) => CustomRouteInformationParser(),
        ),
        ListenableProvider<CustomRouterDelegate>(
          create: (context) => CustomRouterDelegate(),
        ),
        ListenableProvider<Filter>(
          create: (context) => Filter(),
        ),
      ],
      child: FutureBuilder(
          future: Space.getSpaces(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return loader;
            }
            List<Space> spaces = snapshot.data as List<Space>;
            return MultiProvider(
              providers: [
                Provider<List<Space>>(create: (context) => spaces),
                Provider<List<SpaceListItem>>(create: (context) => spaces.map((e) => SpaceListItem(space: e)).toList()),
                Provider<AppBar>(
                  create: (context) => AppBar(
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    centerTitle: false,
                    leadingWidth: 0,
                    title: const TitleImage(),
                    toolbarHeight: 80,
                    backgroundColor: lightGreen,
                    bottom: const PreferredSize(
                      preferredSize: Size(double.infinity, 2),
                      child: CustomDivider(
                        divider: Divider(
                          thickness: 2,
                          color: darkGreen,
                          indent: 0,
                          endIndent: 0,
                          height: 2,
                        ),
                        right: lightGreen,
                      ),
                    ),
                  ),
                ),
              ],
              child: MaterialApp.router(
                scrollBehavior: CustomScrollBehavior(),
                title: 'Hevento',
                debugShowCheckedModeBanner: false,
                routeInformationParser: context.read<CustomRouteInformationParser>(),
                routerDelegate: context.read<CustomRouterDelegate>(),
                theme: ThemeData(
                  fontFamily: 'Roboto',
                  primarySwatch: darkGreenMaterialColor,
                ),
              ),
            );
          }),
    );
  }
}
