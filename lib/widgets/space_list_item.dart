import 'package:flutter/material.dart';
import 'package:hevento/model/space.dart';
import 'package:hevento/routing/custom_router_delegate.dart';
import 'package:hevento/widgets/custom_network_image.dart';
import 'package:provider/provider.dart';

class SpaceListItem extends StatelessWidget {
  final Space space;

  const SpaceListItem({Key? key, required this.space}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      //added because of boxShadow offset
      padding: const EdgeInsets.only(right: 3, bottom: 3),
      child: GestureDetector(
        onTap: () => context.read<CustomRouterDelegate>().goToSpace(params: {"id": space.id}),
        child: Container(
          height: 300,
          width: 600,
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 2.0,
                spreadRadius: 0.0,
                offset: Offset(2.0, 2.0), // shadow direction: bottom right
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: CustomNetworkImage(
                  spaceId: space.id,
                  imageName: space.profileImage,
                ),
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
                                    e + ' ',
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ))
                              .toList(),
                        ),
                      const SizedBox(height: 20),
                      Text(
                        space.name,
                        style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      RichText(
                          text: TextSpan(
                        children: [
                          TextSpan(text: "${space.rating.toStringAsFixed(1)}/5.0  "),
                          TextSpan(text: "${space.numberOfReviews} glasova", style: const TextStyle(color: Colors.grey, fontSize: 14))
                        ],
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                      )),
                      const SizedBox(height: 10),
                      Text(
                        space.singlePrice == true ? "${space.minPrice} HRK" : "Od ${space.minPrice} HRK",
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 15),
                      Expanded(
                        flex: 3,
                        child: SingleChildScrollView(
                          controller: ScrollController(),
                          child: SizedBox(
                            width: 300,
                            child: Text(
                              space.description,
                              style: const TextStyle(fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 6,
                            ),
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
      ),
    );
  }
}
