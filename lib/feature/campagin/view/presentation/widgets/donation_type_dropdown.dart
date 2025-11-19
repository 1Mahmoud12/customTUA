import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/component/custom_drop_down_menu.dart';
import '../../../../../core/component/drop_menu.dart';
import '../../../../donations/data/models/donation_type_model.dart';
import '../../manager/donation_types_cubit.dart';
import '../../manager/donation_types_state.dart';

class DonationTypeDropdown extends StatefulWidget {
  const DonationTypeDropdown({super.key, this.onChanged});

  final Function(int donationTypeId)? onChanged;

  @override
  State<DonationTypeDropdown> createState() => _DonationTypeDropdownState();
}

class _DonationTypeDropdownState extends State<DonationTypeDropdown> {
  DropDownModel? selected = DropDownModel(name: 'select_donation_type', value: -1);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DonationTypesCubit, DonationTypesState>(
      builder: (context, state) {
        final cubit = context.read<DonationTypesCubit>();

        final List<DonationTypeModel>? types;
        if (state is DonationTypesLoaded) {
          types = state.types;
        } else {
          types = cubit.cachedTypes;
        }
          // Convert Model → DropDownModel
          final items = types.map((e) => DropDownModel(name: e.title, value: e.id)).toList();

          return CustomPopupMenu(
            nameField: 'choose_donation_type',
            selectedItem: selected,
            items: items,
            onChanged: (DropDownModel? newValue) {
              setState(() => selected = newValue);
              widget.onChanged?.call(newValue?.value ?? -1);

              /// Print ID
              print('Selected Donation Type ID => ${newValue?.value}');
            },
          );


        return const SizedBox();
      },
    );
  }
}
