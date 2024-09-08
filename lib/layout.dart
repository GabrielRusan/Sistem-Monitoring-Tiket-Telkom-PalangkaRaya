import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telkom_ticket_manager/presentations/blocs/active_tiket_bloc/active_tiket_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/all_tiket_bloc/all_tiket_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/historic_tiket_bloc/historic_tiket_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/login_bloc/login_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/teknisi_bloc/teknisi_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/user_cubit/user_cubit.dart';
import 'package:telkom_ticket_manager/utils/controllers.dart';
import 'package:telkom_ticket_manager/utils/responsivennes.dart';
import 'package:telkom_ticket_manager/presentations/widgets/large_screen.dart';
import 'package:telkom_ticket_manager/presentations/widgets/side_menu.dart';
import 'package:telkom_ticket_manager/presentations/widgets/small_screen.dart';
import 'package:telkom_ticket_manager/presentations/widgets/top_nav.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telkom_ticket_manager/utils/routes.dart';

class SiteLayout extends StatefulWidget {
  const SiteLayout({super.key});

  @override
  State<SiteLayout> createState() => _SiteLayoutState();
}

class _SiteLayoutState extends State<SiteLayout> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  void initState() {
    context.read<UserCubit>().getUserData();
    context.read<TeknisiBloc>().add(FetchAllTeknisi());
    context.read<TeknisiBloc>().add(FetchAllTeknisi());
    context.read<ActiveTiketBloc>().add(FetchActiveTiket());
    context.read<AllTiketBloc>().add(FetchAllTiket());
    context.read<HistoricTiketBloc>().add(FetchHistoricTiket());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TeknisiBloc, TeknisiState>(
      listener: (context, state) {
        if (state.status == TeknisiStatus.tokenInvalid) {
          AwesomeDialog(
            context: context,
            width: 400,
            headerAnimationLoop: false,
            dismissOnTouchOutside: false,
            dialogType: DialogType.warning,
            animType: AnimType.scale,
            title: 'Warning!',
            desc: 'Sesi anda telah berakhir!',
            btnOkOnPress: () {
              context.read<UserCubit>().signOut();
              context.read<LoginBloc>().add(ClearLoginField());
              Get.offAllNamed(authenticationPageRoute);
              menuController.changeActiveItemTo(overviewPageDisplayName);
            },
            btnCancelOnPress: () {
              context.read<UserCubit>().signOut();
              context.read<LoginBloc>().add(ClearLoginField());
              Get.offAllNamed(authenticationPageRoute);
              menuController.changeActiveItemTo(overviewPageDisplayName);
            },
          ).show();
        }
      },
      child: Scaffold(
        key: scaffoldKey, // biar tau drawer scaffold mana yang dibuka
        extendBodyBehindAppBar: true,
        appBar: topNavigationBar(context, scaffoldKey),
        drawer: const Drawer(
          child: SideMenu(),
        ),
        body: const ResponsiveWidget(
          largeScreen: LargeScreen(),
          smallScreen: SmallScreen(),
        ),
      ),
    );
  }
}
