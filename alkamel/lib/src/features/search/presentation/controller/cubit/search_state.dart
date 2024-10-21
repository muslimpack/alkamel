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
  final SearchHeader searchHeader;
  final List<HadithRulingEnum> activeRuling;

  int get pageSize => 10;

  const SearchLoadedState({
    required this.searchText,
    required this.searchHeader,
    required this.activeRuling,
  });

  @override
  List<Object> get props => [
        searchText,
        activeRuling,
        searchHeader,
      ];

  SearchLoadedState copyWith({
    String? searchText,
    SearchHeader? searchHeader,
    List<HadithRulingEnum>? activeRuling,
  }) {
    return SearchLoadedState(
      searchText: searchText ?? this.searchText,
      searchHeader: searchHeader ?? this.searchHeader,
      activeRuling: activeRuling ?? this.activeRuling,
    );
  }
}
