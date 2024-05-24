import 'dart:io';

import 'package:equatable/equatable.dart';

class AnnouncementState extends Equatable {
  final String id;

  AnnouncementState({required this.id});

  @override
  List<Object?> get props => [id];
}

class AnnouncementInitialState extends AnnouncementState {
  AnnouncementInitialState({required super.id});
}

class AnnouncementSendLoadingState extends AnnouncementState {
  AnnouncementSendLoadingState({required super.id});
}

class AnnouncementSendSuccessState extends AnnouncementState {
  final bool isDetailsPageEditTriggered;

  AnnouncementSendSuccessState({ required this.isDetailsPageEditTriggered, required super.id});
}

class AnnouncementSendFailureState extends AnnouncementState {
  final String errorMessage;

  AnnouncementSendFailureState({required this.errorMessage, required super.id});

  @override
  List<Object?> get props => [errorMessage];
}

class AnnouncementEditInitialState extends AnnouncementState {
  final String announcementMessage;
  final String titleMessage;
  final String Eid;

  AnnouncementEditInitialState(
      {required super.id,
      required this.announcementMessage,
      required this.titleMessage,
      required this.Eid});
}

class AnnouncementUpdateLoadingState extends AnnouncementState {
  AnnouncementUpdateLoadingState({required super.id});
}

class AnnouncementUpdateSuccessState extends AnnouncementState {
  AnnouncementUpdateSuccessState({required super.id});
}

class AnnouncementUpdateFailureState extends AnnouncementState {
  final String errorMessage;

  AnnouncementUpdateFailureState({required this.errorMessage, required super.id});

  @override
  List<Object?> get props => [errorMessage];
}


