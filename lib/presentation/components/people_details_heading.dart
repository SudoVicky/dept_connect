import 'package:flutter/material.dart';

class PeopleDetailsHeading extends StatelessWidget {
  final String title;
  const PeopleDetailsHeading({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
