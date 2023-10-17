import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:theone/bloc_generator.dart';
import 'package:theone/modules/core/utils/core_import.dart';

import 'modules/core/utils/api_import.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ApiProvider apiProvider = ApiProvider();
  http.Client client = http.Client();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: BlocGenerator.generateBloc(apiProvider, client),
      child: MaterialApp(
        title: APPStrings.appName,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            progressIndicatorTheme:
                const ProgressIndicatorThemeData(color: Colors.deepPurple),
            useMaterial3: true),
        onGenerateRoute: RouteGenerator.generateRoute,
        navigatorKey: NavigatorKey.navigatorKey,
      ),
    );
  }
}
