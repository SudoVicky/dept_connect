// message_event.dart
import 'package:dept_connect/data/models/announcement_message.dart';

abstract class MessageEvent {}

class InitialLoadMessageEvent extends MessageEvent {
  final String dept;
  final String batchId;

  InitialLoadMessageEvent({required this.dept, required this.batchId});
}

class LoadMessagesEvent extends MessageEvent {}

class UpdateMessagesEvent extends MessageEvent {
  final List<AnnouncementMessage> messages;

  UpdateMessagesEvent(this.messages);
}
