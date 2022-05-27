import 'package:flutter/material.dart';
import 'package:hevento/model/space.dart';
import 'package:hevento/services/constants.dart';
import 'package:hevento/services/static_functions.dart';
import 'package:hevento/widgets/review_list.dart';

class SpacePagePrimary extends StatelessWidget {
  const SpacePagePrimary({Key? key, required this.space}) : super(key: key);

  final Space space;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Functions.loadImagesUrls(space.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) return loader;
          List<String> ids = snapshot.data as List<String>;
          return Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 80,
                    child: Row(
                      children: [
                        Text(
                          space.name,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const Expanded(child: SizedBox()),
                        Text(
                          "${space.rating.toStringAsFixed(1)}/5 ",
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${space.numberOfReviews} glasova",
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 300,
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Image.network(
                        ids[index],
                        height: 300,
                        fit: BoxFit.fitHeight,
                      ),
                      separatorBuilder: (context, index) => const SizedBox(width: 10),
                      itemCount: ids.length,
                    ),
                  ),
                  const SizedBox(height: 20),
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 180,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: ExpansionTile(
                                  collapsedBackgroundColor: lightGreen,
                                  title: const Text("Cijene (HRK)"),
                                  children: [
                                    for (int i = 0; i < daysLong.length; i++)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 5),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              child: Text(daysLong[i], style: priceDayStyle),
                                              width: 80,
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: Text("${space.price[i + 1] ?? "Ne iznajmulje se"}"),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: ExpansionTile(
                                  collapsedBackgroundColor: lightGreen,
                                  title: const Text("Info"),
                                  children: [
                                    const SizedBox(height: 5),
                                    infoText("music", context),
                                    const SizedBox(height: 5),
                                    infoText("waiter", context),
                                    const SizedBox(height: 5),
                                    infoText("drinks", context),
                                    const SizedBox(height: 5),
                                    infoText("food", context),
                                    const SizedBox(height: 5),
                                    infoText("security", context),
                                    const SizedBox(height: 5),
                                    infoText("specialEffects", context),
                                    const SizedBox(height: 5),
                                    infoText("smoking", context),
                                    const SizedBox(height: 5),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        const VerticalDivider(
                          width: 50,
                          color: darkGreen,
                          thickness: 3,
                          indent: 0,
                        ),
                        Expanded(
                          flex: 4,
                          child: Text(
                            space.description,
                            style: const TextStyle(fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ReviewList(space: space),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget infoText(String data, BuildContext context) {
    String showData = "";
    switch (data) {
      case "music":
        showData = "Glazba";
        break;
      case "waiter":
        showData = "Konobar";
        break;
      case "drinks":
        showData = "Piće";
        break;
      case "food":
        showData = "Hrana";
        break;
      case "security":
        showData = "Zaštitar";
        break;
      case "specialEffects":
        showData = "Specijalni efekti";
        break;
      case "smoking":
        showData = "Pušenje";
        break;
      default:
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          SizedBox(
            child: Text(
              showData,
              style: priceDayStyle,
            ),
            width: 80,
          ),
          Expanded(
            child: Center(
              child: space.elements[data] == true
                  ? const Icon(
                      Icons.check,
                      color: darkGreen,
                    )
                  : const Icon(
                      Icons.cancel,
                      color: lightGreen,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
