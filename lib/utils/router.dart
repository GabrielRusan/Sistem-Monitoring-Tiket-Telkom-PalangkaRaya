import 'package:flutter/material.dart';
import 'package:telkom_ticket_manager/presentations/pages/admin/admin_page.dart';
import 'package:telkom_ticket_manager/presentations/pages/authentication/authentication_page.dart';
import 'package:telkom_ticket_manager/presentations/pages/clients/clients.dart';
import 'package:telkom_ticket_manager/presentations/pages/overview/overview.dart';
import 'package:telkom_ticket_manager/presentations/pages/teknisi/teknisi_page.dart';
import 'package:telkom_ticket_manager/utils/routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case overviewPageRoute:
      return getPageRoute(const OverViewPage());
    case adminPageRoute:
      return getPageRoute(const AdminPage());
    case teknisiPageRoute:
      return getPageRoute(const TeknisiPage());
    case clientPageRoute:
      return getPageRoute(const ClientsPage());
    case authenticationPageRoute:
      return getPageRoute(const AuthenticationPage());
    default:
      return getPageRoute(const OverViewPage());
  }
}

PageRoute getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
