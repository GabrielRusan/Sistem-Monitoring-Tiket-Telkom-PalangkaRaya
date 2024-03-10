import 'package:flutter/material.dart';
import 'package:telkom_ticket_manager/pages/authentication/authentication.dart';
import 'package:telkom_ticket_manager/pages/clients/clients.dart';
import 'package:telkom_ticket_manager/pages/overview/overview.dart';
import 'package:telkom_ticket_manager/pages/teknisi/teknisi.dart';
import 'package:telkom_ticket_manager/routing/routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case overviewPageRoute:
      return getPageRoute(const OverViewPage());
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
