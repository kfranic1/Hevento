import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hevento/model/person.dart';
import 'package:hevento/model/space.dart';
import 'dart:html';
import 'package:google_maps/google_maps.dart' hide Icon, Padding;
import 'package:hevento/services/constants.dart';
import 'dart:ui' as ui;

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PartnerPage extends StatefulWidget {
  final String? params;

  const PartnerPage({Key? key, this.params}) : super(key: key);

  @override
  State<PartnerPage> createState() => _PartnerPageState();
}

class _PartnerPageState extends State<PartnerPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
          onPressed: () async => await showDialog(
                context: context,
                builder: (context) => const AlertDialog(content: SpaceForm()),
              ),
          child: const Text("Stvori oglas")),
    );
  }
}

class SpaceForm extends StatefulWidget {
  const SpaceForm({Key? key}) : super(key: key);

  @override
  State<SpaceForm> createState() => _SpaceFormState();
}

class _SpaceFormState extends State<SpaceForm> {
  final Space space = Space("");
  int step = 0;

  late List<Widget> steps;

  @override
  void initState() {
    steps = [
      stepOne(space),
      stepTwo(space),
      stepThree(space),
      stepFour(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    steps[1] = stepTwo(space);
    return SizedBox(
      width: 500,
      child: Column(
        children: [
          Text("Create space${step + 1}/${steps.length}"),
          Expanded(
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: steps[step],
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
    );
  }

  Widget stepOne(Space space) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: TextEditingController(),
            decoration: const InputDecoration(hintText: "name"),
            onChanged: (value) => space.name = value,
          ),
          TextFormField(
            controller: TextEditingController(),
            decoration: const InputDecoration(hintText: "description"),
            maxLines: 10,
            onChanged: (value) => space.description = value,
          ),
          TextFormField(
            controller: TextEditingController(),
            decoration: const InputDecoration(hintText: "adresa"),
            onChanged: (value) => space.address = value,
          ),
          TextFormField(
            controller: TextEditingController(),
            decoration: const InputDecoration(hintText: "phone(optional)"),
            onChanged: (value) => space.contacts["phone"] = value,
          ),
          TextFormField(
            controller: TextEditingController(),
            decoration: const InputDecoration(hintText: "email(optional)"),
            onChanged: (value) => space.contacts["email"] = value,
          ),
          TextFormField(
            controller: TextEditingController(),
            decoration: const InputDecoration(hintText: "facebook(optional)"),
            onChanged: (value) => space.contacts["facebook"] = value,
          ),
          TextFormField(
            controller: TextEditingController(),
            decoration: const InputDecoration(hintText: "instagram(optional)"),
            onChanged: (value) => space.contacts["instagram"] = value,
          ),
          TextFormField(
            controller: TextEditingController(),
            decoration: const InputDecoration(hintText: "website(optional)"),
            onChanged: (value) => space.contacts["website"] = value,
          ),
        ],
      ),
    );
  }

  Widget stepTwo(Space space) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(children: [
            const Text("We offer drinks: "),
            Checkbox(value: space.elements["drinks"], onChanged: (value) => setState(() => space.elements["drinks"] = value!)),
          ]),
          Row(children: [
            const Text("We offer food: "),
            Checkbox(value: space.elements["food"], onChanged: (value) => setState(() => space.elements["food"] = value!)),
          ]),
          Row(children: [
            const Text("We offer waiter: "),
            Checkbox(value: space.elements["waiter"], onChanged: (value) => setState(() => space.elements["waiter"] = value!)),
          ]),
          Row(children: [
            const Text("We offer security: "),
            Checkbox(value: space.elements["security"], onChanged: (value) => setState(() => space.elements["security"] = value!)),
          ]),
          Row(children: [
            const Text("We offer music: "),
            Checkbox(value: space.elements["music"], onChanged: (value) => setState(() => space.elements["music"] = value!)),
          ]),
          Row(children: [
            const Text("We offer smoking: "),
            Checkbox(value: space.elements["smoking"], onChanged: (value) => setState(() => space.elements["smoking"] = value!)),
          ]),
          Row(children: [
            const Text("We offer special effects: "),
            Checkbox(value: space.elements["specialEffects"], onChanged: (value) => setState(() => space.elements["specialEffects"] = value!)),
          ]),
        ],
      ),
    );
  }

  Widget stepThree(Space space) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: TextEditingController(),
            decoration: const InputDecoration(hintText: "Monday price"),
            onChanged: (value) => space.price["Monday"] = int.parse(value),
          ),
          TextFormField(
            controller: TextEditingController(),
            decoration: const InputDecoration(hintText: "Tuesday price"),
            onChanged: (value) => space.price["Tuesday"] = int.parse(value),
          ),
          TextFormField(
            controller: TextEditingController(),
            decoration: const InputDecoration(hintText: "Wednesday price"),
            onChanged: (value) => space.price["Wednesday"] = int.parse(value),
          ),
          TextFormField(
            controller: TextEditingController(),
            decoration: const InputDecoration(hintText: "Thursday price"),
            onChanged: (value) => space.price["Thursday"] = int.parse(value),
          ),
          TextFormField(
            controller: TextEditingController(),
            decoration: const InputDecoration(hintText: "Friday price"),
            onChanged: (value) => space.price["Friday"] = int.parse(value),
          ),
          TextFormField(
            controller: TextEditingController(),
            decoration: const InputDecoration(hintText: "Saturday price"),
            onChanged: (value) => space.price["Saturday"] = int.parse(value),
          ),
          TextFormField(
            controller: TextEditingController(),
            decoration: const InputDecoration(hintText: "Sunday price"),
            onChanged: (value) => space.price["Sunday"] = int.parse(value),
          ),
          TextFormField(
            controller: TextEditingController(),
            decoration: const InputDecoration(hintText: "Number of people"),
            onChanged: (value) => space.numberOfPeople = int.parse(value),
          ),
          TextFormField(
            controller: TextEditingController(),
            decoration: const InputDecoration(
                hintText: "Tags(party, prom, birthday, wedding...) split separate tags with comma and space => party, prom, birthday"),
            onChanged: (value) => space.tags = value.split(', '),
          ),
        ],
      ),
    );
  }

  Widget getMap() {
    String htmlId = "7";

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
      final myLatlng = LatLng(1.3521, 103.8198);

      final mapOptions = MapOptions()
        ..zoom = 10
        ..center = LatLng(45.815399, 15.966568);

      final elem = DivElement()
        ..id = htmlId
        ..style.width = "100%"
        ..style.height = "100%"
        ..style.border = 'none';

      final map = GMap(elem, mapOptions);

      final marker = Marker(
        MarkerOptions()
          ..position = myLatlng
          ..map = map
          ..title = 'Hello World!'
          ..label = 'h'
          ..icon = 'https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png',
      );

      String contentString = '<div id="content">' +
          '<div id="siteNotice">' +
          '</div>' +
          '<h1 id="firstHeading" class="firstHeading">Uluru</h1>' +
          '<div id="bodyContent">' +
          '<p><b>Uluru</b>, also referred to as <b>Ayers Rock</b>, is a large ' +
          'sandstone rock formation in the southern part of the ' +
          'Northern Territory, central Australia. It lies 335&#160;km (208&#160;mi) ' +
          'south west of the nearest large town, Alice Springs; 450&#160;km ' +
          '(280&#160;mi) by road. Kata Tjuta and Uluru are the two major ' +
          'features of the Uluru - Kata Tjuta National Park. Uluru is ' +
          'sacred to the Pitjantjatjara and Yankunytjatjara, the ' +
          'Aboriginal people of the area. It has many springs, waterholes, ' +
          'rock caves and ancient paintings. Uluru is listed as a World ' +
          'Heritage Site.</p>' +
          '<p>Attribution: Uluru, <a href="https://en.wikipedia.org/w/index.php?title=Uluru&oldid=297882194">' +
          'https://en.wikipedia.org/w/index.php?title=Uluru</a> ' +
          '(last visited June 22, 2009).</p>' +
          '</div>' +
          '</div>';

      final infoWindow = InfoWindow(InfoWindowOptions()..content = contentString);
      marker.onClick.listen((event) => infoWindow.open(map, marker));

      return elem;
    });

    return SizedBox(
      child: HtmlElementView(viewType: htmlId),
      height: 200,
      width: 400,
    );
  }

  //TODO nek se moze vise puta dodavat slike i nek se mogu maknut odabrane slike
  Widget stepFour() {
    return GalleryForm(space: space);
  }
}

class GalleryForm extends StatefulWidget {
  const GalleryForm({Key? key, required this.space}) : super(key: key);

  final Space space;

  @override
  State<GalleryForm> createState() => _GalleryFormState();
}

class _GalleryFormState extends State<GalleryForm> {
  List<XFile> files = [];
  List<Widget> gallery = [];
  @override
  Widget build(BuildContext context) {
    gallery = files
        .map((e) => FutureBuilder(
              future: e.readAsBytes(),
              builder: (context, snapshot) => snapshot.connectionState != ConnectionState.done
                  ? loader
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Image.memory(snapshot.data as Uint8List),
                          IconButton(
                            onPressed: () => setState(() => files.remove(e)),
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
            ))
        .toList();
    return Center(
      child: Column(
        children: [
          ElevatedButton(
              child: const Text('Find Images'),
              onPressed: () async {
                List<XFile>? newFiles = await ImagePicker().pickMultiImage(maxHeight: 1080, maxWidth: 1920);
                if (newFiles != null) {
                  setState(() {
                    files.addAll(newFiles);
                  });
                }
              }),
          SizedBox(
            height: 300,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: gallery,
            ),
          ),
          const Expanded(child: SizedBox()),
          ElevatedButton(child: const Text('Finish'), onPressed: () async => await Space.createSpace(context.read<Person>(), widget.space, files)),
        ],
      ),
    );
  }
}
