import 'package:flutter/material.dart';

class CustomGridView<T> extends StatelessWidget {
  final List<T> itemList; // List of enum values
  final Set<T> selectedItems; // Set of selected items
  final Function(T) onItemToggle; // Callback to toggle selection
  final String Function(T) itemLabel; // Function to get the label for each item
  final Icon Function(T) itemIcon; // Function to get the icon for each item

  const CustomGridView({
    super.key,
    required this.itemList,
    required this.selectedItems,
    required this.onItemToggle,
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
        final isSelected = selectedItems.any((selected) => selected == item);

        return GestureDetector(
          onTap: () => onItemToggle(item), // Toggle item selection
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: isSelected ? Colors.teal : Colors.teal[100],
            elevation: 3,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconTheme(
                      data: IconThemeData(
                        size: 32,
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                      child: itemIcon(item),
                    ),
                  ),
                  Text(
                    itemLabel(item),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
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
