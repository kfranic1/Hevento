import 'package:flutter/material.dart';
import 'package:hevento/model/space.dart';
import 'package:hevento/routing/custom_router_delegate.dart';
import 'package:hevento/services/constants.dart';
import 'package:hevento/services/static_functions.dart';
import 'package:provider/provider.dart';

class SpaceListItem extends StatelessWidget {
  final Space space;

  const SpaceListItem({Key? key, required this.space}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<CustomRouterDelegate>().goToSpace(params: {"id": space.id}),
      child: Container(
        height: 350,
        width: 650,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 2.0,
              spreadRadius: 0.0,
              offset: Offset(2.0, 2.0), // shadow direction: bottom right
            )
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: FutureBuilder(
                  future: Functions.loadImage(space.id, "tileImage.jpg"),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) return loader;
                    return Image.network(
                      snapshot.data as String,
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    );
                  }),
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(child: SizedBox()),
                    if (space.tags != null)
                      Row(
                        children: space.tags!
                            .map((e) => Text(
                                  "#" + e + ' ',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ))
                            .toList(),
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      space.name,
                      style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    RichText(
                        text: TextSpan(
                      children: [
                        TextSpan(text: "${space.rating}/5.0  "),
                        TextSpan(text: "${space.numberOfReviews} glasova", style: const TextStyle(color: Colors.grey, fontSize: 14))
                      ],
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                    )),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      space.singlePrice == true ? "${space.minPrice} HRK" : "Od ${space.minPrice} HRK",
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        width: 300,
                        child: Text(
                          space.description,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 6,
                        ),
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
