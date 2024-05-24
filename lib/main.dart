import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dept_connect/bloc/authentication/authentication_bloc.dart';
import 'package:dept_connect/bloc/hod_batch/hod_batch_bloc.dart';
import 'package:dept_connect/bloc/hod_batch_people/hod_batch_people_bloc.dart';
import 'package:dept_connect/bloc/hod_bloc/announcement_details_full_screen_blocs/ToWhomCubit/to_whom_cubit.dart';
import 'package:dept_connect/bloc/hod_bloc/announcement_details_full_screen_blocs/file_download_bloc/file_download_bloc.dart';
import 'package:dept_connect/bloc/hod_bloc/announcement_page_blocs/announcement_check_box_bloc/check_box_bloc.dart';
import 'package:dept_connect/bloc/hod_bloc/announcement_page_blocs/announcement_send_bloc/announcement_bloc.dart';
import 'package:dept_connect/bloc/hod_bloc/announcement_page_blocs/file_upload_bloc/file_upload_bloc.dart';
import 'package:dept_connect/bloc/hod_bloc/stream_page_blocs/message_remove_bloc/message_remove_bloc.dart';
import 'package:dept_connect/bloc/hod_bloc/stream_page_blocs/message_show_bloc/message_show_bloc.dart';
import 'package:dept_connect/bloc/hod_bloc/stream_page_blocs/message_show_bloc/message_show_event.dart';
import 'package:dept_connect/firebase_options.dart';
import 'package:dept_connect/presentation/screens/faculty/faculty_login_page.dart';
import 'package:dept_connect/presentation/screens/faculty/faculty_page.dart';
import 'package:dept_connect/presentation/screens/faculty/hod/hod_space_page.dart';
import 'package:dept_connect/presentation/screens/main_page.dart';
import 'package:dept_connect/presentation/screens/faculty/hod/hod_batch_announcement_page.dart';
import 'package:dept_connect/presentation/screens/faculty/hod/hod_batch_course_details_page.dart';
import 'package:dept_connect/presentation/screens/faculty/hod/hod_batch_page.dart';
import 'package:dept_connect/presentation/screens/faculty/hod/hod_batch_people_section.dart';
import 'package:dept_connect/services/firestore_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiBlocProvider(providers: [
      BlocProvider<AuthenticationBloc>(
        create: (context) => AuthenticationBloc(),
      ),
      BlocProvider<HodBatchBloc>(
        create: (context) => HodBatchBloc(),
      ),
      BlocProvider<HodBatchPeopleBloc>(
        create: (context) => HodBatchPeopleBloc(),
      ),
      //phranav's
      BlocProvider<CheckBoxBloc>(create: (context) => CheckBoxBloc()),
      BlocProvider<AnnouncementBloc>(
          create: (context) =>
              AnnouncementBloc(firestoreService: FirestoreService())),
      BlocProvider<FilePickBloc>(
        create: (context) => FilePickBloc(),
      ),

      BlocProvider<FileDownloadBloc>(
        create: (context) => FileDownloadBloc(),
      ),
      BlocProvider<ToWhomOverlayCubit>(
        create: (context) => ToWhomOverlayCubit(),
      ),
      BlocProvider<MessageRemoveBloc>(
        create: (context) => MessageRemoveBloc(),
      ),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
      routes: {
        "/faculty_page": (context) => FacultyPage(),
        "/faculty_login_page": (context) => FacultyLoginPage(),

        "/hod_space_page": (context) => HodSpacePage(),
        "/hod_batch_page": (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          final dept = args['dept'] as String;
          final batchId = args['batchId'] as String;
          final semesterNo = args['semesterNo'] as int;
          final year = args['year'] as String;

          return HodBatchPage(
            dept: dept,
            batchId: batchId,
            semesterNo: semesterNo,
            year: year,
          );
        },

        "/hod_batch_people_section": (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          final dept = args['dept'] as String;
          final batchId = args['batchId'] as String;
          final section = args['section'] as String;
          return HodBatchPeopleSection(
            dept: dept,
            batchId: batchId,
            section: section,
          );
        },

        // "/hod_batch_announcement_details_page": (context) =>
        //     HodBatchAnnouncementDetailsPage(),
        "/hod_batch_course_details_page": (context) =>
            HodBatchCourseDetailsPage(),
        "/hod_batch_announcement_page": (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          final dept = args['dept'] as String;
          final batchId = args['batchId'] as String;

          return HodBatchAnnouncementPage(dept: dept, batchId: batchId);
        }
      },
    );
  }
}
