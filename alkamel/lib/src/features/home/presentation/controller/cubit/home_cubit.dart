// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:alkamel/src/features/home/data/models/hadith_ruling_enum.dart';
import 'package:alkamel/src/features/search/data/models/hadith.dart';
import 'package:alkamel/src/features/search/data/repository/alkamel_db_helper.dart';
import 'package:alkamel/src/features/search/presentation/controller/cubit/search_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final TextEditingController searchController = TextEditingController();
  final AlkamelDbHelper alkamelDbHelper;
  final SearchCubit searchCubit;
  HomeCubit(
    this.alkamelDbHelper,
    this.searchCubit,
  ) : super(HomeLoadingState()) {
    searchController.addListener(
      () {},
    );
  }

  Future start() async {
    final authenticHadith = await alkamelDbHelper.randomHadith(
      HadithRulingEnum.authentic,
    );
    final weakHadith = await alkamelDbHelper.randomHadith(
      HadithRulingEnum.weak,
    );
    final abandonedHadith = await alkamelDbHelper.randomHadith(
      HadithRulingEnum.abandoned,
    );
    final fabricatedHadith = await alkamelDbHelper.randomHadith(
      HadithRulingEnum.fabricated,
    );

    emit(
      HomeLoadedState(
        authenticHadith: authenticHadith,
        weakHadith: weakHadith,
        abandonedHadith: abandonedHadith,
        fabricatedHadith: fabricatedHadith,
        searchText: "",
        search: false,
      ),
    );
  }

  Future search(String searchText) async {
    final state = this.state;
    if (state is! HomeLoadedState) return;

    searchCubit.search(searchText);

    emit(state.copyWith(searchText: searchText, search: true));
  }

  Future toggleSearch(bool search) async {
    final state = this.state;
    if (state is! HomeLoadedState) return;

    emit(state.copyWith(search: search));
  }

  @override
  Future<void> close() {
    EasyDebounce.cancelAll();
    return super.close();
  }
}
