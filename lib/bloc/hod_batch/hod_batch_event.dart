part of 'hod_batch_bloc.dart';

class HodBatchEvent extends Equatable {
  const HodBatchEvent();

  @override
  List<Object> get props => [];
}

class HodBatchLoadRequested extends HodBatchEvent {
  final String dept;

  const HodBatchLoadRequested(this.dept);

  @override
  List<Object> get props => [dept];
}
