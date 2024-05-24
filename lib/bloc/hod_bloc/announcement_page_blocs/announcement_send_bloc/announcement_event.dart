import 'dart:io';

import 'package:equatable/equatable.dart';

class AnnouncementEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AnnouncementInitialEvent extends AnnouncementEvent {}

class AnnouncementSendEvent extends AnnouncementEvent {
  final String dept;
  final String batchId;
  final String announcementMessage;
  final String titleMessage;
  final List<Map<String, dynamic>> checkBoxes;
  final List<File> pickedFiles;
  final DateTime editedDate;
  final String id;

  AnnouncementSendEvent({
    required this.dept,
    required this.batchId,
    required this.announcementMessage,
    required this.titleMessage,
    required this.checkBoxes,
    required this.pickedFiles,
    required this.editedDate,
    required this.id,
  });

  @override
  List<Object?> get props =>
      [announcementMessage, titleMessage, checkBoxes, pickedFiles];
}

class AnnouncementEditEvent extends AnnouncementEvent {
  final String announcementMessage;
  final String titleMessage;
  final String id;

  AnnouncementEditEvent({
    required this.announcementMessage,
    required this.titleMessage,
    required this.id,
  });
}

class AnnouncementEditSendEvent extends AnnouncementEvent {
  final String dept;
  final String batchId;
  final String announcementMessage;
  final String titleMessage;
  final List<Map<String, dynamic>> checkBoxes;
  final String id;
  final DateTime editedDate;
  final List<File> pickedFiles;

  AnnouncementEditSendEvent({
    required this.dept,
    required this.batchId,
    required this.announcementMessage,
    required this.titleMessage,
    required this.checkBoxes,
    required this.id,
    required this.editedDate,
    required this.pickedFiles,
  });
}

class DetailsPageEditEvent extends AnnouncementEvent {
  final bool isDetailsPageEdit;

  DetailsPageEditEvent({required this.isDetailsPageEdit});
}
