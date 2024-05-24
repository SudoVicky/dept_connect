import 'package:dept_connect/services/firestore_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'announcement_event.dart';
import 'announcement_state.dart';

class AnnouncementBloc extends Bloc<AnnouncementEvent, AnnouncementState> {
  final FirestoreService _firestoreService;
  bool isDetailsPage = false;

  AnnouncementBloc({required FirestoreService firestoreService})
      : _firestoreService = firestoreService,
        super(AnnouncementInitialState(id: '')) {
    on<AnnouncementSendEvent>(_sendMessageToFirebase);
    on<AnnouncementInitialEvent>(_callInitialState);
    on<AnnouncementEditEvent>(_callEditInitialState);
    on<AnnouncementEditSendEvent>(_updateMessageToFirebase);
    on<DetailsPageEditEvent>(_markAsIsDetailsPageEdit);
  }

  void _markAsIsDetailsPageEdit(
      DetailsPageEditEvent event, Emitter<AnnouncementState> emit) {
    isDetailsPage = event.isDetailsPageEdit;
  }

  void _updateMessageToFirebase(
    AnnouncementEditSendEvent event,
    Emitter<AnnouncementState> emit,
  ) async {
    try {
      // Update the message data in Firestore using the FirestoreService
      emit(AnnouncementSendLoadingState(id: event.id));

      await _firestoreService.updateMessageInFirestore(
          event.dept,
          event.batchId,
          event.id, // Document ID
          event.announcementMessage,
          event.titleMessage,
          event.checkBoxes,
          event.editedDate,
          event.pickedFiles); // No files to upload, so empty list

      // Emit a success state if updating in Firestore is successful
      emit(AnnouncementSendSuccessState(
          id: event.id, isDetailsPageEditTriggered: isDetailsPage));
    } catch (e) {
      // Emit a failure state if an error occurs during Firestore operation
      emit(AnnouncementSendFailureState(
          errorMessage: 'Failed to update data in Firebase: $e', id: event.id));
    }
  }

  void _callEditInitialState(
      AnnouncementEditEvent event, Emitter<AnnouncementState> emit) {
    print("edit initial state is called");
    emit(AnnouncementEditInitialState(
        announcementMessage: event.announcementMessage,
        titleMessage: event.titleMessage,
        id: event.id,
        Eid: event.id));
  }

  void _callInitialState(
      AnnouncementInitialEvent event, Emitter<AnnouncementState> emit) {
    emit(AnnouncementInitialState(id: ''));
  }

  void _sendMessageToFirebase(
      AnnouncementSendEvent event, Emitter<AnnouncementState> emit) async {
    try {
      // Send message and checkboxes data to Firestore using the FirestoreService
      emit(AnnouncementSendLoadingState(id: ''));
      await _firestoreService.sendMessageToFirebase(
          event.dept,
          event.batchId,
          event.announcementMessage,
          event.titleMessage,
          event.checkBoxes,
          event.pickedFiles,
          event.editedDate);

      // Emit a success state if sending to Firestore is successful
      emit(AnnouncementSendSuccessState(
          id: event.id, isDetailsPageEditTriggered: false));
    } catch (e) {
      // Emit a failure state if an error occurs during Firestore operation
      emit(AnnouncementSendFailureState(
          errorMessage: 'Failed to send data to Firebase: $e', id: event.id));
    }
  }
}
