// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:alkamel/src/core/functions/print.dart';
import 'package:alkamel/src/features/home/data/models/hadith_ruling_enum.dart';
import 'package:alkamel/src/features/search/data/models/hadith.dart';
import 'package:alkamel/src/features/search/data/repository/alkamel_db_helper.dart';
import 'package:alkamel/src/features/search/domain/repository/search_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final AlkamelDbHelper alkamelDbHelper;
  final SearchRepo searchRepo;
  SearchCubit(
    this.alkamelDbHelper,
    this.searchRepo,
  ) : super(const SearchLoadingState());

  Future search(String searchText) async {
    appPrint(searchText);
    final state = this.state;

    if (state is! SearchLoadedState) {
      final state = SearchLoadedState(
        searchText: searchText,
        activeRuling: searchRepo.searchRulingFilters,
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
    if (searchText.isEmpty) {
      emit(
        state.copyWith(
          isSeaching: false,
          dbHadith: [],
          searchText: searchText,
        ),
      );
      return;
    }
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

  Future changeActiveRuling(List<HadithRulingEnum> activeRuling) async {
    final state = this.state;
    if (state is! SearchLoadedState) return;

    await searchRepo.setSearchRulingFilters(activeRuling);

    emit(state.copyWith(activeRuling: activeRuling));
  }
}
