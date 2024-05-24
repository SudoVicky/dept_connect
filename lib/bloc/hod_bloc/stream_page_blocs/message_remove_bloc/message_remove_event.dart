// Events
abstract class MessageRemoveEvent {}

class RemoveMessageEvent extends MessageRemoveEvent {
  final String dept;
  final String batchId;
  final String id;

  RemoveMessageEvent(
      {required this.dept, required this.batchId, required this.id});
}
