import 'package:flutter/material.dart';
import 'package:hevento/model/space.dart';
import 'package:hevento/services/constants.dart';

class SpaceRegisterFour extends StatelessWidget {
  final Space space;
  const SpaceRegisterFour({Key? key, required this.space}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Cijene prostora",
            style: titleStyle.copyWith(fontSize: 25),
          ),
          Text('', style: subTitleStyle.copyWith(fontSize: 12)),
          const SizedBox(height: 15),
          textFormField(DateTime.monday, "ponedjeljak"),
          const SizedBox(height: 15),
          textFormField(DateTime.tuesday, "utorak"),
          const SizedBox(height: 15),
          textFormField(DateTime.wednesday, "srijedu"),
          const SizedBox(height: 15),
          textFormField(DateTime.thursday, "četvrtak"),
          const SizedBox(height: 15),
          textFormField(DateTime.friday, "petak"),
          const SizedBox(height: 15),
          textFormField(DateTime.saturday, "subotu"),
          const SizedBox(height: 15),
          textFormField(DateTime.sunday, "nedjelju"),
          const SizedBox(height: 20),
          const Text("Dodatni podatci"),
          const SizedBox(height: 15),
          TextFormField(
            initialValue: space.id == "" ? null : space.numberOfPeople.toString(),
            controller: space.id == "" ? TextEditingController() : null,
            decoration: inputDecoration("Number of people"),
            onChanged: (value) => space.numberOfPeople = int.parse(value),
            validator: (value) {
              if (value == null || value.isEmpty) return "Polje ne smije biti prazno";
              if (int.tryParse(value) != null) return null;
              return "Pogrešan format";
            },
          ),
          const SizedBox(height: 15),
          TextFormField(
            initialValue: space.id == "" ? null : space.tags?.join(", "),
            controller: space.id == "" ? TextEditingController() : null,
            decoration: inputDecoration("Tags(#party #prom #birthday #wedding...)"),
            onChanged: (value) => space.tags = value.split(', '),
          ),
        ],
      ),
    );
  }

  TextFormField textFormField(int day, String dayName) {
    return TextFormField(
      initialValue: space.id == "" ? null : space.price[day]?.toString(),
      controller: space.id == "" ? TextEditingController() : null,
      decoration: inputDecoration("Cijena za  $dayName"),
      onChanged: (value) => space.price[day] = int.tryParse(value),
      validator: (value) {
        if (value != null && value.isNotEmpty && int.tryParse(value) == null) return "Pogrešan format";
        if (day == 6 && space.price.values.every((element) => element == null)) return "Potrebno je navesti barem jednu cijenu";
        return null;
      },
    );
  }

  InputDecoration inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 12),
      border: const OutlineInputBorder(borderSide: BorderSide(color: darkGreen, width: 2.0)),
      errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 2.0)),
    );
  }
}
