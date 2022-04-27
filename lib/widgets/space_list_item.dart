import 'package:flutter/material.dart';
import 'package:hevento/model/space.dart';

class SpaceListItem extends StatelessWidget {
  final Space space;

  const SpaceListItem({Key? key, required this.space}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 19),
      child: Center(
        widthFactor: 1,
        heightFactor: 1,
        child: Container(
          height: 500,
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
              const Expanded(
                flex: 2,
                child: OverflowBox(
                  minWidth: 0.0,
                  minHeight: 0.0,
                  //maxWidth: 120,
                  child: Image(
                    image: AssetImage('images/tileImage.jpg'),
                    fit: BoxFit.cover,
                    height: 500,
                  ),
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
                      Row(
                        children: space.tags.map((e) => Text(e + ' ')).toList(),
                      ),
                      const Expanded(child: SizedBox()),
                      Text(
                        space.name,
                        style: const TextStyle(fontSize: 30),
                      ),
                      const Expanded(child: SizedBox()),
                      Text(
                        "${space.ocijena}/5.0",
                        style: const TextStyle(fontSize: 20),
                      ),
                      const Expanded(child: SizedBox()),
                      Text(
                        "from " + space.minPrice.toString() + " to " + space.maxPrice.toString(),
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const Expanded(
                        child: SizedBox(),
                      ),
                      Expanded(
                        flex: 5,
                        child: SizedBox(
                          width: 300,
                          child: Text(
                            space.description,
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.fade,
                            maxLines: 10,
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
