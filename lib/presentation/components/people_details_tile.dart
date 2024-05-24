import 'package:flutter/material.dart';

class PeopleDetailsTile extends StatelessWidget {
  final List<String> studentNames;

  const PeopleDetailsTile({super.key, required this.studentNames});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[100],
                    child: Icon(
                      Icons.person_rounded,
                      size: 30,
                    ),
                  ),
                ),
                Text(
                  studentNames[index],
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          );
        },
        childCount: studentNames.length,
      ),
    );
  }
}
