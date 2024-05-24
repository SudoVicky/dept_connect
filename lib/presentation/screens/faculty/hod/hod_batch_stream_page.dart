import 'package:dept_connect/presentation/components/message_tile.dart';
import 'package:dept_connect/presentation/components/stream_announce_tile.dart';
import 'package:dept_connect/presentation/components/stream_tile.dart';
import 'package:flutter/material.dart';

class HodBatchStreamPage extends StatelessWidget {
  final String batchId;
  final int semesterNo;
  final String year;
  const HodBatchStreamPage(
      {super.key,
      required this.batchId,
      required this.semesterNo,
      required this.year});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: StreamTile(
              title: "$batchId batch",
              subtitle: "$semesterNo Sem, $year year",
            ),
          ),
          SliverToBoxAdapter(
            child: StreamAnnounceTile(
              title: " Announce Something to your batch",
              onTap: () {
                Navigator.pushNamed(context, "/hod_batch_announcement_page");
              },
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return MessageTile(
                  title: "Lab Feedback Form",
                  date: "13 Jan 2024",
                  content:
                      "Dear Students,\nPlease take a moment to provide your honest fee...",
                  onTap: () {
                    print("clicked");
                    Navigator.pushNamed(
                        context, "/hod_batch_announcement_details_page");
                  },
                );
              },
              childCount: 5,
            ),
          ),
        ],
      ),
    );
  }
}
