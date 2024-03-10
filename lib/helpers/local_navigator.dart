import 'package:flutter/widgets.dart';
import 'package:telkom_ticket_manager/constants/controllers.dart';
import 'package:telkom_ticket_manager/routing/router.dart';
import 'package:telkom_ticket_manager/routing/routes.dart';

Navigator localNavigator() => Navigator(
      key: navigationController.navigationKey,
      initialRoute: overviewPageDisplayName,
      onGenerateRoute: generateRoute,
    );
