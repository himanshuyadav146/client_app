import 'package:flutter/material.dart';

class CustomGridView<T> extends StatelessWidget {
  final List<T> itemList; // List of enum values
  final T? selectedItem; // The currently selected item
  final Function(int) onItemSelected; // Callback when an item is selected
  final String Function(T) itemLabel; // Function to get the label for each item
  final Icon Function(T) itemIcon; // Function to get the icon for each item

  const CustomGridView({
    super.key,
    required this.itemList,
    required this.selectedItem,
    required this.onItemSelected,
    required this.itemLabel,
    required this.itemIcon,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
      ),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemList.length,
      itemBuilder: (context, index) {
        final item = itemList[index];
        final isSelected = selectedItem == item;
        return GestureDetector(
          onTap: () => onItemSelected(index), // Pass the index on tap
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: !isSelected ? Colors.teal[100] : Colors.teal,
            elevation: 3,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  itemIcon(item), // Get the icon dynamically
                  Text(
                    itemLabel(item), // Get the label dynamically
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
