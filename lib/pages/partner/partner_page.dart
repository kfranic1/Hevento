import 'package:flutter/material.dart';
import 'package:hevento/pages/partner/partner_page_primary.dart';
import 'package:hevento/widgets/page_wrapper.dart';

class PartnerPage extends StatelessWidget {
  const PartnerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PageWrapper(
      primary: PartnerPagePrimary(),
    );
  }
}
