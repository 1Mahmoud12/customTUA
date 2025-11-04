import 'package:flutter/material.dart';
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/component/custom_app_bar.dart';
import 'package:tua/core/utils/constant_gaping.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/donateGift/view/presentation/widget/donate_card.dart';

import '../../../../core/themes/colors.dart';
import 'add_donate_gift_view.dart';

class DonateGiftView extends StatefulWidget {
  const DonateGiftView({super.key});

  @override
  State<DonateGiftView> createState() => _DonateGiftViewState();
}

class _DonateGiftViewState extends State<DonateGiftView> {
  int selectedIndex = 1;

  final List<Map<String, String>> cards = [
    {
      'arabic': 'تذكاركم بالخير',
      'english': 'In Memory of',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpHZqIQHuc3I-R1eB_fyiUnb0yg9aub7KzB9SgWJk2wMBww2Vv',
    },
    {
      'arabic': 'مبروك طنجرة ولقت غطاها',
      'english': 'Marriage',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpHZqIQHuc3I-R1eB_fyiUnb0yg9aub7KzB9SgWJk2wMBww2Vv',
    },
    {
      'arabic': 'أنت أحلى هدية',
      'english': 'Birthday gift',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpHZqIQHuc3I-R1eB_fyiUnb0yg9aub7KzB9SgWJk2wMBww2Vv',
    },
    {
      'arabic': 'كل عام و أنت أغلى',
      'english': "Mother's Day",
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpHZqIQHuc3I-R1eB_fyiUnb0yg9aub7KzB9SgWJk2wMBww2Vv',
    },
    {
      'arabic': 'مبروك كبر عيلكم!',
      'english': 'New baby',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpHZqIQHuc3I-R1eB_fyiUnb0yg9aub7KzB9SgWJk2wMBww2Vv',
    },
    {
      'arabic': 'الناجح يرفع إيده',
      'english': 'Graduation',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpHZqIQHuc3I-R1eB_fyiUnb0yg9aub7KzB9SgWJk2wMBww2Vv',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'Donate your Gift'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            h10,
            Text(
              'Please choose the card according to the occasion that suits you!',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(color: AppColors.greyG600),
              textAlign: TextAlign.start,
            ),
            h10,
            Expanded(
              child: GridView.builder(
                itemCount: cards.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 0.64,
                ),
                itemBuilder: (context, index) {
                  final card = cards[index];
                  return DonateCard(
                    englishTitle: card['english']!,
                    imageUrl: card['image']!,
                    value: index,
                    groupValue: selectedIndex,
                    isSelected: selectedIndex == index,
                    onTap: () => setState(() => selectedIndex = index),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            CustomTextButton(
              onPress: () {
                context.navigateToPage(const AddDonateGiftView());
              },
              child: Text(
                'Continue',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(color: AppColors.textColor, fontWeight: FontWeight.w400),
              ),
            ),
            h10,
          ],
        ),
      ),
    );
  }
}
