import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dept_connect/bloc/hod_bloc/announcement_page_blocs/announcement_check_box_bloc/check_box_bloc.dart';
import 'package:dept_connect/bloc/hod_bloc/announcement_page_blocs/announcement_check_box_bloc/check_box_event.dart';
import 'package:dept_connect/bloc/hod_bloc/announcement_page_blocs/announcement_send_bloc/announcement_bloc.dart';
import 'package:dept_connect/bloc/hod_bloc/announcement_page_blocs/announcement_send_bloc/announcement_event.dart';
import 'package:dept_connect/bloc/hod_bloc/announcement_page_blocs/file_upload_bloc/file_upload_bloc.dart';
import 'package:dept_connect/bloc/hod_bloc/announcement_page_blocs/file_upload_bloc/file_upload_event.dart';
import 'package:dept_connect/bloc/hod_bloc/stream_page_blocs/message_show_bloc/message_show_bloc.dart';
import 'package:dept_connect/bloc/hod_bloc/stream_page_blocs/message_show_bloc/message_show_event.dart';
import 'package:dept_connect/bloc/hod_bloc/stream_page_blocs/message_show_bloc/message_show_state.dart';
import 'package:dept_connect/consts/date_to_display_format.dart';
import 'package:dept_connect/presentation/components/message_tile.dart';
import 'package:dept_connect/presentation/components/stream_announce_tile.dart';
import 'package:dept_connect/presentation/components/stream_tile.dart';
import 'package:dept_connect/presentation/screens/faculty/hod/hod_batch_announcement_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HodBatchStreamPage extends StatefulWidget {
  final String dept;
  final String batchId;
  final int semesterNo;
  final String year;
  const HodBatchStreamPage({
    super.key,
    required this.batchId,
    required this.semesterNo,
    required this.year,
    required this.dept,
  });

  @override
  State<HodBatchStreamPage> createState() => _HodBatchStreamPageState();
}

class _HodBatchStreamPageState extends State<HodBatchStreamPage> {
  late MessageBloc _messageBloc;

  @override
  void initState() {
    super.initState();
    _messageBloc =
        MessageBloc(FirebaseFirestore.instance, widget.dept, widget.batchId);
    _messageBloc.add(LoadMessagesEvent());
  }

  @override
  void dispose() {
    _messageBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final initialCheckBoxes = [
      {"name": "all", "isChecked": false},
      {"name": "teachers", "isChecked": false},
      {"name": "tSec1", "isChecked": false},
      {"name": "tSec2", "isChecked": false},
      {"name": "students", "isChecked": false},
      {"name": "sSec1", "isChecked": false},
      {"name": "sSec2", "isChecked": false},
      {"name": "parents", "isChecked": false},
      {"name": "pSec1", "isChecked": false},
      {"name": "pSec2", "isChecked": false},
      {"name": "seniorTutor", "isChecked": false}
    ];

    return BlocBuilder<MessageBloc, MessagesState>(
      builder: (context, state) {
        if (state is MessageLoadingState) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.black),
          );
        } else if (state is MessageLoadedState) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: StreamTile(
                    title: widget.batchId,
                    subtitle: "${widget.semesterNo} Sem, ${widget.year} Year"),
              ),
              SliverToBoxAdapter(
                child: StreamAnnounceTile(
                  title: "Announce Something to your batch",
                  onTap: () {
                    BlocProvider.of<CheckBoxBloc>(context).add(
                        CheckBoxInitialEvent(checkboxes: initialCheckBoxes));
                    BlocProvider.of<AnnouncementBloc>(context)
                        .add(AnnouncementInitialEvent());
                    BlocProvider.of<FilePickBloc>(context)
                        .add(FilePickInitialEvent());
                    Navigator.pushNamed(context, "/hod_batch_announcement_page",
                        arguments: {
                          "dept": widget.dept,
                          "batchId": widget.batchId,
                        });
                  },
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final announcementMessage = state.messages[index];
                    return MessageTile(
                      dept: widget.dept,
                      batchId: widget.batchId,
                      title: announcementMessage.title,
                      date: announcementMessage.timestamp,
                      editedDate: announcementMessage.editedTimestamp,
                      content: announcementMessage.content,
                      id: announcementMessage.id,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HodBatchAnnouncementDetailsPage(
                              dept: widget.dept,
                              batchId: widget.batchId,
                              title: announcementMessage.title,
                              content: announcementMessage.content,
                              sender: announcementMessage.sender,
                              toWhom: announcementMessage.toWhom,
                              fileInfo: announcementMessage.fileInfo,
                              timestamp: DateToDisplayFormat().formattedDate(
                                  announcementMessage.timestamp,
                                  announcementMessage.editedTimestamp),
                              id: announcementMessage.id,
                            ),
                          ),
                        );
                        print(
                            "Vicky announcementId : ${announcementMessage.id}");
                      },
                      attachmentFiles: announcementMessage.fileInfo,
                      toWhom: announcementMessage.toWhom,
                    );
                  },
                  childCount: state.messages.length,
                ),
              ),
            ],
          );
        } else if (state is MessageErrorState) {
          return Center(
            child: Text('Error: ${state.error}'),
          );
        }
        return const Center(
          child: Text('No messages available'),
        );
      },
    );
  }
}
