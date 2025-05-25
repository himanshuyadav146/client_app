import 'package:client_app/core/di/di_container.dart';
import 'package:client_app/data/models/persional_info/persional_info_model.dart';

Future<void> registerModels() async {
  getIt.registerLazySingleton<PersionalInfoModel>(() => PersionalInfoModel(
        financialYear: '',
        firstName: '',
        middleName: '',
        lastName: '',
        email: '',
        userId: '',
        itrId: '',
        mobile: '',
        panNumber: '',
        dateOfBirth: '',
        source: [],
      ));
}
