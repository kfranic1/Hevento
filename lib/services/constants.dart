import 'package:flutter/material.dart';

const double kNarrow = 800;
const double wide = 1440;

const double defaultPadding = 15;
const double checkPadding = 300;

Color darkGreen = const Color(0xff114032);
Color lightGreen = const Color(0xffd1daa1);

const Widget loader = Center(child: CircularProgressIndicator());

const TextStyle titleStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 40);
const TextStyle subTitleStyle = TextStyle(fontSize: 20, color: Colors.grey, fontWeight: FontWeight.bold);
const TextStyle buttonTxtStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 15);
const TextStyle todayDateStyle = TextStyle(color: Colors.white, fontSize: 16.0);
const TextStyle selectedDateStyle = TextStyle(color: Colors.black, fontSize: 16.0);
const TextStyle filterTxtStyle = TextStyle(fontWeight: FontWeight.bold, color: Colors.black);
TextStyle dayStyle = TextStyle(fontWeight: FontWeight.bold, color: darkGreen, fontSize: 16);
