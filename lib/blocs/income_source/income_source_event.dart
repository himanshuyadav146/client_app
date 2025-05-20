part of 'income_source_bloc.dart';

abstract class IncomeSourceEvent {}

class LoadIncomeSourcesEvent extends IncomeSourceEvent {}

class UpdateSelectionEvent extends IncomeSourceEvent {
  final List<IncomeSource> selectedCategories;
  UpdateSelectionEvent(this.selectedCategories);
}