// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:alkamel/src/features/home/data/models/hadith_collection_enum.dart';
import 'package:alkamel/src/features/search/presentation/controller/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCollectionsFiltersBar extends StatelessWidget {
  const SearchCollectionsFiltersBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is! SearchLoadedState) return const SizedBox.shrink();
        return Wrap(
          alignment: WrapAlignment.center,
          runSpacing: 10,
          spacing: 10,
          children: [
            IconButton(
              onPressed: () {
                context.read<SearchCubit>().changeActiveCollections(
                      state.activeCollections.isEmpty
                          ? HadithCollectionEnum.values
                          : [],
                    );
              },
              icon: const Icon(Icons.checklist_outlined),
            ),
            ...HadithCollectionEnum.values.map((e) {
              return ToggleButton(
                label: Text(
                  "${e.title} (${state.dbHadith.where((h) => h.collectionEnum == e).length})",
                ),
                showCheckmark: false,
                selected: state.activeCollections.contains(e),
                onSelected: (value) async {
                  context.read<SearchCubit>().toggleCollectionsStatus(e, value);
                },
              );
            }),
          ],
        );
      },
    );
  }
}