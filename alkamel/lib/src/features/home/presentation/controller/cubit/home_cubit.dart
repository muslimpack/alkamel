// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:alkamel/src/features/search/data/models/hadith.dart';
import 'package:alkamel/src/features/search/data/repository/alkamel_db_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final AlkamelDbHelper alkamelDbHelper;
  HomeCubit(
    this.alkamelDbHelper,
  ) : super(HomeLoadingState());

  Future start() async {
    final authenticHadith = await alkamelDbHelper.randomHadith("صحيح");
    final weakHadith = await alkamelDbHelper.randomHadith("ضعيف");
    final fabricatedHadith = await alkamelDbHelper.randomHadith("مكذوب");

    emit(
      HomeLoadedState(
        authenticHadith: authenticHadith,
        weakHadith: weakHadith,
        fabricatedHadith: fabricatedHadith,
      ),
    );
  }
}
