import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as getx;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:telkom_ticket_manager/injection.dart' as di;
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
import 'package:telkom_ticket_manager/presentations/pages/detail/detail_page.dart';
import 'package:telkom_ticket_manager/presentations/pages/detail/detail_tiket_page.dart';
import 'package:telkom_ticket_manager/utils/style.dart';
import 'package:telkom_ticket_manager/presentations/controllers/menu_controller.dart';
import 'package:telkom_ticket_manager/presentations/controllers/navigation_controller.dart';
import 'package:telkom_ticket_manager/layout.dart';
import 'package:telkom_ticket_manager/presentations/pages/authentication/authentication_page.dart';
import 'package:telkom_ticket_manager/presentations/pages/not_found/not_found.dart';
import 'package:telkom_ticket_manager/utils/routes.dart';

void main() async {
  di.init();
  getx.Get.put(MyMenuController());
  getx.Get.put(NavigationController());
  await initializeDateFormatting('id_ID', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (_) => di.locator<LoginBloc>(),
        ),
        BlocProvider<UserCubit>(
          create: (_) => di.locator<UserCubit>(),
        ),
        BlocProvider<TeknisiBloc>(
          create: (_) => di.locator<TeknisiBloc>(),
        ),
        BlocProvider<ActiveTiketBloc>(
          create: (_) => di.locator<ActiveTiketBloc>(),
        ),
        BlocProvider<AllTiketBloc>(
          create: (_) => di.locator<AllTiketBloc>(),
        ),
        BlocProvider<HistoricTiketBloc>(
          create: (_) => di.locator<HistoricTiketBloc>(),
        ),
        BlocProvider<DeleteTeknisiBloc>(
          create: (_) => di.locator<DeleteTeknisiBloc>(),
        ),
        BlocProvider<AddTeknisiBloc>(
          create: (_) => di.locator<AddTeknisiBloc>(),
        ),
        BlocProvider<UpdateTeknisiBloc>(
          create: (_) => di.locator<UpdateTeknisiBloc>(),
        ),
        BlocProvider<AdminBloc>(
          create: (_) => di.locator<AdminBloc>(),
        ),
        BlocProvider<UpdateAdminBloc>(
          create: (_) => di.locator<UpdateAdminBloc>(),
        ),
        BlocProvider<PelangganBloc>(
          create: (_) => di.locator<PelangganBloc>(),
        ),
        BlocProvider<UpdatePelangganBloc>(
          create: (_) => di.locator<UpdatePelangganBloc>(),
        ),
        BlocProvider<DetailActiveTiketBloc>(
          create: (_) => di.locator<DetailActiveTiketBloc>(),
        ),
        BlocProvider<DetailHistoricTiketBloc>(
          create: (_) => di.locator<DetailHistoricTiketBloc>(),
        ),
        BlocProvider<DetailAllTiketBloc>(
          create: (_) => di.locator<DetailAllTiketBloc>(),
        ),
        BlocProvider<OdpBloc>(
          create: (_) => di.locator<OdpBloc>(),
        ),
        BlocProvider<RekapAbsenBloc>(
          create: (_) => di.locator<RekapAbsenBloc>(),
        ),
      ],
      child: getx.GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Telkom",
        initialRoute: authenticationPageRoute,
        unknownRoute: getx.GetPage(
            name: "/not-found",
            page: () => const NotFoundPage(),
            transition: getx.Transition.fadeIn),
        getPages: [
          getx.GetPage(name: rootRoute, page: () => const SiteLayout()),
          // getx.GetPage(name: absencePageRoute, page: () => const AbsencePage()),
          getx.GetPage(
              name: authenticationPageRoute,
              page: () => const AuthenticationPage()),
          getx.GetPage(
              name: detailRoute,
              page: () {
                final user = getx.Get.arguments;
                return DetailPage(
                  user: user,
                );
              }),
          getx.GetPage(
              name: detailTiketRoute,
              page: () {
                final data = getx.Get.arguments;
                return DetailTiketPage(
                  detailTiket: data?['detail_tiket'],
                  choosenIdTeknisi: data?['choosen_id_teknisi'],
                );
              }),
        ],
        theme: ThemeData(
          scaffoldBackgroundColor: light,
          textTheme:
              GoogleFonts.mulishTextTheme(Theme.of(context).textTheme).apply(
            bodyColor: Colors.black,
          ),
          inputDecorationTheme: const InputDecorationTheme(
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red, // Color for focused error border
                width: 2.0, // You can adjust the thickness here if needed
              ),
            ),
          ),
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
              TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
              TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
            },
          ),
          primaryColor: Colors.blue,
        ),
      ),
    );
  }
}
