import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_icons.dart';

class CustomPaginationWidget extends StatelessWidget {
  final PageController pageController;
  final int pagesCount;
  final bool isNext;
  final ValueChanged<bool> onNextChanged;

  const CustomPaginationWidget({Key? key, required this.pageController, required this.pagesCount, required this.isNext, required this.onNextChanged})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (pagesCount <= 0) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
      child: FittedBox(
        // Scale down the content if it overflows
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Jump to first page
            RotatedBox(
              quarterTurns: 2,
              child: _buildPaginationButton(context: context, icon: AppIcons.Last, onTap: () => pageController.jumpToPage(0)),
            ),

            // Previous page
            RotatedBox(
              quarterTurns: 2,
              child: _buildPaginationButton(
                context: context,
                icon: AppIcons.Next,
                onTap: () {
                  onNextChanged(false);
                  if (pageController.hasClients) {
                    pageController.previousPage(duration: const Duration(milliseconds: 200), curve: Curves.linear);
                  }
                },
              ),
            ),

            // Page numbers
            if (pageController.hasClients)
              for (
                int i = isNext ? (pageController.page?.ceil() ?? 0) - 1 : (pageController.page?.floor() ?? 0) - 1;
                i <= (isNext ? (pageController.page?.ceil() ?? 0) + 1 : (pageController.page?.floor() ?? 0) + 1);
                i++
              )
                if (i >= 0 && i < pagesCount)
                  _buildPageNumber(
                    context: context,
                    pageIndex: '$i',
                    isSelected: i == (isNext ? (pageController.page?.ceil() ?? 0) : (pageController.page?.floor() ?? 0)),
                    onTap: () => pageController.jumpToPage(i),
                  ),

            // Ellipsis if there are more pages
            if (pageController.hasClients && (pageController.page?.ceil() ?? 0) < pagesCount - 2)
              _buildPageNumber(context: context, pageIndex: '...', onTap: null),

            // Next page
            _buildPaginationButton(
              context: context,
              icon: AppIcons.Next,
              onTap: () {
                onNextChanged(true);
                if (pageController.hasClients) {
                  pageController.nextPage(duration: const Duration(milliseconds: 200), curve: Curves.linear);
                }
              },
            ),

            // Last page number (if not already visible)
            if (pageController.hasClients && (pageController.page?.ceil() ?? 0) < pagesCount - 1)
              _buildPaginationButton(
                context: context,
                icon: '$pagesCount',
                onTap: () => pageController.jumpToPage(pagesCount - 1),
                showLastNumber: true,
              ),

            // Jump to last page
            _buildPaginationButton(context: context, icon: AppIcons.Last, onTap: () => pageController.jumpToPage(pagesCount - 1)),
          ],
        ),
      ),
    );
  }
}

Widget _buildPaginationButton({required BuildContext context, required String icon, required VoidCallback onTap, bool showLastNumber = false}) {
  return InkWell(
    onTap: onTap,
    child: AnimatedContainer(
      duration: Durations.long1,
      margin: const EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(border: Border.all(color: AppColors.greyG300), borderRadius: BorderRadius.circular(6), color: AppColors.white),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: showLastNumber ? Text(icon, style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppColors.black)) : SvgPicture.asset(icon),
    ),
  );
}

Widget _buildPageNumber({required BuildContext context, required String pageIndex, required VoidCallback? onTap, bool isSelected = false}) {
  // Check if the pageIndex is a numeric value or "..."
  final bool isNumeric = pageIndex != '...';

  return InkWell(
    // Disable the tap gesture for "..."
    onTap: onTap,
    child: AnimatedContainer(
      duration: Durations.long1,
      margin: const EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.greyG300),
        borderRadius: BorderRadius.circular(6),
        color: isSelected ? AppColors.primaryColor : AppColors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Text(
        isNumeric ? '${int.parse(pageIndex) + 1}' : pageIndex,
        style: Theme.of(context).textTheme.displayMedium?.copyWith(
          color: isSelected ? AppColors.white : AppColors.black,
          // Grey out the text for "..." to indicate it's non-clickable
          fontWeight: isNumeric ? FontWeight.normal : FontWeight.w300,
        ),
      ),
    ),
  );
}
