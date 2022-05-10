import 'package:flutter/material.dart';
import 'package:hevento/model/space.dart';

import '../../services/constants.dart';

class SpaceRegisterTwo extends StatelessWidget {
  final Space space;
  const SpaceRegisterTwo({Key? key, required this.space}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Kontakt",
            style: titleStyle.copyWith(fontSize: 25),
          ),
          Text("Potreban je navesti barem jedan konatakt", style: subTitleStyle.copyWith(fontSize: 12)),
          ...space.contacts.keys.map((e) => Column(children: [const SizedBox(height: 15), textFormField(e)])).toList(),
        ],
      ),
    );
  }

  TextFormField textFormField(String contact) {
    return TextFormField(
      initialValue: space.id == "" ? null : space.contacts[contact],
      controller: space.id == "" ? TextEditingController() : null,
      decoration: InputDecoration(
        hintText: hint(contact),
        hintStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 12),
        border: const OutlineInputBorder(borderSide: BorderSide(color: darkGreen, width: 2.0)),
        errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 2.0)),
      ),
      onChanged: (value) => space.contacts[contact] = value,
      validator: contact != "phone"
          ? null
          : (value) => space.contacts.values.any((element) => element != null && element.isNotEmpty) ? null : "Potreban je barem jedan kontakt",
    );
  }

  String hint(String data) {
    String txt = "";
    switch (data) {
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
    return txt;
  }
}
