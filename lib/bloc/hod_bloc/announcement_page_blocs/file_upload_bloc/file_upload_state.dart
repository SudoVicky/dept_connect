import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class FilePickState {
  final List<File> pickedFiles;

  FilePickState({required this.pickedFiles});

  @override
  List<Object> get props => [pickedFiles];
}

class FilePickInitialState extends FilePickState {
  FilePickInitialState({required super.pickedFiles});
}

class FilePickSuccessState extends FilePickState {
  FilePickSuccessState({required super.pickedFiles});
}

class FilePickFailureState extends FilePickState {
  final String message;

  FilePickFailureState({required super.pickedFiles, required this.message});

  @override
  List<Object> get props => [pickedFiles, message];
}

class FileEditInitialState extends FilePickState {
  final List<File> files;

  FileEditInitialState({required this.files, required super.pickedFiles});
}
