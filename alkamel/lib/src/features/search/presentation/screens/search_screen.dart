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
            if (state.isSeaching) const LinearProgressIndicator(),
            Text("${state.hadithToView.length}"),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(15),
                itemCount: state.hadithToView.length,
                itemBuilder: (context, index) {
                  return HadithCard(hadith: state.hadithToView[index]);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
