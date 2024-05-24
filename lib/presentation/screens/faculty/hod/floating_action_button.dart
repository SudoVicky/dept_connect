import 'package:dept_connect/bloc/hod_bloc/announcement_page_blocs/announcement_check_box_bloc/check_box_bloc.dart';
import 'package:dept_connect/bloc/hod_bloc/announcement_page_blocs/announcement_send_bloc/announcement_bloc.dart';
import 'package:dept_connect/bloc/hod_bloc/announcement_page_blocs/announcement_send_bloc/announcement_event.dart';
import 'package:dept_connect/bloc/hod_bloc/announcement_page_blocs/file_upload_bloc/file_upload_bloc.dart';
import 'package:dept_connect/utils/snack_bar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FloatingActionButtons {
  FloatingActionButton buildFloatingActionButton(
      BuildContext context,
      String dept,
      String batchId,
      TextEditingController announcementMessage,
      TextEditingController announcementTitleMessage) {
    return FloatingActionButton(
      onPressed: () {
        final checkBoxState = BlocProvider.of<CheckBoxBloc>(context).state;
        final pickedFilesState = BlocProvider.of<FilePickBloc>(context).state;
        final idState = BlocProvider.of<AnnouncementBloc>(context).state;
        final id = idState.id;

        if (announcementMessage.text.isEmpty &&
            announcementTitleMessage.text.isEmpty) {
          SnackBarHelper.showSnackBar(
              context, 'Please enter a message and title before sending.');
        } else if (!checkBoxState.hasCheckedCheckbox()) {
          SnackBarHelper.showSnackBar(
              context, 'Please select at least one checkbox.');
        } else {
          print("id : $id");
          if (id.isNotEmpty) {
            final fileState = BlocProvider.of<FilePickBloc>(context).state;
            BlocProvider.of<AnnouncementBloc>(context).add(
              AnnouncementEditSendEvent(
                dept: dept,
                batchId: batchId,
                announcementMessage: announcementMessage.text,
                titleMessage: announcementTitleMessage.text,
                checkBoxes: checkBoxState.checkBoxes,
                id: id,
                editedDate: DateTime.now(),
                pickedFiles: fileState.pickedFiles,
              ),
            );
          } else {
            BlocProvider.of<AnnouncementBloc>(context).add(
              AnnouncementSendEvent(
                dept: dept,
                batchId: batchId,
                announcementMessage: announcementMessage.text,
                titleMessage: announcementTitleMessage.text,
                checkBoxes: checkBoxState.checkBoxes,
                pickedFiles: pickedFilesState.pickedFiles,
                editedDate: DateTime.now(),
                id: id,
              ),
            );
          }
        }
      },
      foregroundColor: Colors.grey[150],
      backgroundColor: Colors.grey,
      child: const Icon(Icons.send),
    );
  }
}
