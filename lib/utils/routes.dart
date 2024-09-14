const rootRoute = "/dashboard";

const overviewPageDisplayName = "Overview";
const overviewPageRoute = "/overview";

const adminPageDisplayName = "Admin";
const adminPageRoute = "/admin";

const teknisiPageDisplayName = "Teknisi";
const teknisiPageRoute = "/teknisi";

const clientPageDisplayName = "Client";
const clientPageRoute = "/client";

const authenticationPageDisplayName = "Log Out";
const authenticationPageRoute = "/auth";

class MenuItem {
  final String name;
  final String route;

  MenuItem({required this.name, required this.route});
}

List<MenuItem> sideMenuItems = [
  MenuItem(
    name: overviewPageDisplayName,
    route: overviewPageRoute,
  ),
  MenuItem(
    name: adminPageDisplayName,
    route: adminPageRoute,
  ),
  MenuItem(
    name: teknisiPageDisplayName,
    route: teknisiPageRoute,
  ),
  MenuItem(
    name: clientPageDisplayName,
    route: clientPageRoute,
  ),
  MenuItem(
    name: authenticationPageDisplayName,
    route: authenticationPageRoute,
  ),
];
