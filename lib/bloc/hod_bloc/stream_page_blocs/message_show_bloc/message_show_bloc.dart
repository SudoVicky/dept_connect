import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dept_connect/data/models/announcement_message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'message_show_event.dart';
import 'message_show_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessagesState> {
  final FirebaseFirestore firestore;
  final String dept;
  final String batchId;
  StreamSubscription? _messageSubscription;

  MessageBloc(this.firestore, this.dept, this.batchId)
      : super(MessageInitialState()) {
    on<LoadMessagesEvent>(_onLoadMessages);
    on<UpdateMessagesEvent>(_onUpdateMessages);

    _messageSubscription = firestore
        .collection('departments')
        .doc(dept)
        .collection('batches')
        .doc(batchId)
        .collection('batchesMessages')
        .snapshots()
        .listen((snapshot) {
      final messages = snapshot.docs.map((doc) {
        final data = doc.data();
        final List<dynamic> toWhom = data['toWhom'] ?? [];
        final List<Map<String, dynamic>> fileInfo = data['fileInfo'] != null
            ? List<Map<String, dynamic>>.from(data['fileInfo'])
            : [];
        final dynamic timestamp = data['timestamp'];
        final dynamic editedTimestamp = data['editedDate'];

        return AnnouncementMessage(
          id: data['id'] ?? '',
          title: data['title'] ?? '',
          content: data['content'] ?? '',
          sender: data['sender'] ?? '',
          toWhom: toWhom,
          fileInfo: fileInfo,
          timestamp: timestamp != null
              ? (timestamp as Timestamp).toDate()
              : DateTime.now(),
          editedTimestamp: editedTimestamp != null
              ? (editedTimestamp as Timestamp).toDate()
              : DateTime.now(),
        );
      }).toList();

      messages.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      add(UpdateMessagesEvent(messages));
    });
  }

  void _onLoadMessages(
      LoadMessagesEvent event, Emitter<MessagesState> emit) async {
    emit(MessageLoadingState());
    try {
      final snapshot = await firestore
          .collection('departments')
          .doc(dept)
          .collection('batches')
          .doc(batchId)
          .collection('batchesMessages')
          .get();

      final List<AnnouncementMessage> messages = snapshot.docs.map((doc) {
        final data = doc.data();
        final List<dynamic> toWhom = data['toWhom'] ?? [];
        final List<Map<String, dynamic>> fileInfo = data['fileInfo'] != null
            ? List<Map<String, dynamic>>.from(data['fileInfo'])
            : [];
        final dynamic timestamp = data['timestamp'];
        final dynamic editedTimestamp = data['editedDate'];

        return AnnouncementMessage(
          id: data['id'] ?? '',
          title: data['title'] ?? '',
          content: data['content'] ?? '',
          sender: data['sender'] ?? '',
          toWhom: toWhom,
          fileInfo: fileInfo,
          timestamp: timestamp != null
              ? (timestamp as Timestamp).toDate()
              : DateTime.now(),
          editedTimestamp: editedTimestamp != null
              ? (editedTimestamp as Timestamp).toDate()
              : DateTime.now(),
        );
      }).toList();

      messages.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      emit(MessageLoadedState(messages));
    } catch (e) {
      emit(MessageErrorState(e.toString()));
    }
  }

  void _onUpdateMessages(
      UpdateMessagesEvent event, Emitter<MessagesState> emit) {
    emit(MessageLoadedState(event.messages));
  }

  @override
  Future<void> close() {
    _messageSubscription?.cancel();
    return super.close();
  }
}
