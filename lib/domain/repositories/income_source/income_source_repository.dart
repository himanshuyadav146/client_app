import 'package:client_app/data/models/income_source/sources.dart';

abstract class IncomeSourceRepository {
  Future<Sources> getIncomeSources();
  Future<void> updateIncomeSources(Set<Data> selectedCategories);
}