import 'package:theone/modules/core/utils/core_import.dart';
import 'package:theone/modules/dashboard/view/tab_list_all.dart';

class ScreenDashboard extends StatefulWidget {
  const ScreenDashboard({super.key});

  @override
  State<ScreenDashboard> createState() => _ScreenDashboardState();
}

class _ScreenDashboardState extends State<ScreenDashboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(APPStrings.appName)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: APPStrings.textDistance),
              Tab(text: APPStrings.textProminence),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                TabHome(index: 0),
                TabHome(index: 1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
