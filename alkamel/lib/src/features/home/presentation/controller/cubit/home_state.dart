// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

final class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final Hadith? authenticHadith;
  final Hadith? weakHadith;
  final Hadith? fabricatedHadith;
  final String searchText;
  final bool search;

  const HomeLoadedState({
    required this.authenticHadith,
    required this.weakHadith,
    required this.fabricatedHadith,
    required this.searchText,
    required this.search,
  });

  HomeLoadedState copyWith({
    Hadith? authenticHadith,
    Hadith? weakHadith,
    Hadith? fabricatedHadith,
    String? searchText,
    bool? search,
  }) {
    return HomeLoadedState(
      authenticHadith: authenticHadith ?? this.authenticHadith,
      weakHadith: weakHadith ?? this.weakHadith,
      fabricatedHadith: fabricatedHadith ?? this.fabricatedHadith,
      searchText: searchText ?? this.searchText,
      search: search ?? this.search,
    );
  }

  @override
  List<Object?> get props => [
        authenticHadith,
        weakHadith,
        fabricatedHadith,
        searchText,
        search,
      ];
}
