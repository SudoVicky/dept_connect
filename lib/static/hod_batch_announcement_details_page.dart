import 'package:dept_connect/presentation/components/announcement_details_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HodBatchAnnouncementDetailsPage extends StatelessWidget {
  const HodBatchAnnouncementDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              iconSize: 30,
              onPressed: () {
                _showOptionsDialog(context);
              },
              icon: Icon(Icons.info),
            ),
          ),
        ],
      ),
      body: AnnouncementDetailsTile(
        title: "Curriculum",
        date: "24 Jan 2024",
        content:
            "Dear students,\nPlease check your new curriculum attached below for the V semester, kindly follow these rules and regulations",
      ),
    );
  }

  void _showOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Send to"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Sec-1"),
                Text("Sec-2"),
                Text("Tutors"),
                Text("Students"),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
