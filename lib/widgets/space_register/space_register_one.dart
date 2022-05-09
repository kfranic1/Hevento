import 'package:flutter/material.dart';
import 'package:hevento/model/space.dart';

import '../../services/constants.dart';

class SpaceRegisterOne extends StatelessWidget {
  final Space space;
  const SpaceRegisterOne({Key? key, required this.space}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Osnovni podatci",
            style: titleStyle.copyWith(fontSize: 25),
          ),
          const SizedBox(height: 15),
          TextFormField(
            initialValue: space.id == "" ? null : space.name,
            controller: space.id == "" ? TextEditingController() : null,
            decoration: inputFormDec("name"),
            onChanged: (value) => space.name = value,
            validator: (value) => value == null || value.isEmpty ? "Polje ne smije biti prazno" : null,
          ),
          const SizedBox(height: 15),
          TextFormField(
            initialValue: space.id == "" ? null : space.description,
            controller: space.id == "" ? TextEditingController() : null,
            decoration: inputFormDec("desc"),
            maxLines: 10,
            onChanged: (value) => space.description = value,
            validator: (value) => value == null || value.isEmpty ? "Polje ne smije biti prazno" : null,
          ),
          const SizedBox(height: 15),
          TextFormField(
            initialValue: space.id == "" ? null : space.address,
            controller: space.id == "" ? TextEditingController() : null,
            decoration: inputFormDec("address"),
            onChanged: (value) => space.address = value,
            validator: (value) => value == null || value.isEmpty ? "Polje ne smije biti prazno" : null,
          ),
        ],
      ),
    );
  }

  InputDecoration inputFormDec(String data) {
    String txt = "";
    switch (data) {
      case "name":
        txt = "Ime prostora";
        break;
      case "desc":
        txt = "Opis";
        break;
      case "address":
        txt = "Adresa";
        break;
      case "phone":
        txt = "Broj mobitela (neobavezno)";
        break;
      case "email":
        txt = "Email adresa (neobavezno)";
        break;
      case "facebook":
        txt = "Facebook (neobavezno)";
        break;
      case "instagram":
        txt = "Instagram (neobavezno)";
        break;
      case "website":
        txt = "Link web stranice (neobavezno)";
        break;
      default:
    }
    return InputDecoration(
        hintText: txt,
        hintStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 12),
        enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: darkGreen, width: 2.0)),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: darkGreen, width: 2.0)),
        errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 2.0)));
  }
}
