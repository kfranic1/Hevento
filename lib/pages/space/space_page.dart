import 'package:flutter/material.dart';
import 'package:hevento/model/space.dart';
import 'package:hevento/pages/space/space_page_primary.dart';
import 'package:hevento/pages/space/space_page_secondary.dart';
import 'package:hevento/widgets/page_wrapper.dart';

class SpacePage extends StatelessWidget {
  final Space space;
  const SpacePage({Key? key, required this.space}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      primary: SpacePagePrimary(space: space),
      secondary: SpacePageSecondary(space: space),
    );
  }
}
