import 'dart:convert';

import 'package:client_app/data/models/income_source/sources.dart';

import '../../../config/app_urls.dart';
import '../../../domain/repositories/income_source/income_source_repository.dart';
import '../../models/income_source/source_response.dart';
import '../../network/network_service_api.dart';

class IncomeSourceRepositoryImpl implements IncomeSourceRepository {
  final _api = NetworkServiceApi();

  @override
  Future<Sources> getIncomeSources() async {
   final res = await _api.getApi(baseUrl + getIncomeSource );
    return Sources.fromJson(res);
  }

  @override
  Future<void> updateIncomeSources(Set<IncomeSource> selectedCategories) async {

  }

  @override
  Future<SourceResponse> getPersionalInfo(int itrId) async {
    final params = {'itrId': itrId.toString()};
    final res = await _api.getApi(baseUrl + getPersionalInfoURL,
        queryParameters: params );
    return SourceResponse.fromJson(res);
  }

  // @override
  // Future<ItrResponse> getItrById(int itrId) async {
  //   final params = {'itrId': itrId.toString()};
  //   final res = await _api.getApi(baseUrl + getPersionalInfo,
  //       queryParameters: params);
  //   return ItrResponse.fromJson(res);
  // }

}

final dummyResponse = '''
{
  "status": "success",
  "data": [
    {
      "Id": "1",
      "Name": "Salary\/Pension",
      "CreatedAt": "2025-03-12 14:09:24",
      "UpdatedAt": "0000-00-00 00:00:00"
    },
    {
      "Id": "2",
      "Name": "House Property",
      "CreatedAt": "2025-03-12 14:23:04",
      "UpdatedAt": "0000-00-00 00:00:00"
    },
    {
      "Id": "3",
      "Name": "Business\/Proffession",
      "CreatedAt": "2025-03-12 18:18:00",
      "UpdatedAt": "0000-00-00 00:00:00"
    },
    {
      "Id": "4",
      "Name": "Capital Gains",
      "CreatedAt": "2025-03-12 18:39:49",
      "UpdatedAt": "0000-00-00 00:00:00"
    },
    {
      "Id": "5",
      "Name": "Other Sources",
      "CreatedAt": "2025-03-12 18:40:10",
      "UpdatedAt": "0000-00-00 00:00:00"
    },
    {
      "Id": "6",
      "Name": "Foreign Income",
      "CreatedAt": "2025-03-12 18:40:55",
      "UpdatedAt": "0000-00-00 00:00:00"
    }
  ]
}
''';