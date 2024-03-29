import 'package:flutter/material.dart';
import 'package:hevento/services/constants.dart';

class CustomDivider extends StatelessWidget {
  final Color left, right;
  final Divider divider;
  final double padding;

  const CustomDivider({Key? key, required this.divider, this.padding = defaultPadding, this.left = Colors.white, this.right = Colors.white}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          color: left,
          height: divider.height,
          width: padding,
        ),
        Expanded(child: divider),
        Container(
          color: right,
          height: divider.height,
          width: padding,
        ),
      ],
    );
  }
}
