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
  final SearchResultInfo searchinfo;
  final List<HadithRulingEnum> activeRuling;

  int get pageSize => 10;

  const SearchLoadedState({
    required this.searchText,
    required this.searchinfo,
    required this.activeRuling,
  });

  @override
  List<Object> get props => [
        searchText,
        activeRuling,
        searchinfo,
      ];

  SearchLoadedState copyWith({
    String? searchText,
    SearchResultInfo? searchinfo,
    List<HadithRulingEnum>? activeRuling,
  }) {
    return SearchLoadedState(
      searchText: searchText ?? this.searchText,
      searchinfo: searchinfo ?? this.searchinfo,
      activeRuling: activeRuling ?? this.activeRuling,
    );
  }
}
