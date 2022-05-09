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
          const SizedBox(height: 75),
          Row(
            children: [
              const SizedBox(
                child: Text("Piće"),
                width: 200,
              ),
              const SizedBox(width: 80),
              CheckboxIconFormField(
                initialValue: widget.space.elements["drinks"]!,
                onChanged: (value) => setState(
                  () => widget.space.elements["drinks"] = value,
                ),
                trueIconColor: darkGreen,
                padding: 0,
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Row(
            children: [
              const SizedBox(
                child: Text("Hrana"),
                width: 200,
              ),
              const SizedBox(width: 80),
              CheckboxIconFormField(
                initialValue: widget.space.elements["food"]!,
                onChanged: (value) => setState(
                  () => widget.space.elements["food"] = value,
                ),
                trueIconColor: darkGreen,
                padding: 0,
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Row(
            children: [
              const SizedBox(
                child: Text("Konobar"),
                width: 200,
              ),
              const SizedBox(width: 80),
              CheckboxIconFormField(
                initialValue: widget.space.elements["waiter"]!,
                onChanged: (value) => setState(
                  () => widget.space.elements["waiter"] = value,
                ),
                trueIconColor: darkGreen,
                padding: 0,
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Row(
            children: [
              const SizedBox(
                child: Text("Zaštitar"),
                width: 200,
              ),
              const SizedBox(width: 80),
              CheckboxIconFormField(
                initialValue: widget.space.elements["security"]!,
                onChanged: (value) => setState(
                  () => widget.space.elements["security"] = value,
                ),
                trueIconColor: darkGreen,
                padding: 0,
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Row(
            children: [
              const SizedBox(
                child: Text("DJ/Bend"),
                width: 200,
              ),
              const SizedBox(width: 80),
              CheckboxIconFormField(
                initialValue: widget.space.elements["music"]!,
                onChanged: (value) => setState(
                  () => widget.space.elements["music"] = value,
                ),
                trueIconColor: darkGreen,
                padding: 0,
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Row(
            children: [
              const SizedBox(
                child: Text("Pušenje unutar prostora"),
                width: 200,
              ),
              const SizedBox(width: 80),
              CheckboxIconFormField(
                initialValue: widget.space.elements["smoking"]!,
                onChanged: (value) => setState(
                  () => widget.space.elements["smoking"] = value,
                ),
                trueIconColor: darkGreen,
                padding: 0,
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Row(
            children: [
              const SizedBox(
                child: Text("Specijalni efekti"),
                width: 200,
              ),
              const SizedBox(width: 80),
              CheckboxIconFormField(
                initialValue: widget.space.elements["specialEffects"]!,
                onChanged: (value) => setState(
                  () => widget.space.elements["specialEffects"] = value,
                ),
                trueIconColor: darkGreen,
                padding: 0,
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),

          /*Row(children: [
            const Text("Hrana"),
            Checkbox(value: widget.space.elements["food"], onChanged: (value) => setState(() => widget.space.elements["food"] = value!)),
          ]),
          Row(children: [
            const Text("Konobar"),
            Checkbox(value: widget.space.elements["waiter"], onChanged: (value) => setState(() => widget.space.elements["waiter"] = value!)),
          ]),
          Row(children: [
            const Text("Zaštitar"),
            Checkbox(value: widget.space.elements["security"], onChanged: (value) => setState(() => widget.space.elements["security"] = value!)),
          ]),
          Row(children: [
            const Text("DJ/Bend"),
            Checkbox(value: widget.space.elements["music"], onChanged: (value) => setState(() => widget.space.elements["music"] = value!)),
          ]),
          Row(children: [
            const Text("Pušenje unutar prostora"),
            Checkbox(value: widget.space.elements["smoking"], onChanged: (value) => setState(() => widget.space.elements["smoking"] = value!)),
          ]),
          Row(children: [
            const Text("Specijalni efekti"),
            Checkbox(
                value: widget.space.elements["specialEffects"],
                onChanged: (value) => setState(() => widget.space.elements["specialEffects"] = value!)),
          ]),*/
        ],
      ),
    );
  }
}
