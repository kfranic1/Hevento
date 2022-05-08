import 'package:flutter/material.dart';
import 'package:hevento/model/person.dart';
import 'package:hevento/model/space.dart';
import 'package:hevento/widgets/space_register/gallery_form.dart';
import 'package:hevento/widgets/space_register/space_register_one.dart';
import 'package:hevento/widgets/space_register/space_register_three.dart';
import 'package:hevento/widgets/space_register/space_register_two.dart';
import 'package:provider/provider.dart';

class SpaceForm extends StatefulWidget {
  final Space? space;
  const SpaceForm({Key? key, this.space}) : super(key: key);

  @override
  State<SpaceForm> createState() => _SpaceFormState();
}

class _SpaceFormState extends State<SpaceForm> {
  late final Space space;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int step = 0;

  late List<Widget> steps;

  @override
  void initState() {
    space = widget.space ?? Space("");
    if (space.id == "") space.tags = null;
    steps = [
      SpaceRegisterOne(space: space),
      SpaceRegisterTwo(space: space),
      SpaceRegisterThree(space: space),
      GalleryForm(space: space, formKey: _formKey),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Person? appUser = context.watch<Person?>();
    if (appUser == null) {
      return const Center(child: Text("Prijavi se kako bi vidio nadzornu ploču."));
    }
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: SizedBox(
        width: 500,
        child: Column(
          children: [
            Text("Create space${step + 1}/${steps.length}"),
            Expanded(
              child: IndexedStack(
                index: step,
                children: steps,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    if (step > 0) setState(() => step--);
                  },
                  icon: const Icon(Icons.arrow_circle_left_outlined),
                ),
                IconButton(
                  onPressed: () {
                    if (step < steps.length - 1) setState(() => step++);
                  },
                  icon: const Icon(Icons.arrow_circle_right_outlined),
                ),
              ],
            ),
            //const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
