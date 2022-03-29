import 'package:flutter/material.dart';
import 'package:hevento/model/space.dart';
import 'package:hevento/widgets/filters.dart';
import 'package:hevento/widgets/space_list_item.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Space s1 = Space('1');
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
    s4.tags = ["#Maturalna"];
    return Center(
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: [
                  SpaceListItem(space: s1),
                  SpaceListItem(space: s2),
                  SpaceListItem(space: s3),
                  SpaceListItem(space: s4),
                ],
              ),
            ),
          ),
          const Expanded(
            child: Filters(),
            flex: 2,
          ),
        ],
      ),
    );
  }
}
