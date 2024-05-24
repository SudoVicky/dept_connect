part of 'hod_batch_people_bloc.dart';

sealed class HodBatchPeopleEvent extends Equatable {
  const HodBatchPeopleEvent();

  @override
  List<Object> get props => [];
}

class FetchPeopleDataSec1 extends HodBatchPeopleEvent {
  final String dept;
  final String batchId;

  const FetchPeopleDataSec1(this.dept, this.batchId);

  @override
  List<Object> get props => [dept, batchId];
}

class FetchPeopleDataSec2 extends HodBatchPeopleEvent {
  final String dept;
  final String batchId;

  const FetchPeopleDataSec2(this.dept, this.batchId);

  @override
  List<Object> get props => [dept, batchId];
}
