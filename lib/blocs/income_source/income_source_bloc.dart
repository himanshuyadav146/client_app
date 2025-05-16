import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/income_source/sources.dart';
import '../../domain/repositories/income_source/income_source_repository.dart';

part 'income_source_event.dart';
part 'income_source_state.dart';

class IncomeSourceBloc extends Bloc<IncomeSourceEvent, IncomeSourceState> {
  final IncomeSourceRepository repository;

  IncomeSourceBloc(this.repository) : super(IncomeSourceInitialState()) {
    on<LoadIncomeSourcesEvent>(_onLoadIncomeSources);
    on<UpdateSelectionEvent>(_onUpdateIncomeSources);
  }

  Future<void> _onLoadIncomeSources(
      LoadIncomeSourcesEvent event,
      Emitter<IncomeSourceState> emit,
      ) async {
    emit(IncomeSourceLoadingState());
    try {
      final sources = await repository.getIncomeSources();
      emit(IncomeSourceLoadedState(sources: sources));
    } catch (e) {
      emit(IncomeSourceErrorState('Failed to load income sources: $e'));
    }
  }

  Future<void> _onUpdateIncomeSources(
      UpdateSelectionEvent event,
      Emitter<IncomeSourceState> emit,
      ) async {
    if (state is IncomeSourceLoadedState) {
      final currentState = state as IncomeSourceLoadedState;
      emit(IncomeSourceLoadedState(
        sources: currentState.sources,
        selectedCategories: event.selectedCategories,
      ));
    }
  }
}