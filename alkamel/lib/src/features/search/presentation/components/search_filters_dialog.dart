// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:alkamel/generated/l10n.dart';
import 'package:alkamel/src/features/search/presentation/components/search_ruling_filters_bar.dart';
import 'package:alkamel/src/features/search/presentation/components/search_type_bar.dart';
import 'package:alkamel/src/features/search/presentation/controller/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SearchFiltersButton extends StatelessWidget {
  const SearchFiltersButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return IconButton(
          onPressed: () async {
            await showSearchFilterDialog(context);
          },
          icon: Icon(MdiIcons.filter),
        );
      },
    );
  }
}

Future showSearchFilterDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (context) {
      return const SearchFiltersDialog();
    },
  );
}

class SearchFiltersDialog extends StatelessWidget {
  const SearchFiltersDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).searchFilters),
      content: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SearchTypeBar(),
            Divider(),
            SearchRullingFiltersBar(),
          ],
        ),
      ),
    );
  }
}
