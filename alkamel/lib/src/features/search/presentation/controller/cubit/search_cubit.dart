// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:alkamel/src/features/home/data/models/hadith_ruling_enum.dart';
import 'package:alkamel/src/features/search/data/models/hadith.dart';
import 'package:alkamel/src/features/search/data/models/search_header.dart';
import 'package:alkamel/src/features/search/data/repository/alkamel_db_helper.dart';
import 'package:alkamel/src/features/search/domain/repository/search_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final TextEditingController searchController = TextEditingController();
  final PagingController<int, Hadith> pagingController =
      PagingController(firstPageKey: 0);
  final AlkamelDbHelper alkamelDbHelper;
  final SearchRepo searchRepo;

  SearchCubit(
    this.alkamelDbHelper,
    this.searchRepo,
  ) : super(const SearchLoadingState()) {
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future start() async {
    final state = SearchLoadedState(
      searchText: "",
      activeRuling: searchRepo.searchRulingFilters,
      searchHeader: SearchHeader.empty(),
    );
    emit(state);
  }

  ///MARK: Search

  Future search(String searchText) async {
    final state = this.state;
    if (state is! SearchLoadedState) return;

    pagingController.refresh();

    final searchHeader =
        await alkamelDbHelper.searchByHadithTextWithFiltersInfo(
      searchText,
      ruling: state.activeRuling,
    );

    emit(
      state.copyWith(
        searchText: searchText,
        searchHeader: searchHeader,
      ),
    );
  }

  ///MARK: Pagination
  Future<void> _fetchPage(int pageKey) async {
    final state = this.state;

    if (state is! SearchLoadedState) return;

    await Future.delayed(const Duration(seconds: 5));

    final pageSize = state.pageSize;
    final searchText = state.searchText;

    try {
      final newItems = await alkamelDbHelper.searchByHadithTextWithFilters(
        searchText,
        ruling: state.activeRuling,
        limit: pageSize,
        offset: pageKey,
      );

      final isLastPage = newItems.length < pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  Future clear() async {
    searchController.clear();
    await search("");
  }

  ///MARK: Ruling
  Future changeActiveRuling(List<HadithRulingEnum> activeRuling) async {
    final state = this.state;
    if (state is! SearchLoadedState) return;

    await searchRepo.setSearchRulingFilters(activeRuling);

    emit(state.copyWith(activeRuling: activeRuling));

    await search(state.searchText);
  }

  Future toggleRulingStatus(HadithRulingEnum ruling, bool activate) async {
    final state = this.state;
    if (state is! SearchLoadedState) return;

    final activeRuling = List.of(state.activeRuling);

    if (activate) {
      activeRuling.add(ruling);
    } else {
      activeRuling.remove(ruling);
    }

    await changeActiveRuling(activeRuling);
  }

  ///MARK: dispose
  @override
  Future<void> close() {
    pagingController.dispose();
    searchController.dispose();
    return super.close();
  }
}
