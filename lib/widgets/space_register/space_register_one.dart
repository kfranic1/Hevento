import 'package:flutter/material.dart';
import 'package:hevento/model/space.dart';

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
          const Text("Osnovni podatci"),
          TextFormField(
            initialValue: space.id == "" ? null : space.name,
            controller: space.id == "" ? TextEditingController() : null,
            decoration: const InputDecoration(hintText: "name"),
            onChanged: (value) => space.name = value,
            validator: (value) => value == null || value.isEmpty ? "Polje ne smije biti prazno" : null,
          ),
          TextFormField(
            initialValue: space.id == "" ? null : space.description,
            controller: space.id == "" ? TextEditingController() : null,
            decoration: const InputDecoration(hintText: "description"),
            maxLines: 10,
            onChanged: (value) => space.description = value,
            validator: (value) => value == null || value.isEmpty ? "Polje ne smije biti prazno" : null,
          ),
          TextFormField(
            initialValue: space.id == "" ? null : space.address,
            controller: space.id == "" ? TextEditingController() : null,
            decoration: const InputDecoration(hintText: "adresa"),
            onChanged: (value) => space.address = value,
            validator: (value) => value == null || value.isEmpty ? "Polje ne smije biti prazno" : null,
          ),
          TextFormField(
            initialValue: space.id == "" ? null : space.contacts["phone"],
            controller: space.id == "" ? TextEditingController() : null,
            decoration: const InputDecoration(hintText: "phone(optional)"),
            onChanged: (value) => space.contacts["phone"] = value,
            validator: (value) =>
                space.contacts.values.any((element) => element != null && element.isNotEmpty) ? null : "Potreban je barem jedan kontakt",
          ),
          TextFormField(
            initialValue: space.id == "" ? null : space.contacts["email"],
            controller: space.id == "" ? TextEditingController() : null,
            decoration: const InputDecoration(hintText: "email(optional)"),
            onChanged: (value) => space.contacts["email"] = value,
          ),
          TextFormField(
            initialValue: space.id == "" ? null : space.contacts["facebook"],
            controller: space.id == "" ? TextEditingController() : null,
            decoration: const InputDecoration(hintText: "facebook(optional)"),
            onChanged: (value) => space.contacts["facebook"] = value,
          ),
          TextFormField(
            initialValue: space.id == "" ? null : space.contacts["instagram"],
            controller: space.id == "" ? TextEditingController() : null,
            decoration: const InputDecoration(hintText: "instagram(optional)"),
            onChanged: (value) => space.contacts["instagram"] = value,
          ),
          TextFormField(
            initialValue: space.id == "" ? null : space.contacts["website"],
            controller: space.id == "" ? TextEditingController() : null,
            decoration: const InputDecoration(hintText: "website(optional)"),
            onChanged: (value) => space.contacts["website"] = value,
          ),
        ],
      ),
    );
  }
}
