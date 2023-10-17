import 'package:http/http.dart' as http;
import 'package:theone/modules/core/utils/api_import.dart';
import 'package:theone/modules/core/utils/core_import.dart';
import 'package:theone/modules/dashboard/bloc/search_result_list/search_result_list_bloc.dart';
import 'package:theone/modules/dashboard/repository/repository_search_result_list.dart';

class BlocGenerator {
  static generateBloc(
    ApiProvider apiProvider,
    http.Client client,
  ) {
    return [
      BlocProvider<SearchResultListBloc>(
        create: (BuildContext context) => SearchResultListBloc(
            apiProvider: apiProvider,
            client: client,
            repository: RepositorySearchResultList()),
      ),
    ];
  }
}
