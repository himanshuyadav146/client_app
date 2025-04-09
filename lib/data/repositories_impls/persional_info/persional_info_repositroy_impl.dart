import 'package:client_app/data/models/persional_info/persional_info.dart';

import '../../../config/app_urls.dart';
import '../../../domain/repositories/persional_info/persional_info_repository.dart';
import '../../network/network_service_api.dart';

class PersionalInfoRepositoryImpl implements PersionalInfoRepository {
  final _api = NetworkServiceApi();

  @override
  Future<PersionalInfoModel> getPersionalInfo(data) async {
    final res = await _api.getApi(baseUrl + sendOTPUrl);
    return PersionalInfoModel.fromJson(res);
  }

  @override
  Future<PersionalInfoModel> submitPersionalInfo(
      PersionalInfoModel persionalInfoModel) async {
    final res = await _api.getApi(baseUrl + sendOTPUrl);
    return PersionalInfoModel.fromJson(res);
  }
}
