import 'package:flutter/material.dart';
import 'package:hevento/model/filter.dart';
import 'package:hevento/model/space.dart';
import 'package:hevento/widgets/filters.dart';
import 'package:hevento/widgets/space_list_item.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final Filter filter = Filter();

  int page = 0;

  @override
  Widget build(BuildContext context) {
    filter.addListener(() {
      setState(() {});
    });
    /*Space s1 = Space('1');
    s1.name = "Prostor 1";
    s1.description =
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis nec vehicula leo. Aenean finibus vulputate porttitor. Vivamus ac ligula enim. Nunc in lobortis enim. Proin tincidunt risus purus, in pellentesque massa lacinia sit amet. Sed tempus interdum est, sit amet tincidunt augue cursus sit amet. Donec consectetur porttitor mauris, nec pulvinar ligula tempus mattis. Suspendisse malesuada cursus pellentesque. Etiam mollis mattis mauris, at maximus dolor pretium et. Praesent tempus vel justo a sagittis.";
    s1.maxPrice = 2000;
    s1.ocijena = 4.0;
    s1.tags = ["#Party"];
    //

    Space s2 = Space('1');
    s2.name = "Prostor 2";
    s2.description =
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis nec vehicula leo. Aenean finibus vulputate porttitor. Vivamus ac ligula enim. Nunc in lobortis enim. Proin tincidunt risus purus, in pellentesque massa lacinia sit amet. Sed tempus interdum est, sit amet tincidunt augue cursus sit amet. Donec consectetur porttitor mauris, nec pulvinar ligula tempus mattis. Suspendisse malesuada cursus pellentesque. Etiam mollis mattis mauris, at maximus dolor pretium et. Praesent tempus vel justo a sagittis.";
    s2.maxPrice = 1500;
    s2.ocijena = 4.5;
    s2.tags = ["#Party", "#Zabava", "#Rođendan"];
    //

    Space s3 = Space('1');
    s3.name = "Prostor 3";
    s3.description =
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis nec vehicula leo. Aenean finibus vulputate porttitor. Vivamus ac ligula enim. Nunc in lobortis enim. Proin tincidunt risus purus, in pellentesque massa lacinia sit amet. Sed tempus interdum est, sit amet tincidunt augue cursus sit amet. Donec consectetur porttitor mauris, nec pulvinar ligula tempus mattis. Suspendisse malesuada cursus pellentesque. Etiam mollis mattis mauris, at maximus dolor pretium et. Praesent tempus vel justo a sagittis.";
    s3.maxPrice = 1200;
    s3.ocijena = 4.3;
    s3.tags = ["#Rođendan"];
    //

    Space s4 = Space('1');
    s4.name = "Prostor 4";
    s4.description =
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis nec vehicula leo. Aenean finibus vulputate porttitor. Vivamus ac ligula enim. Nunc in lobortis enim. Proin tincidunt risus purus, in pellentesque massa lacinia sit amet. Sed tempus interdum est, sit amet tincidunt augue cursus sit amet. Donec consectetur porttitor mauris, nec pulvinar ligula tempus mattis. Suspendisse malesuada cursus pellentesque. Etiam mollis mattis mauris, at maximus dolor pretium et. Praesent tempus vel justo a sagittis.";
    s4.maxPrice = 5000;
    s4.ocijena = 5.0;
    s4.tags = ["#Maturalna"];*/
    return Center(
      child: FutureBuilder(
          future: Space.getSpaces(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            List<Space> spaces = snapshot.data as List<Space>;

            return Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: spaces.map((e) => SpaceListItem(space: e)).toList(),
                    ),
                  ),
                ),
                Filters(filter: filter),
              ],
            );
          }),
    );
  }
}
