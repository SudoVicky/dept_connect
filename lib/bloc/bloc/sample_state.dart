part of 'sample_bloc.dart';

sealed class SampleState extends Equatable {
  const SampleState();
  
  @override
  List<Object> get props => [];
}

final class SampleInitial extends SampleState {}
