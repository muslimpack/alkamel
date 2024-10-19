// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:alkamel/src/features/home/data/models/hadith_collection_enum.dart';
import 'package:alkamel/src/features/home/data/models/hadith_ruling_enum.dart';
import 'package:alkamel/src/features/search/presentation/controller/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchFiltersBar extends StatelessWidget {
  const SearchFiltersBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is! SearchLoadedState) return const SizedBox.shrink();
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: HadithRulingEnum.values.map((e) {
              return Padding(
                padding: const EdgeInsets.all(5),
                child: ToggleButton(
                  label: Text(
                    "${e.title} (${state.dbHadith.where((h) => h.rulingEnum == e).length})",
                  ),
                  showCheckmark: false,
                  selected: state.activeRuling.contains(e),
                  onSelected: (value) async {
                    context.read<SearchCubit>().toggleRulingStatus(e, value);
                  },
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class CollectionsFiltersBar extends StatelessWidget {
  const CollectionsFiltersBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is! SearchLoadedState) return const SizedBox.shrink();
        return Wrap(
          children: HadithCollectionEnum.values.map((e) {
            return Padding(
              padding: const EdgeInsets.all(5),
              child: ToggleButton(
                label: Text(
                  "${e.title} (${state.dbHadith.where((h) => h.collectionEnum == e).length})",
                ),
                showCheckmark: false,
                selected: true,
                onSelected: (value) async {},
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
