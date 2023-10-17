import 'package:theone/modules/core/utils/core_import.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceHelper.load();
  runApp(const MyApp());
}
