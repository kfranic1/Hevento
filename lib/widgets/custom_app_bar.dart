import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hevento/services/constants.dart';
import 'package:hevento/widgets/auth_buttons.dart';
import 'package:hevento/widgets/custom_divider.dart';
import 'package:hevento/widgets/title_image.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            SizedBox(
              height: 80,
              child: Row(
                children: [
                  SizedBox(
                    width: constraints.maxWidth - max(constraints.maxWidth * 2 / 7, 400),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          TitleImage(),
                          Expanded(child: SizedBox()),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 80,
                    width: max(constraints.maxWidth * 2 / 7, 400),
                    color: lightGreen,
                    child: const AuthButtons(),
                  ),
                ],
              ),
            ),
            const CustomDivider(
              divider: Divider(
                thickness: 2,
                color: darkGreen,
                indent: 0,
                endIndent: 0,
                height: 2,
              ),
              right: lightGreen,
            ),
          ],
        );
      },
    );
  }
}
