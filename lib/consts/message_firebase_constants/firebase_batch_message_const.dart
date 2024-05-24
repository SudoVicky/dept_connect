import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseBatchMessageConst {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late String documentId;

  FirebaseBatchMessageConst(this.documentId);
  // Initialize the batchMessagesCollection inside a constructor or method
  CollectionReference get batchMessagesCollection {
    return firestore
        .collection('departments')
        .doc('CSE')
        .collection('batches')
        .doc(documentId)
        .collection('batchesMessages');
  }

  // Reference to sec1 for teachers, students, and parents
  CollectionReference get teachersSec1Collection {
    return batchMessagesCollection.doc('teachers').collection('sec1');
  }

  CollectionReference get studentsSec1Collection {
    return batchMessagesCollection.doc('students').collection('sec1');
  }

  CollectionReference get parentsSec1Collection {
    return batchMessagesCollection.doc('parents').collection('sec1');
  }

  // Reference to sec2 for teachers, students, and parents
  CollectionReference get teachersSec2Collection {
    return batchMessagesCollection.doc('teachers').collection('sec2');
  }

  CollectionReference get studentsSec2Collection {
    return batchMessagesCollection.doc('students').collection('sec2');
  }

  CollectionReference get parentsSec2Collection {
    return batchMessagesCollection.doc('parents').collection('sec2');
  }
  CollectionReference get seniorTutorCollection {
    return batchMessagesCollection.doc('senior_tutor').collection('messages');
  }
}
