import 'package:flutter/widgets.dart';
import 'package:telkom_ticket_manager/utils/controllers.dart';
import 'package:telkom_ticket_manager/utils/router.dart';
import 'package:telkom_ticket_manager/utils/routes.dart';

Navigator localNavigator() => Navigator(
      key: navigationController.navigationKey,
      initialRoute: absencePageRoute,
      onGenerateRoute: generateRoute,
    );
