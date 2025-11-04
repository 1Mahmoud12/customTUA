import 'package:flutter/material.dart';
import 'package:tua/core/component/custom_divider_widget.dart';
import 'package:tua/core/component/search_widget.dart';
import 'package:tua/core/utils/errorLoadingWidgets/empty_widget.dart';
import 'package:tua/feature/home/view/presentation/widgets/header_widget.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: Column(
        children: [
          const HeaderWidget(),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                InkWell(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back)),
                const SizedBox(width: 16),
                const Expanded(child: SearchWidget()),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const CustomDividerWidget(),

          const Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EmptyWidget(
                  emptyImage: EmptyImages.noSearchResults,
                  data: 'No search results found',
                  subData: ' Please try again with a different keyword or phrase.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
