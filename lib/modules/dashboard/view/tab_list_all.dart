// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:geolocator/geolocator.dart';
import 'package:theone/modules/core/utils/core_import.dart';
import 'package:theone/modules/dashboard/bloc/search_result_list/search_result_list_bloc.dart';
import 'package:theone/modules/dashboard/model/model_search_result_list.dart';
import 'package:theone/modules/dashboard/view/widget/row_location_item.dart';

class TabHome extends StatefulWidget {
  final int index;

  const TabHome({super.key, required this.index});

  @override
  State<TabHome> createState() => _TabHomeState();
}

class _TabHomeState extends State<TabHome> {
  ValueNotifier<bool> mLoading = ValueNotifier(false);
  late Position mPosition;
  final ScrollController _scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  ValueNotifier<List<SearchResult>> mSearchResultList = ValueNotifier([]);
  OutlineInputBorder mOutlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(Dimens.margin12),
    borderSide: const BorderSide(width: Dimens.margin1),
  );

  @override
  void initState() {
    if (mSearchResultList.value.isEmpty) {
      mSearchResultList.value =
          widget.index == 0 ? getDistanceList() : getProminenceList();
    }
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiValueListenableBuilder(
        valueListenables: [
          mLoading,
          mSearchResultList,
        ],
        builder: (context, values, child) {
          return ModalProgressHUD(
            inAsyncCall: mLoading.value,
            child: BlocListener<SearchResultListBloc, SearchResultListState>(
              listener: (context, state) {
                if (searchController.text.isEmpty &&
                    mSearchResultList.value.isEmpty) {
                  mLoading.value = state is SearchResultListLoading;
                }

                if (state is SearchResultListResponse) {
                  mSearchResultList.value =
                      state.mModelSearchResultList.searchResults ?? [];

                  if (widget.index == 0) {
                    setDistanceList(mSearchResultList.value);
                  } else {
                    setProminenceList(mSearchResultList.value);
                  }
                  mLoading.value = false;
                }
              },
              child: Container(
                padding: const EdgeInsets.all(Dimens.margin16),
                child: Column(
                  children: [
                    TextField(
                      controller: searchController,
                      onChanged: (val) {
                        geSearchResultListEvent();
                      },
                      decoration: InputDecoration(
                        hintText: "Search....",
                        contentPadding: const EdgeInsets.all(Dimens.margin15),
                        enabledBorder: mOutlineInputBorder,
                        focusedBorder: mOutlineInputBorder,
                        disabledBorder: mOutlineInputBorder,
                        border: mOutlineInputBorder,
                      ),
                    ),
                    const SizedBox(height: Dimens.margin10),
                    Expanded(
                      child: ListView.separated(
                        controller: _scrollController,
                        itemCount: mSearchResultList.value.length,
                        itemBuilder: (context, index) {
                          return RowUserItem(
                              mSearchResult: mSearchResultList.value[index]);
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: Dimens.margin10);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void initData() async {
    try {
      mLoading.value = true;
      await determinePosition().then((value) {
        mPosition = value;
        geSearchResultListEvent();
      }).onError((error, stackTrace) {
        printWrapped('error----$error');
        SystemNavigator.pop();
        // exit(0);
      });
    } catch (e) {
      printWrapped('catch----$e');
      SystemNavigator.pop();
      // exit(0);
    }
  }

  void geSearchResultListEvent() async {
    String url = AppUrls.apiResults.interpolate([
      "${mPosition.latitude},${mPosition.longitude}",
      widget.index == 0 ? ApiParams.paramDistance : ApiParams.paramProminence,
      AppConfig.apiKey
    ]);
    if (widget.index == 1) {
      url += "&${ApiParams.paramRadius}=500";
    }

    if (searchController.text.isNotEmpty) {
      url += "&${ApiParams.paramKeyword}=${searchController.text}";
    }
    BlocProvider.of<SearchResultListBloc>(getNavigatorKeyContext())
        .add(GetSearchResultList(
      url: url,
    ));
  }
}
