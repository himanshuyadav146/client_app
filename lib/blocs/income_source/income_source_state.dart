part of 'income_source_bloc.dart';

abstract class IncomeSourceState {}

class IncomeSourceInitialState extends IncomeSourceState {}

class IncomeSourceLoadingState extends IncomeSourceState {}

class IncomeSourceLoadedState extends IncomeSourceState {
  final Sources sources;
  final Set<Data> selectedCategories;

  IncomeSourceLoadedState({
    required this.sources,
    this.selectedCategories = const {},
  });
}

class IncomeSourceErrorState extends IncomeSourceState {
  final String message;

  IncomeSourceErrorState(this.message);
}