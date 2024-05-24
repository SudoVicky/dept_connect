import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'hod_batch_course_event.dart';
part 'hod_batch_course_state.dart';

class HodBatchCourseBloc extends Bloc<HodBatchCourseEvent, HodBatchCourseState> {
  HodBatchCourseBloc() : super(HodBatchCourseInitial()) {
    on<HodBatchCourseEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
