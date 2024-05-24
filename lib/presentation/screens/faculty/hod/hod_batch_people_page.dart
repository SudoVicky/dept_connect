import 'package:dept_connect/presentation/components/section_tile.dart';
import 'package:flutter/material.dart';

class HodBatchPeoplePage extends StatelessWidget {
  final String dept;
  final String batchId;
  const HodBatchPeoplePage(
      {super.key, required this.dept, required this.batchId});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTile(
          title: "Sec - 1",
          onTap: () {
            Navigator.pushNamed(
              context,
              "/hod_batch_people_section",
              arguments: {"dept": dept, "batchId": batchId, "section": "1"},
            );
          },
        ),
        SectionTile(
            title: "Sec - 2",
            onTap: () {
              Navigator.pushNamed(
                context,
                "/hod_batch_people_section",
                arguments: {"section": "2"},
              );
            }),
      ],
    );
  }
}
