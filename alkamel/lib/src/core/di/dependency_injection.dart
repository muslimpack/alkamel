import 'package:alkamel/src/core/constants/constant.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

final sl = GetIt.instance;

Future<void> initSL() async {
  ///MARK: Init storages
  sl.registerLazySingleton(() => Hive.box(kHiveBoxName));

  ///MARK: Init Repo

  ///MARK: Init Manager

  ///MARK: Init BLOC

  /// Singleton BLoC

  /// Factory BLoC
}
