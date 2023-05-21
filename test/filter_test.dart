import 'package:flutter_test/flutter_test.dart';
import 'package:hevento/model/filter.dart';

///
///Business layer test
///
void main() {
  late Filter filter;

  setUp(() {
    filter = Filter();
  });

  group('Filter Test', () {
    test('Initial state', () {
      expect(filter.name, isNull);
      expect(filter.selectedDay, isNull);
      expect(filter.price, 5000);
      expect(filter.numberOfPeople, 0);
      expect(filter.music, isFalse);
      expect(filter.waiter, isFalse);
      expect(filter.drinks, isFalse);
      expect(filter.food, isFalse);
      expect(filter.security, isFalse);
      expect(filter.specialEffects, isFalse);
      expect(filter.smoking, isFalse);
      expect(filter.rating, 0);
    });

    test('reset', () {
      filter.name = "Test";
      filter.selectedDay = DateTime.now();
      filter.price = 6000;
      filter.numberOfPeople = 5;
      filter.music = true;
      filter.waiter = true;
      filter.drinks = true;
      filter.food = true;
      filter.security = true;
      filter.specialEffects = true;
      filter.smoking = true;
      filter.rating = 4.5;

      filter.reset();

      expect(filter.name, isNull);
      expect(filter.selectedDay, isNull);
      expect(filter.price, 5000);
      expect(filter.numberOfPeople, 0);
      expect(filter.music, isFalse);
      expect(filter.waiter, isFalse);
      expect(filter.drinks, isFalse);
      expect(filter.food, isFalse);
      expect(filter.security, isFalse);
      expect(filter.specialEffects, isFalse);
      expect(filter.smoking, isFalse);
      expect(filter.rating, 0);
    });

    test('setters', () {
      var now = DateTime.now();

      filter.name = "Test";
      filter.selectedDay = now;
      filter.price = 6000;
      filter.numberOfPeople = 5;
      filter.music = true;
      filter.waiter = true;
      filter.drinks = true;
      filter.food = true;
      filter.security = true;
      filter.specialEffects = true;
      filter.smoking = true;
      filter.rating = 4.5;

      expect(filter.name, "Test");
      expect(filter.selectedDay, now);
      expect(filter.price, 6000);
      expect(filter.numberOfPeople, 5);
      expect(filter.music, isTrue);
      expect(filter.waiter, isTrue);
      expect(filter.drinks, isTrue);
      expect(filter.food, isTrue);
      expect(filter.security, isTrue);
      expect(filter.specialEffects, isTrue);
      expect(filter.smoking, isTrue);
      expect(filter.rating, 4.5);
    });
  });
}
