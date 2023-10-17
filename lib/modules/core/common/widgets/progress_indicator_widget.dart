import 'package:theone/modules/core/utils/core_import.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  const ProgressIndicatorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(
          Theme.of(context).colorScheme.background),
    );
  }
}
