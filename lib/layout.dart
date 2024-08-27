import 'package:flutter/material.dart';
import 'package:telkom_ticket_manager/presentations/blocs/teknisi_bloc/teknisi_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/user_cubit/user_cubit.dart';
import 'package:telkom_ticket_manager/utils/responsivennes.dart';
import 'package:telkom_ticket_manager/presentations/widgets/large_screen.dart';
import 'package:telkom_ticket_manager/presentations/widgets/side_menu.dart';
import 'package:telkom_ticket_manager/presentations/widgets/small_screen.dart';
import 'package:telkom_ticket_manager/presentations/widgets/top_nav.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
