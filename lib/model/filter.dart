import 'package:flutter/material.dart';

class Filter with ChangeNotifier {
  DateTime? _selectedDay;
  double _price = 5000;
  double _numberOfPeople = 0;

  DateTime? get selectedDay => _selectedDay;
  double get price => _price;
  double get numberOfPeople => _numberOfPeople;

  set selectedDay(DateTime? value) {
    _selectedDay = value;
    notifyListeners();
  }

  set price(double value) {
    _price = value;
    notifyListeners();
  }

  set numberOfPeople(double value) {
    _numberOfPeople = value;
    notifyListeners();
  }

  void setAll({required DateTime? selectedDay, required double maxPrice, required double numberOfPeople}) {
    _selectedDay = selectedDay;
    _price = maxPrice;
    _numberOfPeople = numberOfPeople;
    notifyListeners();
  }

  @override
  String toString() {
    return "$price, $numberOfPeople)";
    return super.toString();
  }
}
