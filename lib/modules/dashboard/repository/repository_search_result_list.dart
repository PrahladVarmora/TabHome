import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:theone/modules/core/common/model/model_common_api_message.dart';
import 'package:theone/modules/core/utils/api_import.dart';
import 'package:theone/modules/dashboard/model/model_search_result_list.dart';

class RepositorySearchResultList {
  static final RepositorySearchResultList _repository =
      RepositorySearchResultList._internal();

  factory RepositorySearchResultList() {
    return _repository;
  }

  RepositorySearchResultList._internal();

  Future<Either<ModelSearchResultList, ModelCommonAPIMessage>>
      callSearchResultListApi(
          String url, ApiProvider mApiProvider, http.Client client) async {
    Either<dynamic, ModelCommonAPIMessage> response =
        await mApiProvider.callGetMethod(
      client,
      url,
      {},
    );
    return response.fold(
      (success) {
        try {
          ModelSearchResultList result =
              ModelSearchResultList.fromJson(jsonDecode(success));
          return left(result);
        } catch (e) {
          return right(ModelCommonAPIMessage(message: e.toString()));
        }
      },
      (error) => right(error),
    );
  }
}
