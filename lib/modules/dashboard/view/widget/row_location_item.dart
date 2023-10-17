import 'package:maps_launcher/maps_launcher.dart';
import 'package:theone/modules/core/utils/core_import.dart';
import 'package:theone/modules/dashboard/model/model_search_result_list.dart';

class RowUserItem extends StatelessWidget {
  final SearchResult mSearchResult;

  const RowUserItem({super.key, required this.mSearchResult});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (mSearchResult.geometry?.location?.lat != null &&
            mSearchResult.geometry?.location?.lng != null) {
          MapsLauncher.launchCoordinates(
              mSearchResult.geometry?.location?.lat ?? 0,
              mSearchResult.geometry?.location?.lng ?? 0);
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleImageViewerNetwork(
            url: mSearchResult.icon ?? '',
            mHeight: 50,
          ),
          const SizedBox(width: Dimens.margin10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(mSearchResult.name ?? ''),
                Text(mSearchResult.vicinity ?? ''),
                Text(mSearchResult.businessStatus ?? ''),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
