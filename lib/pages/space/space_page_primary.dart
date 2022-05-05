import 'package:flutter/material.dart';
import 'package:hevento/model/space.dart';
import 'package:hevento/services/constants.dart';
import 'package:hevento/services/static_functions.dart';

class SpacePagePrimary extends StatelessWidget {
  const SpacePagePrimary({Key? key, required this.space}) : super(key: key);

  final Space space;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Functions.loadImages(space.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) return loader;
          List<String> ids = snapshot.data as List<String>;
          return Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: SingleChildScrollView(
              child: Column(
                //controller: ScrollController(),
                children: [
                  SizedBox(
                    height: 80,
                    child: Row(
                      children: [
                        Text(
                          "${space.name}  ${space.minPrice}kn",
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const Expanded(child: SizedBox()),
                        Text(
                          "${space.rating}/10 ",
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${space.numberOfReviews} glasova",
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 300,
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => SizedBox(
                        height: 300,
                        //width: 300,
                        child: Image.network(ids[index]),
                      ),
                      separatorBuilder: (context, index) => const SizedBox(width: 10),
                      itemCount: ids.length,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Number of people: ${space.numberOfPeople}",
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Number of people: ${space.numberOfPeople}",
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Number of people: ${space.numberOfPeople}",
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Number of people: ${space.numberOfPeople}",
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Text(
                          space.description,
                          style: const TextStyle(fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
