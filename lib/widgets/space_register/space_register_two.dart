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
            Text("Potreban je barem jedan konatkt", style: subTitleStyle.copyWith(fontSize: 12)),
            const SizedBox(height: 15),
            TextFormField(
              initialValue: space.id == "" ? null : space.contacts["phone"],
              controller: space.id == "" ? TextEditingController() : null,
              decoration: inputFormDec("phone"),
              onChanged: (value) => space.contacts["phone"] = value,
              validator: (value) =>
                  space.contacts.values.any((element) => element != null && element.isNotEmpty) ? null : "Potreban je barem jedan kontakt",
            ),
            const SizedBox(height: 15),
            TextFormField(
              initialValue: space.id == "" ? null : space.contacts["email"],
              controller: space.id == "" ? TextEditingController() : null,
              decoration: inputFormDec("email"),
              onChanged: (value) => space.contacts["email"] = value,
            ),
            const SizedBox(height: 15),
            TextFormField(
              initialValue: space.id == "" ? null : space.contacts["facebook"],
              controller: space.id == "" ? TextEditingController() : null,
              decoration: inputFormDec("facebook"),
              onChanged: (value) => space.contacts["facebook"] = value,
            ),
            const SizedBox(height: 15),
            TextFormField(
              initialValue: space.id == "" ? null : space.contacts["instagram"],
              controller: space.id == "" ? TextEditingController() : null,
              decoration: inputFormDec("instagram"),
              onChanged: (value) => space.contacts["instagram"] = value,
            ),
            const SizedBox(height: 15),
            TextFormField(
              initialValue: space.id == "" ? null : space.contacts["website"],
              controller: space.id == "" ? TextEditingController() : null,
              decoration: inputFormDec("website"),
              onChanged: (value) => space.contacts["website"] = value,
            ),
          ],
        ));
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
