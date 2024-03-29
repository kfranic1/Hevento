import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hevento/services/constants.dart';
import 'package:hevento/widgets/auth_buttons.dart';
import 'package:hevento/widgets/custom_app_bar.dart';
import 'package:hevento/widgets/custom_divider.dart';
import 'package:hevento/widgets/title_image.dart';

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
      final AppBar appBar = AppBar(
        actions: constraints.maxWidth <= kNarrow ? null : [SizedBox(width: constraints.maxWidth * 0.5, child: const AuthButtons())],
        leadingWidth: 100,
        title: const TitleImage(),
        toolbarHeight: 80,
        backgroundColor: lightGreen,
        bottom: const PreferredSize(
          preferredSize: Size(double.infinity, 2),
          child: CustomDivider(
            divider: Divider(
              thickness: 2,
              color: darkGreen,
              indent: 0,
              endIndent: 0,
              height: 2,
            ),
            right: lightGreen,
          ),
        ),
      );
      final Widget drawerWidget = SizedBox(
        width: 400,
        child: Column(
          children: [
            const SizedBox(
              height: 82,
              child: AuthButtons(),
            ),
            if (secondary != null) Expanded(child: secondary!),
          ],
        ),
      );
      return Scaffold(
        appBar: constraints.maxWidth <= kNarrow && shouldDisplayAppBar ? appBar : null,
        endDrawer: constraints.maxWidth <= kNarrow ? drawerWidget : null,
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
