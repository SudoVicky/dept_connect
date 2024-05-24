import 'package:flutter/material.dart';

class TripleCheckboxTile extends StatelessWidget {
  final String label1;
  final bool value1;
  final ValueChanged<bool?>? onChanged1;
  final String label2;
  final bool value2;
  final ValueChanged<bool?>? onChanged2;
  final String label3;
  final bool value3;
  final ValueChanged<bool?>? onChanged3;

  const TripleCheckboxTile({
    Key? key,
    required this.label1,
    required this.value1,
    required this.onChanged1,
    required this.label2,
    required this.value2,
    required this.onChanged2,
    required this.label3,
    required this.value3,
    required this.onChanged3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
      ),
      child: Row(
        children: [
          Checkbox(
            value: value1,
            onChanged: onChanged1,
            activeColor: Colors.black,
          ),
          Text(label1),
          SizedBox(width: 10), // Add spacing between checkboxes
          Icon(Icons.arrow_right),
          Checkbox(
            value: value2,
            onChanged: onChanged2,
            activeColor: Colors.black,
          ),
          Text(label2),
          SizedBox(width: 10), // Add spacing between checkboxes
          Checkbox(
            value: value3,
            onChanged: onChanged3,
            activeColor: Colors.black,
          ),
          Text(label3),
        ],
      ),
    );
  }
}
