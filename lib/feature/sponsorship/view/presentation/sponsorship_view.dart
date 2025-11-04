import 'package:flutter/material.dart';
import 'package:tua/core/component/custom_app_bar.dart';
import 'package:tua/feature/sponsorship/view/presentation/widgets/item_sponsorship_widget.dart';

class SponsorshipView extends StatelessWidget {
  const SponsorshipView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'sponsorship'),

      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: const [ItemSponsorshipWidget(), ItemSponsorshipWidget(), ItemSponsorshipWidget()],
      ),
    );
  }
}
