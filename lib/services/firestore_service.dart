import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> updateMessageInFirestore(
      String dept,
      String batchId,
      String id,
      String announcementMessage,
      String titleMessage,
      List<Map<String, dynamic>> checkboxes,
      DateTime editedDate,
      List<File> newFiles) async {
    try {
      // Filter the selected categories based on checkboxes
      List selectedCategories = checkboxes
          .where((checkbox) => checkbox['isChecked'] == true)
          .map((checkbox) => checkbox['name'])
          .toList();

      // Reference to the Firestore document to update
      DocumentReference docRef = _firestore
          .collection('departments')
          .doc(dept)
          .collection('batches')
          .doc(batchId) // Assuming '2021-2025' is the batch ID
          .collection('batchesMessages')
          .doc(id); // Document ID to update

      // Get the document ID
      String docId = docRef.id;

      // Check if the folder exists in Firebase Storage
      String folderPath = 'uploads/$docId';
      final folderRef = _storage.ref(folderPath);

      ListResult result;
      try {
        result = await folderRef.listAll();
        if (result.items.isNotEmpty) {
          // If folder exists, delete all files
          for (Reference fileRef in result.items) {
            await fileRef.delete();
          }
        }
      } catch (e) {
        // Folder does not exist, continue to next step
      }

      List<Map<String, String>> filesInfo = [];

      // Upload new files to Firebase Storage and get download URLs
      for (File file in newFiles) {
        String fileName = file.path.split('/').last;
        Reference fileRef = folderRef.child(fileName);
        await fileRef.putFile(file);
        String downloadUrl = await fileRef.getDownloadURL();
        filesInfo.add({'fileName': fileName, 'downloadUrl': downloadUrl});
      }

      // Update the document with the new message content and file information
      await docRef.update({
        'title': titleMessage,
        'content': announcementMessage,
        'toWhom': selectedCategories,
        'editedDate': editedDate,
        'fileInfo': filesInfo,
      });
    } catch (e) {
      print('Failed to update message in Firebase: $e');
      throw e;
    }
  }

  Future<void> sendMessageToFirebase(
      String dept,
      String batchId,
      String announcementMessage,
      String titleMessage,
      List<Map<String, dynamic>> checkboxes,
      List<File> pickedFiles,
      DateTime editedDate) async {
    try {
      // Filter the selected categories based on checkboxes
      List selectedCategories = checkboxes
          .where((checkbox) => checkbox['isChecked'] == true)
          .map((checkbox) => checkbox['name'])
          .toList();
      DocumentReference docRef = await _firestore
          .collection('departments')
          .doc(dept)
          .collection('batches')
          .doc(batchId)
          .collection('batchesMessages')
          .doc(); // No document ID specified, Firestore will generate one

      String docId = docRef.id; // Get the ID of the created document

      await docRef.set({
        'id': docId, // Store the document ID as a field in the document
        'title': titleMessage,
        'content': announcementMessage,
        'sender': 'Hod',
        'timestamp': FieldValue.serverTimestamp(),
        'toWhom': selectedCategories,
        'editedDate': editedDate,
        'fileInfo': [],
      });

      // Create a directory reference in Firebase Storage
      Reference storageRef = _storage.ref().child('uploads/$docId');

      List<Map<String, String>> filesInfo = [];

      // Upload files to Firebase Storage and get download URLs
      for (File file in pickedFiles) {
        String fileName = file.path.split('/').last;
        Reference fileRef = storageRef.child(fileName);
        await fileRef.putFile(file);
        String downloadUrl = await fileRef.getDownloadURL();
        filesInfo.add({'fileName': fileName, 'downloadUrl': downloadUrl});
      }

      // Update the Firestore document with file information
      await docRef.update({'fileInfo': filesInfo});
    } catch (e) {
      print('Failed to send message to Firebase: $e');
      throw e;
    }
  }

  Future<void> removeMessage(String dept, String batchId, String id) async {
    if (id.isEmpty) {
      throw Exception('Invalid message ID');
    }

    try {
      // Check if the folder exists in Firebase Storage
      String folderPath = 'uploads/$id';
      final folderRef = _storage.ref(folderPath);
      ListResult result;
      try {
        result = await folderRef.listAll();
        if (result.items.isNotEmpty) {
          // If folder exists, delete it
          await folderRef.delete();
        }
      } catch (e) {
        // Folder does not exist, continue to next check
      }

      // Check if the message document exists in Firestore
      final docRef = _firestore
          .collection('departments')
          .doc(dept)
          .collection('batches')
          .doc(batchId)
          .collection('batchesMessages')
          .doc(id);

      final docSnapshot = await docRef.get();
      if (docSnapshot.exists) {
        // If document exists, delete it
        await docRef.delete();
      }
    } catch (e) {
      // Handle any errors here
      throw e;
    }
  }
}
