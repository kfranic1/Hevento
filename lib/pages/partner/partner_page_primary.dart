import 'package:flutter/material.dart';
import 'package:hevento/model/person.dart';
import 'package:hevento/model/review.dart';
import 'package:hevento/model/space.dart';
import 'package:hevento/pages/space/review_dialog.dart';
import 'package:hevento/routing/custom_router_delegate.dart';
import 'package:hevento/services/constants.dart';
import 'package:hevento/services/static_functions.dart';
import 'package:hevento/widgets/space_register/space_form.dart';
import 'package:provider/provider.dart';

class PartnerPagePrimary extends StatefulWidget {
  const PartnerPagePrimary({Key? key}) : super(key: key);

  @override
  State<PartnerPagePrimary> createState() => _PartnerPagePrimaryState();
}

class _PartnerPagePrimaryState extends State<PartnerPagePrimary> {
  @override
  Widget build(BuildContext context) {
    Person? appUser = context.watch<Person?>();
    if (appUser == null) {
      WidgetsBinding.instance?.addPostFrameCallback((_) => context.read<CustomRouterDelegate>().goToLogin());
      return loader;
    }
    List<Space> mySpaces = context.read<List<Space>>().where((element) => element.owner.id == appUser.id).toList();
    //? Ako zelimo da se sortira po tome jesu skriveni il ne => mySpaces.sort((a, b) => a.hidden ? 1 : 0);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              itemCount: mySpaces.length,
              itemBuilder: (BuildContext context, int index) {
                Space space = mySpaces[index];
                return ExpansionTile(
                  collapsedBackgroundColor: lightGreen,
                  title: Text(space.name),
                  subtitle: Text(space.address),
                  trailing: SizedBox(
                    height: 80,
                    width: 600,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () async {
                            space.hidden = !space.hidden;
                            await space.updateSpace();
                            setState(() {});
                          },
                          icon: Icon(space.hidden ? Icons.visibility_off : Icons.visibility),
                          tooltip: "Sakrij oglas",
                        ),
                        TextButton(
                          child: const Text("Uredi"),
                          onPressed: () async => await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(content: SpaceForm(space: space)),
                          ).then((value) {
                            if (value == null || (!(value as bool))) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(content: Text("Promjene su zabilježene, ali nisu spremljene.")));
                            }
                          }),
                        ),
                      ],
                    ),
                  ),
                  maintainState: true,
                  expandedAlignment: Alignment.centerLeft,
                  childrenPadding: const EdgeInsets.only(left: 15),
                  children: [
                    SizedBox(
                      height: 250,
                      child: FutureBuilder(
                          future: Functions.getReviews(space.id),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState != ConnectionState.done) return loader;
                            List<Review> review = snapshot.data as List<Review>;
                            return review.isEmpty
                                ? const Center(child: Text("Ovaj oglas nema niti jedanu recenziju"))
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: review
                                        .map((e) => Padding(
                                            padding: const EdgeInsets.only(right: 10),
                                            child: SizedBox(width: 250, child: ReviewDialog(space: space, review: e))))
                                        .toList(),
                                  );
                          }),
                    ),
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) => const Divider(
                height: 10,
                thickness: 2,
                color: darkGreen,
              ),
            ),
            const Expanded(child: SizedBox()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (context) => const AlertDialog(content: SpaceForm()),
                    );
                    setState(() {});
                  },
                  child: const Text("Stvori novi oglas"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

  /*Widget getMap() {
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
  }*/
