import 'dart:io';

import 'package:dept_connect/bloc/hod_bloc/announcement_details_full_screen_blocs/ToWhomCubit/to_whom_cubit.dart';
import 'package:dept_connect/bloc/hod_bloc/announcement_details_full_screen_blocs/file_download_bloc/file_download_bloc.dart';
import 'package:dept_connect/bloc/hod_bloc/announcement_details_full_screen_blocs/file_download_bloc/file_download_event.dart';
import 'package:dept_connect/bloc/hod_bloc/announcement_details_full_screen_blocs/file_download_bloc/file_download_state.dart';
import 'package:dept_connect/bloc/hod_bloc/announcement_page_blocs/announcement_check_box_bloc/check_box_bloc.dart';
import 'package:dept_connect/bloc/hod_bloc/announcement_page_blocs/announcement_check_box_bloc/check_box_event.dart';
import 'package:dept_connect/bloc/hod_bloc/announcement_page_blocs/announcement_send_bloc/announcement_bloc.dart';
import 'package:dept_connect/bloc/hod_bloc/announcement_page_blocs/announcement_send_bloc/announcement_event.dart';
import 'package:dept_connect/bloc/hod_bloc/stream_page_blocs/message_remove_bloc/message_remove_bloc.dart';
import 'package:dept_connect/bloc/hod_bloc/stream_page_blocs/message_remove_bloc/message_remove_event.dart';
import 'package:dept_connect/consts/empty_checkbox_container.dart';
import 'package:dept_connect/consts/file_diplay_name.dart';
import 'package:dept_connect/consts/file_icon_choose.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:open_file/open_file.dart';

class HodBatchAnnouncementDetailsPage extends StatelessWidget {
  final String dept;
  final String batchId;
  final String id;
  final String title;
  final String content;
  final String sender;
  final List<dynamic> toWhom;
  final List<Map<String, dynamic>> fileInfo;
  final String timestamp;

  const HodBatchAnnouncementDetailsPage({
    super.key,
    required this.dept,
    required this.batchId,
    required this.title,
    required this.content,
    required this.sender,
    required this.toWhom,
    required this.fileInfo,
    required this.timestamp,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildContent(context),
          BlocBuilder<ToWhomOverlayCubit, bool>(
            builder: (context, showOverlay) {
              if (showOverlay) {
                return _buildToWhomOverlay(context);
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final checkBoxes = [
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
    return Column(
      children: [
        AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(''),
          actions: [
            TextButton(
              onPressed: () {
                context.read<ToWhomOverlayCubit>().showOverlay();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.all(8),
                child: const Row(
                  children: [
                    Text(
                      ' To Whom',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            Theme(
              data: Theme.of(context).copyWith(
                popupMenuTheme: const PopupMenuThemeData(),
              ),
              child: PopupMenuButton<String>(
                itemBuilder: (context) => [
                  PopupMenuItem<String>(
                    value: "edit",
                    child: Container(
                      width: 200,
                      child: Text("Edit"),
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: "delete",
                    child: Container(
                      width: 200,
                      child: Text("Delete"),
                    ),
                  ),
                ],
                onSelected: (String value) {
                  if (value == "edit") {
                    BlocProvider.of<AnnouncementBloc>(context)
                        .add(DetailsPageEditEvent(isDetailsPageEdit: true));
                    BlocProvider.of<AnnouncementBloc>(context).add(
                        AnnouncementEditEvent(
                            announcementMessage: content,
                            titleMessage: title,
                            id: id));
                    List<Map<String, dynamic>> previousCheckBoxes =
                        List<Map<String, dynamic>>.from(checkBoxes);
                    bool checkForAll = toWhom.contains("all");

                    if (checkForAll) {
                      previousCheckBoxes[0]["isChecked"] = true;
                    }
                    // Process toWhom to set initial checkboxes
                    for (dynamic recipient in toWhom) {
                      switch (recipient) {
                        case "teachers":
                          previousCheckBoxes[1]["isChecked"] = true;
                          break;
                        case "tSec1":
                          previousCheckBoxes[2]["isChecked"] = true;
                          break;
                        case "tSec2":
                          previousCheckBoxes[3]["isChecked"] = true;
                          break;
                        case "students":
                          previousCheckBoxes[4]["isChecked"] = true;
                          break;
                        case "sSec1":
                          previousCheckBoxes[5]["isChecked"] = true;
                          break;
                        case "sSec2":
                          previousCheckBoxes[6]["isChecked"] = true;
                          break;
                        case "parents":
                          previousCheckBoxes[7]["isChecked"] = true;
                          break;
                        case "pSec1":
                          previousCheckBoxes[8]["isChecked"] = true;
                          break;
                        case "pSec2":
                          previousCheckBoxes[9]["isChecked"] = true;
                          break;
                        case "seniorTutor":
                          previousCheckBoxes[10]["isChecked"] = true;
                          break;
                      }
                    }

                    // Set areStudentsChecked and areParentsChecked based on toWhom
                    bool areTeachersChecked = toWhom.contains("teachers");
                    bool areStudentsChecked = toWhom.contains("students");
                    bool areParentsChecked = toWhom.contains("parents");
                    bool isAllChecked = toWhom.contains("all");

                    BlocProvider.of<CheckBoxBloc>(context).add(
                      CheckBoxEditInitialEvent(
                        previousCheckBoxes: previousCheckBoxes,
                        areParentsChecked: areParentsChecked,
                        areStudentsChecked: areStudentsChecked,
                        areTeachersChecked: areTeachersChecked,
                        isAllChecked: isAllChecked,
                      ),
                    );
                    Navigator.pushNamed(
                        context, "/hod_batch_announcement_page");
                    print("Edit tapped");
                  } else if (value == "delete") {
                    _showDeleteConfirmationDialog(context);
                  }
                },
                icon: Icon(Icons.more_vert),
              ),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Image.asset(
                        'lib/assets/icons/document.png',
                        width: 32,
                        height: 32,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          timestamp,
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(),
                const SizedBox(height: 13),
                Text(
                  content,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 15),
                const Divider(),
                const SizedBox(height: 13),
                const Text(
                  'Attachments:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: BlocBuilder<FileDownloadBloc, FileDownloadState>(
                    builder: (context, state) {
                      return ListView.builder(
                        itemCount: fileInfo.length,
                        itemBuilder: (context, index) {
                          final file = fileInfo[index];
                          final fileName = file['fileName'] ?? 'Unknown';
                          final extension = fileName.split('.').last;
                          final iconData = FileIconChoose().getIcon(extension);
                          final downloadUrl = file['downloadUrl'] ??
                              'https://via.placeholder.com/150';

                          return GestureDetector(
                            onTap: () async {
                              final filePath = fileInfo[index]['filePath'];
                              final file = File(filePath);

                              if (await file.exists()) {
                                OpenFile.open(filePath);
                              } else {
                                Fluttertoast.showToast(
                                  msg: "File does not exist",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                );
                              }
                            },
                            child: Container(
                              width: 320.0,
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              margin: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      'lib/assets/icons/$iconData.png',
                                      width: 22,
                                      height: 22,
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 8,
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: fileName.length > 15
                                                ? FileNameDisplay(
                                                    fileName: fileName,
                                                    maxWidth: 200,
                                                  )
                                                : Text(
                                                    fileName,
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: GestureDetector(
                                            onTap: () {
                                              BlocProvider.of<FileDownloadBloc>(
                                                      context)
                                                  .add(
                                                StartDownloadEvent(
                                                  url: downloadUrl,
                                                  fileName: fileName,
                                                  index: index,
                                                  id: id,
                                                ),
                                              );
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: _buildDownloadIcon(
                                                  state, index),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDownloadIcon(FileDownloadState state, int index) {
    if (state is FileDownloadingState && state.currentIndex == index) {
      return Transform.scale(
        scale: 0.5,
        child: const CircularProgressIndicator(color: Colors.black),
      );
    } else if (state is FileDownloadCompletedState &&
        state.completedIndex == index) {
      fileInfo[state.completedIndex]['filePath'] = state.filePath;
      return const Icon(Icons.check_circle, color: Colors.green, size: 23);
    } else if (fileInfo[index]['filePath'] != null &&
        File(fileInfo[index]['filePath']).existsSync()) {
      return const Icon(Icons.check_circle, color: Colors.green, size: 23);
    } else {
      return const Icon(Icons.download, color: Colors.black, size: 23);
    }
  }

  Widget _buildToWhomOverlay(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      bottom: 0,
      child: Container(
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: Container(
            width: 320,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        BlocProvider.of<ToWhomOverlayCubit>(context)
                            .hideOverlay();
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 65.0),
                        child: Text(
                          'To Whom',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                EmptyCheckBoxContainer(checkedBoxes: toWhom)
                    .buildCheckBoxes(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Message"),
          content: const Text("Are you sure you want to delete this message?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                BlocProvider.of<MessageRemoveBloc>(context).add(
                    RemoveMessageEvent(dept: dept, batchId: batchId, id: id));
                Navigator.pop(context);
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    ).then((confirmed) {
      if (confirmed != null && confirmed) {
        // Trigger the delete event
      }
    });
  }
}
