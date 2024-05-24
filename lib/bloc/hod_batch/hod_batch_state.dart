part of 'hod_batch_bloc.dart';

sealed class HodBatchState extends Equatable {
  const HodBatchState();

  @override
  List<Object> get props => [];
}

class HodBatchInitial extends HodBatchState {}

class HodBatchLoading extends HodBatchState {}

class HodBatchLoaded extends HodBatchState {
  // final List<String> batchNames;
  final List<BatchData> batchData;

  const HodBatchLoaded(this.batchData);

  @override
  List<Object> get props => [batchData];
}

class HodBatchError extends HodBatchState {
  final String errorMessage;

  const HodBatchError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
