// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  Future search(String searchText) async {}

  Future clear() async {}
}
