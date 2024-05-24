import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'hod_batch_people_event.dart';
part 'hod_batch_people_state.dart';

class HodBatchPeopleBloc
    extends Bloc<HodBatchPeopleEvent, HodBatchPeopleState> {
  HodBatchPeopleBloc() : super(HodBatchPeopleInitial()) {
    on<FetchPeopleDataSec1>(_mapLoadPeopleDataSec1);
  }
}

void _mapLoadPeopleDataSec1(
  FetchPeopleDataSec1 event,
  Emitter<HodBatchPeopleState> emit,
) async {
  emit(HodBatchPeopleLoading());
  try {
    // Get a reference to the Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Access the collection containing student documents
    CollectionReference studentsCollection = firestore
        .collection('departments')
        .doc(event.dept)
        .collection('batches')
        .doc(event.batchId)
        .collection('students');

    QuerySnapshot studentSnapshot =
        await studentsCollection.where('section', isEqualTo: "1").get();

    List<String> studentNames = [];
    studentSnapshot.docs.forEach((DocumentSnapshot document) {
      String name = document['name'];
      studentNames.add(name);
    });

    emit(HodBatchPeopleLoaded(studentNames));
  } catch (e) {
    // Handle any errors that occur during data retrieval
    emit(HodBatchPeopleError('Failed to load students: $e'));
  }
}
