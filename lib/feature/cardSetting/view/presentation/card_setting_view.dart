import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/component/custom_app_bar.dart';
import 'package:tua/core/component/loadsErros/loading_widget.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/errorLoadingWidgets/empty_widget.dart';
import 'package:tua/core/utils/navigate.dart';

import '../../../../core/utils/custom_show_toast.dart';
import '../../../cart/data/data_source/hyper_pay_data_source.dart';
import '../../../cart/view/managers/hyper_pay/hyper_pay_checkout_cubit.dart' hide HyperPayConfigError;
import '../../../cart/view/presentation/hyper_pay_webview.dart';
import '../../data/data_source/card_settings_data_source.dart';
import '../../data/models/get_cards_response.dart';
import '../manager/card_settings_cubit.dart';
import 'widgets/credit_card_display.dart';

class CardSettingView extends StatelessWidget {
  const CardSettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'card_settings'.tr()),
      body: BlocProvider(
        create: (context) =>
        CardSettingsCubit(CardSettingsDataSource(), HyperPayDataSource())
          ..getCards(),
        child: BlocConsumer<CardSettingsCubit, CardSettingsState>(
          listener: (context, state) {
            if (state is SaveCardError) {
              customShowToast(context, state.message,
                  showToastStatus: ShowToastStatus.error);
            }
            if (state is HyperPayConfigError) {
              customShowToast(context, state.message,
                  showToastStatus: ShowToastStatus.error);
            }
            if (state is GetCardsError) {
              customShowToast(context, state.message.tr(),
                  showToastStatus: ShowToastStatus.error);
            }
            if (state is SaveCardSuccess) {
              context.navigateToPage(
                BlocProvider(
                  create: (context) => HyperPayCubit(HyperPayDataSource()),
                  child: HyperPayWebView(
                    checkoutId: state.data.data.checkoutId,
                    config: context.read<CardSettingsCubit>().config!,
                    purchaseType: PurchaseType.cart,
                    isPayment: false,
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            final cubit = context.read<CardSettingsCubit>();
            List<CardInfo> cards = [];

            // Get cards from state or cache
            if (state is GetCardsSuccess) {
              cards = state.data;
            } else {
              cards = cubit.cachedCards ?? [];
            }

            return RefreshIndicator(
              onRefresh: () => cubit.refresh(),
              child: ListView(
                // padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  const SizedBox(height: 24),

                  // Loading State
                  if (state is GetCardsLoading && cards.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 100.0),
                      child: LoadingWidget(),
                    )

                  // Cards List
                  else if (cards.isNotEmpty)
                    Column(
                      children: cards
                          .map((card) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: CreditCardDisplay(card: card),
                      ))
                          .toList(),
                    )

                  // Empty State
                  else
                    Column(
                      children: [
                        const EmptyWidget(
                          emptyImage: EmptyImages.noDonationsHistoryIc, // استخدم الأيقونة المناسبة
                        ),
                        const SizedBox(height: 30),
                        CustomTextButton(
                          onPress: () {
                            cubit.getCards();
                          },
                          childText: 'retry'.tr(),
                        ),
                      ],
                    ),
                  SizedBox(height: 50,),
                  CustomTextButton(
                    childText: 'add_another_card'.tr(),
                    onPress: () async {
                      final cubit = context.read<CardSettingsCubit>();

                      // Step 1: Fetch config first
                      if (cubit.config == null) {
                        await cubit.getHyperPayConfig(lang: 'ar');

                        // Check if config was loaded successfully
                        if (cubit.config == null) {
                          return; // Error already shown in listener
                        }
                      }

                      // Step 2: Create checkout session
                      await cubit.saveCard();
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),

      // Add Card Button at Bottom

    );
  }
}