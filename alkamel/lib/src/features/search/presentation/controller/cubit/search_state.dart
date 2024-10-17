// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_cubit.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

final class SearchLoadingState extends SearchState {
  const SearchLoadingState();
}

class SearchLoadedState extends SearchState {
  final String searchText;
  final bool isSeaching;
  final List<Hadith> dbHadith;
  List<Hadith> get hadithToView => dbHadith;

  const SearchLoadedState({
    required this.searchText,
    required this.dbHadith,
    required this.isSeaching,
  });

  @override
  List<Object> get props => [
        searchText,
        dbHadith,
        isSeaching,
      ];

  SearchLoadedState copyWith({
    String? searchText,
    bool? isSeaching,
    List<Hadith>? dbHadith,
  }) {
    return SearchLoadedState(
      searchText: searchText ?? this.searchText,
      isSeaching: isSeaching ?? this.isSeaching,
      dbHadith: dbHadith ?? this.dbHadith,
    );
  }
}
