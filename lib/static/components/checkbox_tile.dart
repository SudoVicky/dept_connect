import 'package:flutter/material.dart';

class CheckboxTile extends StatelessWidget {
  final String label;
  const CheckboxTile({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: false, onChanged: (value) {}),
        Text(label),
      ],
    );
  }
}
