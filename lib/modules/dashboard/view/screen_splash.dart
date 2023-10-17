import 'package:theone/modules/core/utils/core_import.dart';

class ScreenSplash extends StatelessWidget {
  const ScreenSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          Future.delayed(const Duration(milliseconds: 500)).whenComplete(() {
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.routesDashboard, (route) => false);
      }),
      builder: (context, snapshot) {
        return Scaffold(
          body: Center(
            child: Image.asset(APPImages.icLogo),
          ),
        );
      },
    );
  }
}
