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
            initialValue: space.id == "" ? null : space.price[DateTime.monday]?.toString(),
            controller: space.id == "" ? TextEditingController() : null,
            decoration: const InputDecoration(hintText: "Monday price"),
            onChanged: (value) => space.price[DateTime.monday] = int.tryParse(value),
            validator: (value) {
              if (space.price.values.every((element) => element == null)) return "Please define at least one price";
              if (value == null || value.isEmpty || int.tryParse(value) != null) return null;
              return "Wrong format";
            },
          ),
          TextFormField(
            initialValue: space.id == "" ? null : space.price[DateTime.tuesday]?.toString(),
            controller: space.id == "" ? TextEditingController() : null,
            decoration: const InputDecoration(hintText: "Tuesday price"),
            onChanged: (value) => space.price[DateTime.tuesday] = int.tryParse(value),
            validator: (value) {
              if (value == null || value.isEmpty || int.tryParse(value) != null) return null;
              return "Wrong format";
            },
          ),
          TextFormField(
            initialValue: space.id == "" ? null : space.price[DateTime.wednesday]?.toString(),
            controller: space.id == "" ? TextEditingController() : null,
            decoration: const InputDecoration(hintText: "Wednesday price"),
            onChanged: (value) => space.price[DateTime.wednesday] = int.parse(value),
            validator: (value) {
              if (value == null || value.isEmpty || int.tryParse(value) != null) return null;
              return "Wrong format";
            },
          ),
          TextFormField(
            initialValue: space.id == "" ? null : space.price[DateTime.thursday]?.toString(),
            controller: space.id == "" ? TextEditingController() : null,
            decoration: const InputDecoration(hintText: "Thursday price"),
            onChanged: (value) => space.price[DateTime.thursday] = int.tryParse(value),
            validator: (value) {
              if (value == null || value.isEmpty || int.tryParse(value) != null) return null;
              return "Wrong format";
            },
          ),
          TextFormField(
            initialValue: space.id == "" ? null : space.price[DateTime.friday]?.toString(),
            controller: space.id == "" ? TextEditingController() : null,
            decoration: const InputDecoration(hintText: "Friday price"),
            onChanged: (value) => space.price[DateTime.friday] = int.tryParse(value),
            validator: (value) {
              if (value == null || value.isEmpty || int.tryParse(value) != null) return null;
              return "Wrong format";
            },
          ),
          TextFormField(
            initialValue: space.id == "" ? null : space.price[DateTime.saturday]?.toString(),
            controller: space.id == "" ? TextEditingController() : null,
            decoration: const InputDecoration(hintText: "Saturday price"),
            onChanged: (value) => space.price[DateTime.saturday] = int.tryParse(value),
            validator: (value) {
              if (value == null || value.isEmpty || int.tryParse(value) != null) return null;
              return "Wrong format";
            },
          ),
          TextFormField(
            initialValue: space.id == "" ? null : space.price[DateTime.sunday]?.toString(),
            controller: space.id == "" ? TextEditingController() : null,
            decoration: const InputDecoration(hintText: "Sunday price"),
            onChanged: (value) => space.price[DateTime.sunday] = int.tryParse(value),
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
