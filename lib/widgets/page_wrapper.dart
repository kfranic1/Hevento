import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hevento/services/constants.dart';
import 'package:hevento/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';

class PageWrapper extends StatelessWidget {
  final Widget primary;
  final CustomAppBar? customAppBar;
  final Widget? secondary;
  final bool shouldDisplayAppBar;
  const PageWrapper({Key? key, required this.primary, this.secondary, this.customAppBar = const CustomAppBar(), this.shouldDisplayAppBar = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: constraints.maxWidth <= kNarrow && shouldDisplayAppBar ? context.read<AppBar>() : null,
        endDrawer: SizedBox(width: 400, child: secondary),
        body: Column(children: [
          if (constraints.maxWidth > kNarrow && shouldDisplayAppBar && customAppBar != null) customAppBar!,
          Expanded(
            child: LayoutBuilder(builder: (context, constraints) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: primary),
                  if (secondary != null && constraints.maxWidth > kNarrow)
                    SizedBox(
                      width: max(constraints.maxWidth * 2 / 7, 400),
                      child: secondary,
                    ),
                ],
              );
            }),
          ),
        ]),
      );
    });
  }
}
