import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as getx;
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:telkom_ticket_manager/injection.dart' as di;
import 'package:telkom_ticket_manager/presentations/blocs/active_tiket_bloc/active_tiket_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/all_tiket_bloc/all_tiket_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/historic_tiket_bloc/historic_tiket_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/login_bloc/login_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/teknisi_bloc/teknisi_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/user_cubit/user_cubit.dart';
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
          getx.GetPage(
              name: authenticationPageRoute,
              page: () => const AuthenticationPage()),
        ],
        theme: ThemeData(
          scaffoldBackgroundColor: light,
          textTheme:
              GoogleFonts.mulishTextTheme(Theme.of(context).textTheme).apply(
            bodyColor: Colors.black,
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
