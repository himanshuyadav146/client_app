abstract class IncomeSourceEvent {}

class ToggleItem extends IncomeSourceEvent {
  final int index;
  ToggleItem(this.index);
}
