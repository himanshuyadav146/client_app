

import '../../../data/models/persional_info/persional_info_model.dart';

abstract class PersionalInfoRepository{
  Future<PersionalInfoModel> getPersionalInfo(dynamic data);
  Future<PersionalInfoModel> submitPersionalInfo(PersionalInfoModel persionalInfoModel);
}