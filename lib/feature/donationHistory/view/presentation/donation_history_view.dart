import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/component/custom_app_bar.dart';
import 'package:tua/core/component/custom_drop_down_menu.dart';
import 'package:tua/core/component/drop_menu.dart' show CustomPopupMenu;
import 'package:tua/core/component/loadsErros/loading_widget.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/errorLoadingWidgets/empty_widget.dart';
import 'package:tua/feature/donationHistory/data/data_source/get_donations_history_data_source.dart';
import 'package:tua/feature/donationHistory/view/manager/donations_history_cubit.dart';
import 'package:tua/feature/sponsorship/view/presentation/widgets/date_picker_dialog.dart';

import '../../../../core/component/fields/custom_text_form_field.dart';
import '../../../../core/utils/custom_show_toast.dart';
import '../../../cart/view/managers/get_user_info/get_user_info_cubit.dart';
import '../../../cart/view/managers/get_user_info/get_user_info_state.dart';
import '../../data/models/donations_history_response.dart';
import '../manager/donations_history_state.dart';
import 'widgets/item_donation_history_widget.dart';

class DonationHistoryView extends StatelessWidget {
  const DonationHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'donation_history'),
      body: BlocProvider(
        create: (context) => DonationsHistoryCubit(DonationsHistoryDataSource())..loadHistory(context),
        child: BlocConsumer<DonationsHistoryCubit, DonationsHistoryState>(
          listener: (context, state) {
            if (state is DonationsHistoryError) {
              customShowToast(context, state.message.tr(), showToastStatus: ShowToastStatus.error);
            }
          },
          builder: (context, state) {
            final cubit = context.read<DonationsHistoryCubit>();
            List<DonationItem> donations = [];
            if (state is DonationsHistoryLoaded) {
              donations = state.response.data.donations;
            } else {
              donations = cubit.cached?.data.donations ?? [];
            }

            return RefreshIndicator(
              onRefresh: () => context.read<DonationsHistoryCubit>().refresh(context),
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  const SizedBox(height: 24),
                  BlocBuilder<UserInfoCubit, GetUserInfoState>(
                    builder: (context, state) {
                      final cubit = context.read<UserInfoCubit>();

                      return cubit.users.isNotEmpty
                          ? CustomPopupMenu(
                            onChanged: (DropDownModel? selectedItem) {
                              if (selectedItem != null) {
                                cubit.selectUser(selectedItem.value as int);
                              }
                              context.read<DonationsHistoryCubit>().userID = '${cubit.selectedUser?.guid}|S|${cubit.selectedUser?.name}';
                              context.read<DonationsHistoryCubit>().loadHistory(context);

                              // print('Selected user: ${cubit.selectedUser?.name}');
                              // print('Selected user ID: ${cubit.selectedUser?.id}');
                              // print('Selected user GUID: ${cubit.selectedUser?.guid}');
                            },
                            nameField: 'select_donor',
                            selectedItem:
                                cubit.selectedUser != null
                                    ? DropDownModel(name: 'select_donor', value: -1)
                                    : DropDownModel(name: cubit.users.first.name, value: cubit.users.first.id),
                            items: cubit.users.map((e) => DropDownModel(name: e.name, value: e.id)).toList(),
                          )
                          : const SizedBox();
                    },
                  ),
                  const SizedBox(height: 22.5),
                  Row(
                    children: [
                      // -----------------------------start date----------------------
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder:
                                  (_) => Center(
                                    child: BeautifulDatePicker(
                                      firstDate: DateTime.now().subtract(const Duration(days: 365 * 2)),
                                      initialDate: DateTime.now(),
                                      lastDate: DateTime.now(),
                                      onDateSelected: cubit.onStartDateSelected,
                                    ),
                                  ),
                            );
                          },
                          child: CustomTextFormField(
                            enable: false,
                            controller: cubit.startDateController,
                            hintText: 'DD/MM/YYYY',
                            nameField: 'start_date',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please_select_start_date'.tr();
                              }
                              return null;
                            },
                          ),
                        ),
                      ),

                      const SizedBox(width: 16),

                      /// ---------------------- END DATE ----------------------
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder:
                                  (_) => Center(
                                    child: BeautifulDatePicker(
                                      firstDate: DateTime.now().subtract(const Duration(days: 365 * 2)),
                                      initialDate: DateTime.now(),
                                      lastDate: DateTime.now(),
                                      onDateSelected: cubit.onEndDateSelected,
                                    ),
                                  ),
                            );
                          },
                          child: CustomTextFormField(
                            enable: false,
                            controller: cubit.endDateController,
                            hintText: 'DD/MM/YYYY',
                            nameField: 'end_date',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please_select_end_date'.tr();
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  if (state is DonationsHistoryLoading)
                    const Padding(padding: EdgeInsets.symmetric(vertical: 100.0), child: LoadingWidget())
                  else if (donations.isNotEmpty)
                    Column(children: donations.map((e) => ItemDonationHistoryWidget(donation: e)).toList())
                  else
                    Column(
                      children: [
                        const EmptyWidget(emptyImage: EmptyImages.noDonationsHistoryIc),
                        const SizedBox(height: 30),
                        CustomTextButton(
                          onPress: () {
                            cubit.loadHistory(context);
                          },
                          childText: 'retry'.tr(),
                        ),
                      ],
                    ),
                ],
              ),
            );
          },
        ),
      ),
      persistentFooterButtons: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [BoxShadow(color: AppColors.cShadowColor.withAlpha((.25 * 255).toInt()), blurRadius: 15, offset: const Offset(0, -10))],
          ),
          child: CustomTextButton(onPress: () {}, childText: 'download_as_pdf'.tr()),
        ),
      ],
    );
  }
}
