import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  final T value;
  final List<T> items;
  final Widget Function(BuildContext, T) itemBuilder; // Builds each dropdown item
  final ValueChanged<T?> onChanged; // Callback when an item is selected
  final String? hint;

  const CustomDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.itemBuilder,
    required this.onChanged,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      value: value,
      hint: hint != null ? Text(hint!) : null,
      onChanged: onChanged,
      items: items.map((item) {
        return DropdownMenuItem<T>(
          value: item,
          child: itemBuilder(context, item),
        );
      }).toList(),
    );
  }
}
