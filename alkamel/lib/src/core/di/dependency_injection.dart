import 'package:alkamel/src/core/constants/constant.dart';
import 'package:alkamel/src/features/home/presentation/controller/cubit/home_cubit.dart';
import 'package:alkamel/src/features/search/data/repository/alkamel_db_helper.dart';
import 'package:alkamel/src/features/search/presentation/controller/cubit/search_cubit.dart';
import 'package:alkamel/src/features/share/presentation/controller/cubit/share_image_cubit.dart';
import 'package:alkamel/src/features/themes/data/repository/theme_repo.dart';
import 'package:alkamel/src/features/themes/presentation/controller/cubit/theme_cubit.dart';
import 'package:alkamel/src/features/ui/data/repository/ui_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

final sl = GetIt.instance;

Future<void> initSL() async {
  ///MARK: Init storages
  sl.registerLazySingleton(() => Hive.box(kHiveBoxName));
  sl.registerLazySingleton(() => UIRepo(sl()));
  sl.registerLazySingleton(() => ThemeRepo(sl()));

  ///MARK: Init Repo
  sl.registerLazySingleton(() => AlkamelDbHelper());

  ///MARK: Init Manager

  ///MARK: Init BLOC

  /// Singleton BLoC
  sl.registerLazySingleton(() => ThemeCubit(sl()));
  sl.registerLazySingleton(() => SearchCubit(sl()));
  sl.registerLazySingleton(() => HomeCubit(sl(), sl()));

  /// Factory BLoC
  sl.registerFactory(() => ShareImageCubit());
}
