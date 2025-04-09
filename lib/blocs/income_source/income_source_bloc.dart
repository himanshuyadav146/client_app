import 'package:flutter_bloc/flutter_bloc.dart';
import 'income_source_event.dart';
import 'income_source_state.dart';

class IncomeSourceBloc extends Bloc<IncomeSourceEvent, IncomeSourceState> {
  IncomeSourceBloc() : super(IncomeSourceState(selectedItems: List.filled(6, false))) {
    on<ToggleItem>((event, emit) {
      final updatedSelection = List<bool>.from(state.selectedItems);
      updatedSelection[event.index] = !updatedSelection[event.index];
      emit(state.copyWith(selectedItems: updatedSelection));
    });
  }
}
