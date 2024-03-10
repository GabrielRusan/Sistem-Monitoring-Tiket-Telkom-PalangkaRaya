import 'package:flutter/material.dart';
import 'package:telkom_ticket_manager/helpers/responsivennes.dart';
import 'package:telkom_ticket_manager/widgets/large_screen.dart';
import 'package:telkom_ticket_manager/widgets/side_menu.dart';
import 'package:telkom_ticket_manager/widgets/small_screen.dart';
import 'package:telkom_ticket_manager/widgets/top_nav.dart';

class SiteLayout extends StatelessWidget {
  SiteLayout({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

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
