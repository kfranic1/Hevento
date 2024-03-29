import 'package:flutter/material.dart';
import 'package:hevento/model/person.dart';
import 'package:hevento/model/space.dart';
import 'package:hevento/services/constants.dart';
import 'package:hevento/services/static_functions.dart';
import 'package:hevento/widgets/custom_network_image.dart';
import 'package:hevento/widgets/space_list_item.dart';
import 'package:hevento/widgets/space_register/gallery_form.dart';
import 'package:hevento/widgets/space_register/space_register_three.dart';
import 'package:hevento/widgets/space_register/space_register_two.dart';
import 'package:hevento/widgets/space_register/space_register_one.dart';
import 'package:hevento/widgets/space_register/space_register_four.dart';
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
  String? error;

  bool changed = false;

  late List<Widget> steps;

  @override
  void initState() {
    space = widget.space ?? Space("");
    if (space.id == "") space.tags = null;
    steps = [
      SpaceRegisterOne(space: space),
      SpaceRegisterTwo(space: space),
      SpaceRegisterThree(space: space),
      SpaceRegisterFour(space: space),
      FutureBuilder(
          future: Functions.loadImagesUrls(space.id, returnName: true),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) return loader;
            return GalleryForm(
              space: space,
              formKey: _formKey,
              images: (snapshot.data as List<String>).map((e) => CustomNetworkImage(spaceId: space.id, imageName: e)).toList(),
            );
          }),
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
      onChanged: () => {
        if (space.id != "")
          setState(() {
            changed = true;
          })
      },
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: SizedBox(
        width: 500,
        child: Column(
          children: [
            Expanded(
              child: IndexedStack(
                index: step,
                children: steps
                    .map(
                      (e) => ExcludeFocus(
                        child: e,
                        excluding: steps[step] != e,
                      ),
                    )
                    .toList(),
              ),
            ),
            if ((space.id != "" || step == 3))
              ElevatedButton(
                child: Text(space.id == ""
                    ? "Stvori oglas"
                    : changed
                        ? "Spremi promjene"
                        : "Zatvori"),
                onPressed: () async {
                  try {
                    if (!_formKey.currentState!.validate()) {
                      setState(() => error = "Nedostaju neki podatci ili su krivo formatirani.");
                    } else {
                      if (space.id == "") {
                        await space.createSpace(context.read<Person?>()!);
                        context.read<List<Space>>().add(space);
                        context.read<List<SpaceListItem>>().add(SpaceListItem(space: space));
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Prostor uspješno stvoren.")));
                        setState(() {
                          step++;
                        });
                      } else {
                        await space.updateSpace();
                        if (changed) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Promjene uspješno spremljene.")));
                        Navigator.of(context).pop(changed);
                      }
                    }
                  } catch (e) {
                    //print(e.toString());
                  }
                },
              ),
            if (step == steps.length - 1)
              const Text(
                "Napomena: dodavanje i brisanje slika je automatsko",
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    if (step > 0) setState(() => step--);
                  },
                  icon: const Icon(
                    Icons.arrow_circle_left_outlined,
                    color: darkGreen,
                  ),
                ),
                Text(
                  "Korak ${step + 1}/${steps.length}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  color: darkGreen,
                  disabledColor: Colors.grey,
                  onPressed: (space.id == "" && step == 3)
                      ? null
                      : () {
                          if (step < steps.length - 1) setState(() => step++);
                        },
                  icon: const Icon(Icons.arrow_circle_right_outlined),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
