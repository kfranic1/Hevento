import 'package:flutter/material.dart';

const double kNarrow = 800;
const double wide = 1440;

const double defaultPadding = 15;
const double checkPadding = 300;

const Color darkGreen = Color(0xff114032);
const Color lightGreen = Color(0xffd1daa1);

const Widget loader = Center(child: CircularProgressIndicator(color: darkGreen));

const TextStyle titleStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 40);
const TextStyle subTitleStyle = TextStyle(fontSize: 20, color: Colors.grey, fontWeight: FontWeight.bold);
const TextStyle buttonTxtStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 15);
const TextStyle todayDateStyle = TextStyle(color: Colors.white, fontSize: 16.0);
const TextStyle selectedDateStyle = TextStyle(color: Colors.black, fontSize: 16.0);
const TextStyle filterTxtStyle = TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16);
const TextStyle dayStyle = TextStyle(fontWeight: FontWeight.bold, color: darkGreen, fontSize: 16);
const TextStyle priceDayStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 14);

const Map<int, Color> darGreenColor = {
  50: Color.fromRGBO(17, 64, 50, .1),
  100: Color.fromRGBO(17, 64, 50, .2),
  200: Color.fromRGBO(17, 64, 50, .3),
  300: Color.fromRGBO(17, 64, 50, .4),
  400: Color.fromRGBO(17, 64, 50, .5),
  500: Color.fromRGBO(17, 64, 50, .6),
  600: Color.fromRGBO(17, 64, 50, .7),
  700: Color.fromRGBO(17, 64, 50, .8),
  800: Color.fromRGBO(17, 64, 50, .9),
  900: Color.fromRGBO(17, 64, 50, 1),
};

const MaterialColor darkGreenMaterialColor = MaterialColor(0xFF114032, darGreenColor);

const List<String> months = [
  "Siječanj",
  "Veljača",
  "Ožujak",
  "Travanj",
  "Svibanj",
  "Lipanj",
  "Srpanj",
  "Kolovoz",
  "Rujan",
  "Listopad",
  "Studeni",
  "Prosinac"
];

const List<String> daysShort = ["Pon", "Uto", "Sri", "Čet", "Pet", "Sub", "Ned"];
const List<String> daysLong = ["Ponedjeljak", "Utorak", "Srijeda", "Četvrtak", "Petak", "Subota", "Nedjelja"];
