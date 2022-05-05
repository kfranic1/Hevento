import 'package:flutter/material.dart';
import 'package:hevento/model/space.dart';

class SpaceRegisterThree extends StatelessWidget {
  final Space space;
  const SpaceRegisterThree({Key? key, required this.space}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            initialValue: space.id == "" ? null : space.price["Monday"].toString(),
            controller: space.id == "" ? TextEditingController() : null,
            decoration: const InputDecoration(hintText: "Monday price"),
            onChanged: (value) => space.price["Monday"] = int.tryParse(value),
            validator: (value) {
              if (value == null || value.isEmpty || int.tryParse(value) != null) return null;
              return "Wrong format";
            },
          ),
          TextFormField(
            initialValue: space.id == "" ? null : space.price["Tuesday"].toString(),
            controller: space.id == "" ? TextEditingController() : null,
            decoration: const InputDecoration(hintText: "Tuesday price"),
            onChanged: (value) => space.price["Tuesday"] = int.tryParse(value),
            validator: (value) {
              if (value == null || value.isEmpty || int.tryParse(value) != null) return null;
              return "Wrong format";
            },
          ),
          TextFormField(
            initialValue: space.id == "" ? null : space.price["Wednesday"].toString(),
            controller: space.id == "" ? TextEditingController() : null,
            decoration: const InputDecoration(hintText: "Wednesday price"),
            onChanged: (value) => space.price["Wednesday"] = int.parse(value),
            validator: (value) {
              if (value == null || value.isEmpty || int.tryParse(value) != null) return null;
              return "Wrong format";
            },
          ),
          TextFormField(
            initialValue: space.id == "" ? null : space.price["Thursday"].toString(),
            controller: space.id == "" ? TextEditingController() : null,
            decoration: const InputDecoration(hintText: "Thursday price"),
            onChanged: (value) => space.price["Thursday"] = int.tryParse(value),
            validator: (value) {
              if (value == null || value.isEmpty || int.tryParse(value) != null) return null;
              return "Wrong format";
            },
          ),
          TextFormField(
            initialValue: space.id == "" ? null : space.price["Friday"].toString(),
            controller: space.id == "" ? TextEditingController() : null,
            decoration: const InputDecoration(hintText: "Friday price"),
            onChanged: (value) => space.price["Friday"] = int.tryParse(value),
            validator: (value) {
              if (value == null || value.isEmpty || int.tryParse(value) != null) return null;
              return "Wrong format";
            },
          ),
          TextFormField(
            initialValue: space.id == "" ? null : space.price["Saturday"].toString(),
            controller: space.id == "" ? TextEditingController() : null,
            decoration: const InputDecoration(hintText: "Saturday price"),
            onChanged: (value) => space.price["Saturday"] = int.tryParse(value),
            validator: (value) {
              if (value == null || value.isEmpty || int.tryParse(value) != null) return null;
              return "Wrong format";
            },
          ),
          TextFormField(
            initialValue: space.id == "" ? null : space.price["Sunday"].toString(),
            controller: space.id == "" ? TextEditingController() : null,
            decoration: const InputDecoration(hintText: "Sunday price"),
            onChanged: (value) => space.price["Sunday"] = int.tryParse(value),
            validator: (value) {
              if (value == null || value.isEmpty || int.tryParse(value) != null) return null;
              return "Wrong format";
            },
          ),
          TextFormField(
            initialValue: space.id == "" ? null : space.numberOfPeople.toString(),
            controller: space.id == "" ? TextEditingController() : null,
            decoration: const InputDecoration(hintText: "Number of people"),
            onChanged: (value) => space.numberOfPeople = int.parse(value),
            validator: (value) {
              if (value == null || value.isEmpty) return "Field is empty";
              if (int.tryParse(value) != null) return null;
              return "Wrong format";
            },
          ),
          TextFormField(
            initialValue: space.id == "" ? null : space.tags?.join(", "),
            controller: space.id == "" ? TextEditingController() : null,
            decoration: const InputDecoration(
                hintText: "Tags(party, prom, birthday, wedding...) split separate tags with comma and space => party, prom, birthday"),
            onChanged: (value) => space.tags = value.split(', '),
          ),
        ],
      ),
    );
  }
}
