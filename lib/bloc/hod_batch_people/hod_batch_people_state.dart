part of 'hod_batch_people_bloc.dart';

sealed class HodBatchPeopleState extends Equatable {
  const HodBatchPeopleState();

  @override
  List<Object> get props => [];
}

class HodBatchPeopleInitial extends HodBatchPeopleState {}

class HodBatchPeopleLoading extends HodBatchPeopleState {}

class HodBatchPeopleLoaded extends HodBatchPeopleState {
  final List<String> studentNames;

  const HodBatchPeopleLoaded(this.studentNames);
}

class HodBatchPeopleError extends HodBatchPeopleState {
  final String errorMessage;

  const HodBatchPeopleError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
