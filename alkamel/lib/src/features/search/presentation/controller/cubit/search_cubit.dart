// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:alkamel/src/core/functions/print.dart';
import 'package:alkamel/src/features/search/data/models/hadith.dart';
import 'package:alkamel/src/features/search/data/repository/alkamel_db_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final AlkamelDbHelper alkamelDbHelper;
  SearchCubit(
    this.alkamelDbHelper,
  ) : super(const SearchLoadingState());

  Future search(String searchText) async {
    appPrint(searchText);
    final state = this.state;

    if (state is! SearchLoadedState) {
      final state = SearchLoadedState(
        searchText: searchText,
        dbHadith: const [],
        isSeaching: false,
      );

      await _search(searchText, state);
    } else {
      await _search(searchText, state);
    }
  }

  Future _search(String searchText, SearchLoadedState state) async {
    emit(state.copyWith(searchText: searchText, isSeaching: true));
    final searchResult = await alkamelDbHelper.searchByHadithText(searchText);
    emit(
      state.copyWith(
        isSeaching: false,
        dbHadith: searchResult,
        searchText: searchText,
      ),
    );
  }

  Future clear() async {}
}
