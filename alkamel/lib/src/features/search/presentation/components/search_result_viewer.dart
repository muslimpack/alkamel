import 'package:alkamel/src/features/home/presentation/components/hadith_card.dart';
import 'package:alkamel/src/features/search/data/models/hadith.dart';
import 'package:alkamel/src/features/search/presentation/controller/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SearchResultViewer extends StatelessWidget {
  const SearchResultViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is! SearchLoadedState) return const SizedBox.shrink();

        return PagedListView<int, Hadith>(
          pagingController: context.read<SearchCubit>().pagingController,
          builderDelegate: PagedChildBuilderDelegate<Hadith>(
            itemBuilder: (context, hadith, index) => HadithCard(
              hadith: hadith,
              searchedText: state.searchText,
            ),
            newPageProgressIndicatorBuilder: (context) => const Center(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: CircularProgressIndicator(),
              ),
            ),
            noMoreItemsIndicatorBuilder: (context) => const Card(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  "noMoreItemsIndicatorBuilder",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            noItemsFoundIndicatorBuilder: (context) => const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search),
                SizedBox(height: 10),
                Text(
                  "noItemsFoundIndicatorBuilder",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
