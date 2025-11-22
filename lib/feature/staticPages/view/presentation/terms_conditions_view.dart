import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tua/core/component/custom_app_bar.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/extensions.dart';
import 'package:tua/feature/staticPages/view/manager/basic_page_state.dart';

import '../../../../core/utils/stripe_html.dart';
import '../../data/models/basic_page_model.dart';
import '../manager/basic_page_cubit.dart';

class TermsConditionsView extends StatefulWidget {
  const TermsConditionsView({super.key});

  @override
  State<TermsConditionsView> createState() => _TermsConditionsViewState();
}

class _TermsConditionsViewState extends State<TermsConditionsView> {
  @override
  void initState() {
    context.read<BasicPageCubit>().fetchBasicPage('terms-and-conditions');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'terms_and_conditions'),
      body: BlocBuilder<BasicPageCubit, BasicPageState>(
        builder: (context, state) {
          BasicPageModel? page;
          if (state is BasicPageLoaded) {
            page = state.page;
          } else {
            page = context.read<BasicPageCubit>().cachedPage;
          }

          if (page != null) {
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                Text(page.title, style: Theme.of(context).textTheme.displaySmall),
                Text(
                  stripHtml(page.content),
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.cP50.withAlpha((.5 * 255).toInt()),
                  ),
                ),
              ].paddingDirectional(top: 16),
            );
          }

          if (state is BasicPageLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is BasicPageError) {
            return Center(
              child: Text(state.message, style: const TextStyle(color: Colors.red, fontSize: 16)),
            );
          }

          /// fallback
          return const SizedBox();
        },
      ),
    );
  }
}
