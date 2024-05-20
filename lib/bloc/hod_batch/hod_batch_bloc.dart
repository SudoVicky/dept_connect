import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dept_connect/data/models/batch_data.dart';
import 'package:equatable/equatable.dart';

part 'hod_batch_event.dart';
part 'hod_batch_state.dart';

class HodBatchBloc extends Bloc<HodBatchEvent, HodBatchState> {
  HodBatchBloc() : super(HodBatchInitial()) {
    on<HodBatchLoadRequested>(_mapLoadRequestedToState);
  }

  void _mapLoadRequestedToState(
    HodBatchLoadRequested event,
    Emitter<HodBatchState> emit,
  ) async {
    emit(HodBatchLoading());
    try {
      final batches = await _fetchBatchesFromDatabase(event.dept);
      emit(HodBatchLoaded(batches));
    } catch (e) {
      emit(HodBatchError('Failed to load batches: $e'));
    }
  }

  Future<List<BatchData>> _fetchBatchesFromDatabase(String dept) async {
    try {
      // Access Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Reference to the 'departments' collection
      CollectionReference departmentCollection =
          firestore.collection('departments');

      // Get the document reference for the specified department
      DocumentSnapshot departmentDocumentSnapshot =
          await departmentCollection.doc(dept).get();

      // Access the 'batches' subcollection of the department
      CollectionReference batchesCollection =
          departmentDocumentSnapshot.reference.collection('batches');

      // Fetch all documents from the 'batches' subcollection
      QuerySnapshot batchQuerySnapshot = await batchesCollection
          .orderBy('semester_no', descending: false)
          .get();

      // Extract batch names from the documents
      List<BatchData> batchesData = batchQuerySnapshot.docs.map((batchDoc) {
        String batchId = batchDoc['batch_id'] as String;
        int semesterNo = batchDoc['semester_no'] as int;
        return BatchData(batchId: batchId, semesterNo: semesterNo);
      }).toList();

      return batchesData;
    } catch (error) {
      // Throw the error to be caught by the caller
      throw error;
    }
  }
}
