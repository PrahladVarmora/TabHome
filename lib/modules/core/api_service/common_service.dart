import 'package:geolocator/geolocator.dart';
import 'package:theone/modules/core/utils/api_import.dart';
import 'package:theone/modules/core/utils/core_import.dart';
import 'package:theone/modules/dashboard/model/model_search_result_list.dart';

///[printWrapped] this function is used to print only in debug mode
void printWrapped(String text) {
  final pattern = RegExp('.{1,800}');
  // ignore: avoid_print
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

///[getNavigatorKeyContext] is used to getting current context
BuildContext getNavigatorKeyContext() {
  return NavigatorKey.navigatorKey.currentContext ??
      NavigatorKey.navigatorKey.currentState!.context;
}

List<SearchResult> getDistanceList() {
  String? data = PreferenceHelper.getString(PreferenceHelper.distance);
  List<SearchResult> jobData = <SearchResult>[];
  if (data != null && data.isNotEmpty) {
    jsonDecode(data).forEach((v) {
      jobData.add(SearchResult.fromJson(v));
    });
  }

  return jobData;
}

void setDistanceList(List<SearchResult> jobData) {
  final data = jobData.map((v) => v.toJson()).toList();
  PreferenceHelper.setString(PreferenceHelper.distance, jsonEncode(data));
  PreferenceHelper.getString(PreferenceHelper.distance);
}

List<SearchResult> getProminenceList() {
  String? data = PreferenceHelper.getString(PreferenceHelper.prominence);
  List<SearchResult> jobData = <SearchResult>[];
  if (data != null && data.isNotEmpty) {
    jsonDecode(data).forEach((v) {
      jobData.add(SearchResult.fromJson(v));
    });
  }

  return jobData;
}

void setProminenceList(List<SearchResult> jobData) {
  final data = jobData.map((v) => v.toJson()).toList();
  PreferenceHelper.setString(PreferenceHelper.prominence, jsonEncode(data));
  PreferenceHelper.getString(PreferenceHelper.prominence);
}

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  /// Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    ToastController.showToast(ValidationString.errorLocationServicesAreDisabled,
        NavigatorKey.navigatorKey.currentContext!, false);
    return Future.error(ValidationString.errorLocationServicesAreDisabled);
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      ToastController.showToast(ValidationString.errorLocationServicesAreDenied,
          NavigatorKey.navigatorKey.currentContext!, false);

      return Future.error(ValidationString.errorLocationServicesAreDenied);
    }
  }

  if (permission == LocationPermission.deniedForever) {
    ToastController.showToast(
        ValidationString.errorLocationServicesArePermanentlyDenied,
        NavigatorKey.navigatorKey.currentContext!,
        false);
    return Future.error(
        ValidationString.errorLocationServicesArePermanentlyDenied);
  }

  Position mPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation);
  if (mPosition.isMocked) {
    ToastController.showToast(
        APPStrings.textFakeLocation, getNavigatorKeyContext(), false,
        okBtnFunction: () {
      Navigator.pop(getNavigatorKeyContext());
      SystemNavigator.pop(animated: true);
    }, barrierDismissible: false);
    return Future.error(APPStrings.textFakeLocation);
  } else {
    return mPosition;
  }
}
