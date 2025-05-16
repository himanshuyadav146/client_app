

import '../../../data/models/persional_info/persional_info_model.dart';
import '../../../data/models/persional_info/persional_info_response.dart';

abstract class PersionalInfoRepository{
  Future<PersionalInfoModel> getPersionalInfo(dynamic data);
  Future<PersionalInfoResponse> submitPersionalInfo(PersionalInfoModel persionalInfoModel);
}