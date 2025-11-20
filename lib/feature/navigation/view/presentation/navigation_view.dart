import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_icons.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/cart/view/presentation/cart_view.dart';
import 'package:tua/feature/donations/view/presentation/donations_view.dart';
import 'package:tua/feature/home/view/presentation/home_view.dart';
import 'package:tua/feature/menu/view/presentation/menu_view.dart' show MenuView;
import 'package:tua/feature/navigation/view/presentation/widgets/custom_bottom_nav.dart';
import 'package:tua/feature/navigation/view/presentation/widgets/login_required_dialog.dart';
import 'package:tua/feature/quickDonation/view/presentation/quick_donation_view.dart';

import '../../../../core/network/local/cache.dart';
import '../../../cart/data/data_source/cart_data_source_impl.dart';
import '../../../cart/view/managers/cart/cart_cubit.dart';

class NavigationView extends StatefulWidget {
  final int customIndex;

  const NavigationView({super.key, this.customIndex = 0});

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> with SingleTickerProviderStateMixin {
  int index = 0;
  late AnimationController _animationController;
  List<Widget> screens = [const HomeView(), const DonationsView(), const CartView(), const MenuView()];
  int currentInterIndex = 0;

  @override
  void initState() {
    super.initState();
    index = widget.customIndex;
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  final selectedIcons = [AppIcons.selectedHomeIc, AppIcons.selectedDonationIc, AppIcons.selectedCartIc, AppIcons.selectedMenuIc];

  final unselectedIcons = [AppIcons.unSelectedHomeIc, AppIcons.unSelectedDonationIc, AppIcons.unSelectedBasketIc, AppIcons.unSelectedMenuIc];
  final names = ['home', 'donation', 'basket', 'menu'];

  void _onItemTapped(int newIndex, BuildContext context) {
    if (newIndex==2||newIndex==3) {
      if (userCacheValue==null ) {
        loginRequiredDialog(context);
        return;
      }
    }
    setState(() {
      index = newIndex;
    });
  }

  void notRequireSignIn(int newIndex) {
    if (newIndex != index) {
      setState(() {
        index = newIndex;
      });
      _animationController.forward(from: 0);
    }
  }

  final List<GlobalKey> itemKeys = List.generate(4, (_) => GlobalKey());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(index: index, children: screens),

        bottomSheet: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (index == 0 && userCacheValue!=null)
              InkWell(
                onTap: () {
                  context.navigateToPage(const QuickDonationView());
                },
                child: Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(40), color: AppColors.cRed900),
                    child: Text(
                      'quick_donation'.tr(),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.white, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
            Container(
              color: AppColors.white,
              child: CustomBottomNavigationBar(
                currentIndex: index,
                onTap: (value) => _onItemTapped(value, context),
                selectedIcons: selectedIcons,
                unselectedIcons: unselectedIcons,
                names: names,
                showBadge: true, // Show badge on campaign tab (index 3)
              ),
            ),
          ],
        ),
      );
  }
}
