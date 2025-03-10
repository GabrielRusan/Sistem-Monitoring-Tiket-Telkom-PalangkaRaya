import 'package:flutter/material.dart';
import 'package:telkom_ticket_manager/presentations/pages/absence/absence_page.dart';
import 'package:telkom_ticket_manager/presentations/pages/admin/admin_page.dart';
import 'package:telkom_ticket_manager/presentations/pages/authentication/authentication_page.dart';
import 'package:telkom_ticket_manager/presentations/pages/clients/clients.dart';
import 'package:telkom_ticket_manager/presentations/pages/odp/odp_page.dart';
import 'package:telkom_ticket_manager/presentations/pages/overview/overview.dart';
import 'package:telkom_ticket_manager/presentations/pages/teknisi/teknisi_page.dart';
import 'package:telkom_ticket_manager/utils/routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case overviewPageRoute:
      return getPageRoute(const OverViewPage());
    case adminPageRoute:
      return getPageRoute(const AdminPage());
    case absencePageRoute:
      return getPageRoute(const AbsencePage());
    case teknisiPageRoute:
      return getPageRoute(const TeknisiPage());
    case odpPageRoute:
      return getPageRoute(const OdpPage());
    case clientPageRoute:
      return getPageRoute(const ClientPage());
    case authenticationPageRoute:
      return getPageRoute(const AuthenticationPage());
    default:
      return getPageRoute(const OverViewPage());
  }
}

PageRoute getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
