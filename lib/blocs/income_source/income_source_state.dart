class IncomeSourceState {
  final List<bool> selectedItems;

  IncomeSourceState({required this.selectedItems});

  IncomeSourceState copyWith({List<bool>? selectedItems}) {
    return IncomeSourceState(selectedItems: selectedItems ?? this.selectedItems);
  }
}
