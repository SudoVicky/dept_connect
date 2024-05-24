import 'dart:io';

import 'package:dept_connect/bloc/hod_bloc/announcement_page_blocs/file_upload_bloc/file_upload_bloc.dart';
import 'package:dept_connect/bloc/hod_bloc/announcement_page_blocs/file_upload_bloc/file_upload_event.dart';
import 'package:dept_connect/bloc/hod_bloc/announcement_page_blocs/file_upload_bloc/file_upload_state.dart';
import 'package:dept_connect/consts/file_icon_choose.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FileUploadButton {
  Widget buildFileUploadButton(BuildContext context) {
    return BlocConsumer<FilePickBloc, FilePickState>(
      listener: (context, state) {
        if (state is FilePickFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('File Upload Failed: ${state.message}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        List<File> files = [];
        if (state is FilePickSuccessState) {
          files = state.pickedFiles;
        }
        if (state is FileEditInitialState) {
          files = state.files;
          print(files);
        }

        return GestureDetector(
          onTap: () {
            BlocProvider.of<FilePickBloc>(context).add(FilePickFilesEvent());
          },
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Icon(Icons.attach_file),
                          SizedBox(width: 14),
                          Text(
                            "Add Attachment",
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Attachments:",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: files
                          .map((file) => _buildFileContainer(context, file))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFileContainer(BuildContext context, File file) {
    String fileName = file.path.split('/').last;
    String fileExtension = fileName.split('.').last;
    String iconData = FileIconChoose().getIcon(fileExtension);

    return Dismissible(
      key: Key(file.path),
      onDismissed: (direction) {
        BlocProvider.of<FilePickBloc>(context).add(RemoveFileEvent(file: file));
      },
      background: Container(),
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
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  fileName,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
