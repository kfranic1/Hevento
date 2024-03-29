import 'package:flutter/material.dart';

class Filter with ChangeNotifier {
  String? _name;
  DateTime? _selectedDay;
  int _price = 5000;
  int _numberOfPeople = 0;
  bool _music = false;
  bool _waiter = false;
  bool _drinks = false;
  bool _food = false;
  bool _security = false;
  bool _specialEffects = false;
  bool _smoking = false;
  double _rating = 0;

  bool notifyOnSet = false;

  String? get name => _name;
  DateTime? get selectedDay => _selectedDay;
  int get price => _price;
  int get numberOfPeople => _numberOfPeople;
  bool get music => _music;
  bool get waiter => _waiter;
  bool get drinks => _drinks;
  bool get food => _food;
  bool get security => _security;
  bool get specialEffects => _specialEffects;
  bool get smoking => _smoking;
  double get rating => _rating;

  void reset() {
    _name = null;
    _selectedDay = null;
    _price = 5000;
    _numberOfPeople = 0;
    _music = false;
    _waiter = false;
    _drinks = false;
    _food = false;
    _security = false;
    _specialEffects = false;
    _smoking = false;
    _rating = 0;
    notifyListeners();
  }

  set name(String? value) {
    _name = value;
    notifyListeners();
  }

  set selectedDay(DateTime? value) {
    _selectedDay = value;
    if (notifyOnSet) notifyListeners();
  }

  set price(int value) {
    _price = value;
    if (notifyOnSet) notifyListeners();
  }

  set numberOfPeople(int value) {
    _numberOfPeople = value;
    if (notifyOnSet) notifyListeners();
  }

  set music(bool music) {
    _music = music;
    if (notifyOnSet) notifyListeners();
  }

  set waiter(bool waiter) {
    _waiter = waiter;
    if (notifyOnSet) notifyListeners();
  }

  set drinks(bool drinks) {
    _drinks = drinks;
    if (notifyOnSet) notifyListeners();
  }

  set food(bool food) {
    _food = food;
    if (notifyOnSet) notifyListeners();
  }

  set security(bool security) {
    _security = security;
    if (notifyOnSet) notifyListeners();
  }

  set specialEffects(bool specialEffects) {
    _specialEffects = specialEffects;
    if (notifyOnSet) notifyListeners();
  }

  set smoking(bool smoking) {
    _smoking = smoking;
    if (notifyOnSet) notifyListeners();
  }

  set rating(double rating) {
    _rating = rating;
    if (notifyOnSet) notifyListeners();
  }

  void apply() {
    notifyListeners();
  }
}
