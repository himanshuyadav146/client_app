import 'package:client_app/data/models/income_source/sources.dart';

import '../../../data/models/income_source/source_response.dart';

abstract class IncomeSourceRepository {
  Future<Sources> getIncomeSources();
  Future<void> updateIncomeSources(Set<IncomeSource> selectedCategories);
  Future<SourceResponse> getPersionalInfo(int itrID);

}