import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/di/di_container.dart';
import '../../data/models/income_source/sources.dart';
import '../../domain/repositories/income_source/income_source_repository.dart';
import '../../services/session_manager/session_manager.dart';

part 'income_source_event.dart';
part 'income_source_state.dart';

class IncomeSourceBloc extends Bloc<IncomeSourceEvent, IncomeSourceState> {
  final IncomeSourceRepository repository;
 // final SessionController sessionController = getIt<SessionController>();

  IncomeSourceBloc(this.repository) : super(IncomeSourceInitialState()) {
    on<LoadIncomeSourcesEvent>(_onLoadIncomeSources);
    on<UpdateSelectionEvent>(_onUpdateIncomeSources);
  }

  // income_source_bloc.dart
  Future<void> _onLoadIncomeSources(
      LoadIncomeSourcesEvent event,
      Emitter<IncomeSourceState> emit,
      ) async {
    emit(IncomeSourceLoadingState());

    List<IncomeSource> sources = [];
    Sources? personalInfo;
    String? sourcesError;
    String? personalInfoError;

    // Load income sources
    try {
      final response = await repository.getIncomeSources();
      sources = response.data ?? [];
    } catch (e) {
      sourcesError = 'Failed to load income sources';
      debugPrint('Income sources error: $e');
    }

    // Load personal info
    try {
      personalInfo = await repository.getPersionalInfo(2);
    } catch (e) {
      personalInfoError = 'Failed to load personal info';
      debugPrint('Personal info error: $e');
    }

    // Get pre-selected categories from personalInfo
    List<IncomeSource> preselected = [];
    if (personalInfo?.data != null) {
      preselected = _getPreselectedCategories(
        sources.isEmpty ? [] : sources ?? [],
        personalInfo!,
      );
    }

    // If both failed, emit error state
    if (sources.isEmpty && personalInfo == null) {
      emit(IncomeSourceErrorState(
          '${sourcesError ?? ''} ${personalInfoError ?? ''}'.trim()
      ));
    }
    // Otherwise emit loaded state with available data
    else {
      emit(IncomeSourceLoadedState(
        sources: sources,
        personalInfo: personalInfo,
        sourcesError: sourcesError,
        personalInfoError: personalInfoError,
        selectedCategories: preselected,
      ));
    }
  }

  Future<void> _onUpdateIncomeSources(
      UpdateSelectionEvent event,
      Emitter<IncomeSourceState> emit,
      ) async {
    if (state is IncomeSourceLoadedState) {
      final currentState = state as IncomeSourceLoadedState;
      emit(currentState.copyWith(
        selectedCategories: event.selectedCategories,
      ));
    }
  }

  List<IncomeSource> _getPreselectedCategories(
      List<IncomeSource> allSources,
      Sources personalInfo,
      ) {
    // Implement logic to match personalInfo with income sources
    // Example: if personalInfo has salary=true, select salary category
    return allSources.where((source) {
      return source.name?.contains('Salary') == true ||
           source.name?.contains('Business') == true ||
          source.name?.contains('Property') == true;
    }).toList();
}
}