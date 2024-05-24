import 'package:dept_connect/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'message_remove_event.dart';
import 'message_remove_state.dart';

class MessageRemoveBloc extends Bloc<MessageRemoveEvent, MessageRemoveState> {
  FirestoreService firestoreService = FirestoreService();

  MessageRemoveBloc() : super(MessageRemoveInitial()) {
    on<RemoveMessageEvent>(_callRemoveMethod);
  }

  _callRemoveMethod(
      RemoveMessageEvent event, Emitter<MessageRemoveState> emit) async {
    emit(MessageRemoveInProgress());
    try {
      await firestoreService.removeMessage(event.dept, event.batchId, event.id);

      emit(MessageRemoveSuccess());
      Fluttertoast.showToast(
        msg: "Message and attachments removed successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      print(e);
      emit(MessageRemoveFailure(error: e.toString()));
      Fluttertoast.showToast(
        msg: "Failed to remove message: ${e.toString()}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}
