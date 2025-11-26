import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tua/core/component/cache_image.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/feature/common/data/dataSource/e_card_data_source.dart';
import 'package:tua/feature/common/data/models/e_card_model.dart';

class SelectCardWidget extends StatefulWidget {
  final Function(int?)? onCardSelected;
  final bool isOptional;

  const SelectCardWidget({super.key, this.onCardSelected, this.isOptional = true});

  @override
  State<SelectCardWidget> createState() => _SelectCardWidgetState();
}

class _SelectCardWidgetState extends State<SelectCardWidget> {
  int? _selectedCardId;
  List<ECardModel> _eCards = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadECards();
  }

  Future<void> _loadECards() async {
    final result = await ECardDataSource.fetchECards();
    result.fold(
      (failure) {
        setState(() {
          _isLoading = false;
        });
      },
      (response) {
        if (context.mounted) {
          setState(() {
            _eCards = response.data;
            _isLoading = false;
          });
        }
      },
    );
  }

  void _onCardSelected(int cardId, int index) {
    setState(() {
      _selectedCardId = cardId;
    });
    widget.onCardSelected?.call(cardId);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text.rich(
            TextSpan(
              text: 'select_an_e-card_design'.tr(),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400, color: AppColors.cP50),
              children: [
                TextSpan(text: ' ', style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w700)),
                TextSpan(
                  text:widget.isOptional == true ? '(${'optional'.tr()})':'',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400, color: AppColors.cP50.withAlpha((0.4 * 255).toInt())),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        if (_isLoading)
          const Padding(padding: EdgeInsets.symmetric(vertical: 20), child: Center(child: CircularProgressIndicator()))
        else if (_eCards.isEmpty)
          const SizedBox.shrink()
        else
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(width: 8),
                ..._eCards.asMap().entries.map((entry) {
                  final index = entry.key;
                  final card = entry.value;
                  return ItemGiftWidget(
                    index: index,
                    card: card,
                    onPress: (p0) => _onCardSelected(card.id, p0),
                    selected: _selectedCardId == card.id,
                  );
                }),
                const SizedBox(width: 8),
              ],
            ),
          ),
      ],
    );
  }
}

class ItemGiftWidget extends StatelessWidget {
  final bool selected;
  final int index;
  final Function(int) onPress;
  final ECardModel? card;

  const ItemGiftWidget({super.key, required this.selected, required this.onPress, required this.index, this.card});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPress(index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: selected == true ? AppColors.cP50 : AppColors.cP50.withAlpha((0.15 * 255).toInt())),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            CacheImage(urlImage: card?.image ?? '', width: 100, height: 100, borderRadius: 10),
            const SizedBox(height: 10),
            Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.cP50, width: 1.5)),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 12,
                height: 12,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(shape: BoxShape.circle, color: selected == true ? AppColors.cP50 : Colors.transparent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
