import 'package:alkamel/generated/l10n.dart';
import 'package:alkamel/src/features/home/presentation/components/hadith_card.dart';
import 'package:alkamel/src/features/search/presentation/controller/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is! SearchLoadedState) {
          return const SizedBox();
        }

        return Column(
          children: [
            const SizedBox(height: 15),
            if (state.isSeaching) const LinearProgressIndicator(),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                "${S.of(context).searchResultCount}: ${state.hadithToView.length}",
              ),
            ),
            Expanded(
              child: () {
                if (state.searchText.isNotEmpty && state.hadithToView.isEmpty) {
                  return Center(
                    child: Text(
                      "${S.of(context).searchResultCount}: ${state.searchText}",
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(15),
                  itemCount: state.hadithToView.length,
                  itemBuilder: (context, index) {
                    return HadithCard(
                      hadith: state.hadithToView[index],
                      searchedText: state.searchText,
                    );
                  },
                );
              }(),
            ),
          ],
        );
      },
    );
  }
}
