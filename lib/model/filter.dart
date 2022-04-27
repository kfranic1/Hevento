import 'package:flutter/material.dart';

class Filter with ChangeNotifier {
  DateTime? _selectedDay;
  double _maxPrice = 5000;
  double _numberOfPeople = 300;

  DateTime? get selectedDay => _selectedDay;
  double get maxPrice => _maxPrice;
  double get numberOfPeople => _numberOfPeople;

  set selectedDay(DateTime? value) {
    _selectedDay = value;
    notifyListeners();
  }

  set maxPrice(double value) {
    _maxPrice = value;
    notifyListeners();
  }

  set numberOfPeople(double value) {
    _numberOfPeople = value;
    notifyListeners();
  }

  void setAll({required DateTime? selectedDay, required double maxPrice, required double numberOfPeople}) {
    _selectedDay = selectedDay;
    _maxPrice = maxPrice;
    _numberOfPeople = numberOfPeople;
    notifyListeners();
  }
}
