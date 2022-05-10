import 'package:checkbox_formfield/checkbox_icon_formfield.dart';
import 'package:flutter/material.dart';
import 'package:hevento/model/space.dart';
import 'package:hevento/services/constants.dart';

class SpaceRegisterThree extends StatefulWidget {
  final Space space;
  const SpaceRegisterThree({Key? key, required this.space}) : super(key: key);

  @override
  State<SpaceRegisterThree> createState() => _SpaceRegisterTwoState();
}

class _SpaceRegisterTwoState extends State<SpaceRegisterThree> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Usluge unutar prostora",
            style: titleStyle.copyWith(fontSize: 25),
          ),
          Text('', style: subTitleStyle.copyWith(fontSize: 12)),
          const SizedBox(height: 15),
          customCheckBox("Piće", "drinks"),
          customCheckBox("Hrana", "food"),
          customCheckBox("Konobar", "waiter"),
          customCheckBox("Zaštitar", "security"),
          customCheckBox("DJ/Bend", "music"),
          customCheckBox("Pušenje unutar prostora", "smoking"),
          customCheckBox("Specijalni efekti", "specialEffects"),
        ],
      ),
    );
  }

  Widget customCheckBox(String text, String mapElement) {
    return Row(
      children: [
        SizedBox(
          child: Text(text),
          width: 200,
        ),
        const SizedBox(width: 80),
        CheckboxIconFormField(
          initialValue: widget.space.elements[mapElement]!,
          onChanged: (value) => setState(
            () => widget.space.elements[mapElement] = value,
          ),
          trueIconColor: darkGreen,
          padding: 0,
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}
