import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telkom_ticket_manager/data/datasources/remote_data_sources/auth/auth_remote_datasource.dart';
import 'package:telkom_ticket_manager/data/datasources/remote_data_sources/auth/auth_remote_datasource_impl.dart';
import 'package:telkom_ticket_manager/data/datasources/remote_data_sources/teknisi/teknisi_remote_data_source.dart';
import 'package:telkom_ticket_manager/data/datasources/remote_data_sources/teknisi/teknisi_remote_data_source_impl.dart';
import 'package:telkom_ticket_manager/data/repositories/auth_repository_impl.dart';
import 'package:telkom_ticket_manager/data/repositories/teknisi_repository_impl.dart';
import 'package:telkom_ticket_manager/domain/repositories/auth_repository.dart';
import 'package:telkom_ticket_manager/domain/repositories/teknisi_repository.dart';
import 'package:telkom_ticket_manager/domain/usecases/auth/login.dart';
import 'package:telkom_ticket_manager/domain/usecases/auth/logout.dart';
import 'package:telkom_ticket_manager/domain/usecases/teknisi/get_all_teknisi.dart';
import 'package:telkom_ticket_manager/presentations/blocs/login_bloc/login_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/teknisi_bloc/teknisi_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/user_cubit/user_cubit.dart';

final locator = GetIt.instance;

Future<void> init() async {
  //external
  locator.registerLazySingletonAsync<SharedPreferences>(
    () => SharedPreferences.getInstance(),
  );
  await locator.isReady<SharedPreferences>();
  locator.registerLazySingleton<Dio>(
      () => Dio(BaseOptions(connectTimeout: const Duration(seconds: 3))));
  // locator.registerLazySingleton<http.Client>(() => http.Client());

  //datasources
  locator.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sharedPref: locator(), dio: locator()));
  locator.registerLazySingleton<TeknisiRemoteDataSource>(
      () => TeknisiRemoteDataSourceImpl(locator(), locator()));

  //repositories
  locator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authRemoteDataSource: locator()));
  locator.registerLazySingleton<TeknisiRepository>(
      () => TeknisiRepositoryImpl(remoteDataSource: locator()));

  //usecases
  locator.registerLazySingleton(() => Login(repository: locator()));
  locator.registerLazySingleton(() => Logout(repository: locator()));
  locator.registerLazySingleton(() => GetAllTeknisi(repository: locator()));

  //blocs
  locator.registerFactory(() => LoginBloc(locator()));
  locator.registerFactory(() => UserCubit(locator(), locator()));
  locator.registerFactory(() => TeknisiBloc(locator()));
}
