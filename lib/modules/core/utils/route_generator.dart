import 'package:theone/modules/dashboard/view/screen_dashboard.dart';
import 'package:theone/modules/dashboard/view/screen_splash.dart';

import 'core_import.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    printWrapped('\x1B[32m${'Navigating to ----> ${settings.name}'}\x1B[0m');
    switch (settings.name) {
      case AppRoutes.routesSplash:
        return MaterialPageRoute(
            builder: (_) => const ScreenSplash(),
            settings: const RouteSettings(name: AppRoutes.routesSplash));

      case AppRoutes.routesDashboard:
        return MaterialPageRoute(
            builder: (_) => const ScreenDashboard(),
            settings: const RouteSettings(name: AppRoutes.routesDashboard));

      default:
        return MaterialPageRoute(
            builder: (_) => const ScreenSplash(),
            settings: const RouteSettings(name: AppRoutes.routesSplash));
    }
  }

  static String getRouteName(BuildContext context) {
    return ModalRoute.of(context)?.settings.name ?? '';
  }
}
