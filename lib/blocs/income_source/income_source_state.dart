part of 'income_source_bloc.dart';

abstract class IncomeSourceState {}

class IncomeSourceInitialState extends IncomeSourceState {}

class IncomeSourceLoadingState extends IncomeSourceState {}

class IncomeSourceLoadedState extends IncomeSourceState {
  final List<IncomeSource> sources;
  final List<IncomeSource> selectedCategories;

  IncomeSourceLoadedState({
    required this.sources,
    this.selectedCategories = const [],
  });

  IncomeSourceLoadedState copyWith({
    List<IncomeSource>? sources,
    List<IncomeSource>? selectedCategories,
  }) {
    return IncomeSourceLoadedState(
      sources: sources ?? this.sources,
      selectedCategories: selectedCategories ?? this.selectedCategories,
    );
  }
}

class IncomeSourceErrorState extends IncomeSourceState {
  final String message;

  IncomeSourceErrorState(this.message);
}