import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/feature/cardSetting/data/models/get_cards_response.dart';

class CreditCardDisplay extends StatelessWidget {
  final CardInfo card;

  const CreditCardDisplay({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final expiryMonth = card.expiryMonth.toString().padLeft(2, '0') ?? '00';
    final expiryYear = card.expiryYear.toString().substring(2) ?? '00';

    final cardNumber = '${card.bin}000000000${card.lastFourDigits}'; // رقم كامل 16 خانة

    final expiryDate = '$expiryMonth/$expiryYear';

    return CreditCardWidget(
      cardNumber: cardNumber,
      expiryDate: expiryDate,
      cardHolderName: card.holder,
      cvvCode: 'XXX',
      showBackView: false,
      cardBgColor: AppColors.cP50,
      obscureCardNumber: true,
      obscureInitialCardNumber: false,
      obscureCardCvv: true,
      isHolderNameVisible: true,
      height: 200,
      width: MediaQuery.of(context).size.width,
      isChipVisible: true,
      isSwipeGestureEnabled: false,
      animationDuration: Duration(milliseconds: 1000),
      frontCardBorder: Border.all(color:AppColors.cP50, width: 3),
      backCardBorder: Border.all(color: AppColors.cP50, width: 3),
      onCreditCardWidgetChange: (CreditCardBrand brand) {},
    );
  }
}
