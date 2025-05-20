

import '../../../config/app_urls.dart';
import '../../../domain/repositories/persional_info/persional_info_repository.dart';
import '../../models/persional_info/persional_info_model.dart';
import '../../models/persional_info/persional_info_response.dart';
import '../../network/network_service_api.dart';

class PersionalInfoRepositoryImpl implements PersionalInfoRepository {
  final _api = NetworkServiceApi();

  @override
  Future<PersionalInfoModel> getPersionalInfo(data) async {
    final res = await _api.getApi(baseUrl + getIncomeSource);
    return PersionalInfoModel.fromJson(res);
  }

  @override
  Future<PersionalInfoResponse> submitPersionalInfo(
      PersionalInfoModel persionalInfoModel) async {
    final res = await _api.postApi(baseUrl + saveIncomeSource, persionalInfoModel.toJson());
    return PersionalInfoResponse.fromJson(res);
  }
}
