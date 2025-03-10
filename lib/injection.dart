import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telkom_ticket_manager/data/datasources/remote_data_sources/admin/admin_remote_data_source.dart';
import 'package:telkom_ticket_manager/data/datasources/remote_data_sources/admin/admin_remote_data_source_impl.dart';
import 'package:telkom_ticket_manager/data/datasources/remote_data_sources/auth/auth_remote_datasource.dart';
import 'package:telkom_ticket_manager/data/datasources/remote_data_sources/auth/auth_remote_datasource_impl.dart';
import 'package:telkom_ticket_manager/data/datasources/remote_data_sources/odp/odp_remote_data_source.dart';
import 'package:telkom_ticket_manager/data/datasources/remote_data_sources/pelanggan/pelanggan_remote_data_source.dart';
import 'package:telkom_ticket_manager/data/datasources/remote_data_sources/pelanggan/pelanggan_remote_data_source_impl.dart';
import 'package:telkom_ticket_manager/data/datasources/remote_data_sources/rekap_absen/rekap_absen_remote_data_source.dart';
import 'package:telkom_ticket_manager/data/datasources/remote_data_sources/rekap_absen/rekap_absen_remote_data_source_impl.dart';
import 'package:telkom_ticket_manager/data/datasources/remote_data_sources/teknisi/teknisi_remote_data_source.dart';
import 'package:telkom_ticket_manager/data/datasources/remote_data_sources/teknisi/teknisi_remote_data_source_impl.dart';
import 'package:telkom_ticket_manager/data/datasources/remote_data_sources/tiket/tiket_remote_data_source.dart';
import 'package:telkom_ticket_manager/data/datasources/remote_data_sources/tiket/tiket_remote_data_source_impl.dart';
import 'package:telkom_ticket_manager/data/repositories/admin_repository_impl.dart';
import 'package:telkom_ticket_manager/data/repositories/auth_repository_impl.dart';
import 'package:telkom_ticket_manager/data/repositories/pelanggan_repository_impl.dart';
import 'package:telkom_ticket_manager/data/repositories/rekap_absen_repository_impl.dart';
import 'package:telkom_ticket_manager/data/repositories/teknisi_repository_impl.dart';
import 'package:telkom_ticket_manager/data/repositories/tiket_repository_impl.dart';
import 'package:telkom_ticket_manager/domain/repositories/admin_repository.dart';
import 'package:telkom_ticket_manager/domain/repositories/auth_repository.dart';
import 'package:telkom_ticket_manager/domain/repositories/pelanggan_repository.dart';
import 'package:telkom_ticket_manager/domain/repositories/rekap_absen_repository.dart';
import 'package:telkom_ticket_manager/domain/repositories/teknisi_repository.dart';
import 'package:telkom_ticket_manager/domain/repositories/tiket_repository.dart';
import 'package:telkom_ticket_manager/domain/usecases/auth/login.dart';
import 'package:telkom_ticket_manager/domain/usecases/auth/logout.dart';
import 'package:telkom_ticket_manager/domain/usecases/teknisi/get_all_teknisi.dart';
import 'package:telkom_ticket_manager/presentations/blocs/active_tiket_bloc/active_tiket_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/add_teknisi_bloc/add_teknisi_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/admin_bloc/admin_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/all_tiket_bloc/all_tiket_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/delete_teknisi_bloc/delete_teknisi_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/detail_active_tiket_bloc/detail_active_tiket_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/detail_all_tiket_bloc/detail_all_tiket_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/detail_historic_tiket_bloc/detail_historic_tiket_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/historic_tiket_bloc/historic_tiket_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/login_bloc/login_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/odp_bloc/odp_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/pelanggan_bloc/pelanggan_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/rekap_absen_bloc/rekap_absen_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/teknisi_bloc/teknisi_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/update_admin_bloc/update_admin_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/update_pelanggan_bloc/update_pelanggan_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/update_teknisi_bloc/update_teknisi_bloc.dart';
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
  locator.registerLazySingleton<TiketRemoteDataSource>(
      () => TiketRemoteDataSourceImpl(locator(), locator()));
  locator.registerLazySingleton<AdminRemoteDataSource>(
      () => AdminRemoteDataSourceImpl(locator(), locator()));
  locator.registerLazySingleton<PelangganRemoteDataSource>(
      () => PelangganRemoteDataSourceImpl(locator(), locator()));
  locator.registerLazySingleton<OdpRemoteDataSource>(
      () => OdpRemoteDataSource(locator(), locator()));
  locator.registerLazySingleton<RekapAbsenRemoteDataSource>(
      () => RekapAbsenRemoteDataSourceImpl(locator(), locator()));

  //repositories
  locator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authRemoteDataSource: locator()));
  locator.registerLazySingleton<TeknisiRepository>(
      () => TeknisiRepositoryImpl(remoteDataSource: locator()));
  locator.registerLazySingleton<TiketRepository>(
      () => TiketRepositoryImpl(remoteSource: locator()));
  locator.registerLazySingleton<AdminRepository>(
      () => AdminRepositoryImpl(remoteDataSource: locator()));
  locator.registerLazySingleton<PelangganRepository>(
      () => PelangganRepositoryImpl(remoteDataSource: locator()));
  locator.registerLazySingleton<RekapAbsenRepository>(
      () => RekapAbsenRepositoryImpl(datasource: locator()));

  //usecases
  locator.registerLazySingleton(() => Login(repository: locator()));
  locator.registerLazySingleton(() => Logout(repository: locator()));
  locator.registerLazySingleton(() => GetAllTeknisi(repository: locator()));

  //blocs
  locator.registerFactory(() => LoginBloc(locator()));
  locator.registerFactory(() => UserCubit(locator(), locator()));
  locator.registerFactory(() => TeknisiBloc(locator()));
  locator.registerFactory(() => ActiveTiketBloc(locator()));
  locator.registerFactory(() => AllTiketBloc(locator()));
  locator.registerFactory(() => HistoricTiketBloc(locator()));
  locator.registerFactory(() => DeleteTeknisiBloc(locator()));
  locator.registerFactory(() => AddTeknisiBloc(locator()));
  locator.registerFactory(() => UpdateTeknisiBloc(locator()));
  locator.registerFactory(() => AdminBloc(locator()));
  locator.registerFactory(() => UpdateAdminBloc(locator()));
  locator.registerFactory(() => PelangganBloc(locator()));
  locator.registerFactory(() => UpdatePelangganBloc(locator()));
  locator.registerFactory(() => DetailActiveTiketBloc(locator()));
  locator.registerFactory(() => DetailHistoricTiketBloc(locator()));
  locator.registerFactory(() => DetailAllTiketBloc(locator()));
  locator.registerFactory(() => OdpBloc(locator()));
  locator.registerFactory(() => RekapAbsenBloc(locator()));
}
