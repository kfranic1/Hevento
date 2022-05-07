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
          Row(children: [
            const Text("We offer drinks: "),
            Checkbox(value: widget.space.elements["drinks"], onChanged: (value) => setState(() => widget.space.elements["drinks"] = value!)),
          ]),
          Row(children: [
            const Text("We offer food: "),
            Checkbox(value: widget.space.elements["food"], onChanged: (value) => setState(() => widget.space.elements["food"] = value!)),
          ]),
          Row(children: [
            const Text("We offer waiter: "),
            Checkbox(value: widget.space.elements["waiter"], onChanged: (value) => setState(() => widget.space.elements["waiter"] = value!)),
          ]),
          Row(children: [
            const Text("We offer security: "),
            Checkbox(value: widget.space.elements["security"], onChanged: (value) => setState(() => widget.space.elements["security"] = value!)),
          ]),
          Row(children: [
            const Text("We offer music: "),
            Checkbox(value: widget.space.elements["music"], onChanged: (value) => setState(() => widget.space.elements["music"] = value!)),
          ]),
          Row(children: [
            const Text("We offer smoking: "),
            Checkbox(value: widget.space.elements["smoking"], onChanged: (value) => setState(() => widget.space.elements["smoking"] = value!)),
          ]),
          Row(children: [
            const Text("We offer special effects: "),
            Checkbox(value: widget.space.elements["specialEffects"], onChanged: (value) => setState(() => widget.space.elements["specialEffects"] = value!)),
          ]),
        ],
      ),
    );
  }
}
