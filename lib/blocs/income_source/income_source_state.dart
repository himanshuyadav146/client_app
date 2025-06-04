part of 'income_source_bloc.dart';

abstract class IncomeSourceState {}

class IncomeSourceInitialState extends IncomeSourceState {}

class IncomeSourceLoadingState extends IncomeSourceState {}

class IncomeSourceLoadedState extends IncomeSourceState {
  final List<IncomeSource> sources;
  final List<IncomeSource> selectedCategories;
  // final Sources? personalInfo;
  final SourceResponse? personalInfo;
  final String? sourcesError;
  final String? personalInfoError;

  IncomeSourceLoadedState({
    required this.sources,
    this.selectedCategories = const [],
    this.personalInfo,
    this.sourcesError,
    this.personalInfoError,
  });

  IncomeSourceLoadedState copyWith({
    List<IncomeSource>? sources,
    List<IncomeSource>? selectedCategories,
    SourceResponse? personalInfo,
    String? sourcesError,
    String? personalInfoError,
  }) {
    return IncomeSourceLoadedState(
      sources: sources ?? this.sources,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      personalInfo: personalInfo ?? this.personalInfo,
      sourcesError: sourcesError ?? this.sourcesError,
      personalInfoError: personalInfoError ?? this.personalInfoError,
    );
  }
}

class IncomeSourceErrorState extends IncomeSourceState {
  final String message;

  IncomeSourceErrorState(this.message);
}