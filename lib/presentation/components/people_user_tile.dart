import 'package:flutter/material.dart';

class PeopleUserTile extends StatelessWidget {
  final String title;
  const PeopleUserTile({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
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
            title,
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }
}
