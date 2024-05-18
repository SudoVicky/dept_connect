import 'package:dept_connect/presentation/components/section_tile.dart';
import 'package:flutter/material.dart';

class HodBatchPeoplePage extends StatelessWidget {
  const HodBatchPeoplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTile(
          title: "Sec - 1",
          onTap: () {
            Navigator.pushNamed(context, "/hod_batch_people_section");
          },
        ),
        SectionTile(
            title: "Sec - 2",
            onTap: () {
              Navigator.pushNamed(context, "/hod_batch_people_section");
            }),
      ],
    );
  }
}
