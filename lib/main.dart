import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telkom_ticket_manager/utils/style.dart';
import 'package:telkom_ticket_manager/presentations/controllers/menu_controller.dart';
import 'package:telkom_ticket_manager/presentations/controllers/navigation_controller.dart';
import 'package:telkom_ticket_manager/layout.dart';
import 'package:telkom_ticket_manager/presentations/pages/authentication/authentication.dart';
import 'package:telkom_ticket_manager/presentations/pages/not_found/not_found.dart';
import 'package:telkom_ticket_manager/utils/routes.dart';

void main() {
  Get.put(MyMenuController());
  Get.put(NavigationController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Telkom",
      initialRoute: authenticationPageRoute,
      unknownRoute: GetPage(
          name: "/not-found",
          page: () => const NotFoundPage(),
          transition: Transition.fadeIn),
      getPages: [
        GetPage(name: rootRoute, page: () => SiteLayout()),
        GetPage(
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
    );
  }
}
