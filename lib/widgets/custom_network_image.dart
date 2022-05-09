import 'package:flutter/material.dart';
import 'package:hevento/services/constants.dart';
import 'package:hevento/services/static_functions.dart';

class CustomNetworkImage extends StatelessWidget {
  final String spaceId;
  final String imageName;
  const CustomNetworkImage({Key? key, required this.spaceId, required this.imageName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Functions.getImageUrl(spaceId, imageName),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) return loader;
        return Image.network(
          snapshot.data as String,
          height: double.infinity,
          //width: double.infinity,
          fit: BoxFit.fill,
        );
      },
    );
  }
}
