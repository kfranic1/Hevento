import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:hevento/routing/custom_router_delegate.dart';
import 'package:hevento/widgets/title_image.dart';
import 'package:provider/provider.dart';
///
///Presentation layer test
///

class FakeRouterDelegate extends Fake implements CustomRouterDelegate {
  bool goToHomeCalled = false;
  @override
  void goToHome() {
    goToHomeCalled = true;
  }

  @override
  void addListener(VoidCallback listener) {
    return;
  }

  @override
  void removeListener(VoidCallback listener) {
    return;
  }

  @override
  void notifyListeners() {
    return;
  }

  @override
  void goToDashboard({Map<String, String>? params}) {}

  @override
  void goToLogin({Map<String, String>? params}) {}

  @override
  void goToSpace({Map<String, String>? params = const {"id": "0"}}) {}

  @override
  void goToRegister({Map<String, String>? params}) {}
}

void main() {
  group('TitleImage', () {
    final fakeRouterDelegate = FakeRouterDelegate();

    testWidgets('Calls goToHome when tapped', (WidgetTester tester) async {
      await tester.pumpWidget(
        ListenableProvider<CustomRouterDelegate>(
          create: (_) => fakeRouterDelegate,
          child: Builder(builder: (context) {
            return const MaterialApp(home: TitleImage());
          }),
        ),
      );

      await tester.tap(find.byType(InkWell));
      await tester.pumpAndSettle();

      expect(fakeRouterDelegate.goToHomeCalled, true);
    });
  });
}
