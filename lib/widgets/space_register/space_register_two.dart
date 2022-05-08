import 'package:flutter/material.dart';
import 'package:hevento/model/space.dart';

class SpaceRegisterTwo extends StatefulWidget {
  final Space space;
  const SpaceRegisterTwo({Key? key, required this.space}) : super(key: key);

  @override
  State<SpaceRegisterTwo> createState() => _SpaceRegisterTwoState();
}

class _SpaceRegisterTwoState extends State<SpaceRegisterTwo> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Usluge unutar prostora."),
          const SizedBox(height: 10),
          Row(children: [
            const Text("Piće"),
            Checkbox(value: widget.space.elements["drinks"], onChanged: (value) => setState(() => widget.space.elements["drinks"] = value!)),
          ]),
          Row(children: [
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
          ]),
        ],
      ),
    );
  }
}
