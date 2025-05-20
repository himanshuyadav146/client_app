import 'package:client_app/core/di/di_container.dart';
import 'package:client_app/data/models/persional_info/persional_info_model.dart';

Future<void> registerModels() async {
  getIt.registerLazySingleton<PersionalInfoModel>(() => PersionalInfoModel(
      firstName: '',
      middleName: '',
      lastName: '',
      pan: '',
      email: '',
      dob: '',
      financialYear: '',
      aadhaar: '',
      source: []));
}
