import 'package:dept_connect/bloc/authentication/authentication_bloc.dart';
import 'package:dept_connect/bloc/hod_batch/hod_batch_bloc.dart';
import 'package:dept_connect/bloc/hod_batch_people/hod_batch_people_bloc.dart';
import 'package:dept_connect/firebase_options.dart';
import 'package:dept_connect/presentation/screens/faculty/faculty_login_page.dart';
import 'package:dept_connect/presentation/screens/faculty/faculty_page.dart';
import 'package:dept_connect/presentation/screens/faculty/hod/hod_space_page.dart';
import 'package:dept_connect/presentation/screens/main_page.dart';
import 'package:dept_connect/presentation/screens/faculty/hod/hod_batch_announcement_page.dart';
import 'package:dept_connect/presentation/screens/faculty/hod/hod_batch_announcement_details_page.dart';
import 'package:dept_connect/presentation/screens/faculty/hod/hod_batch_course_details_page.dart';
import 'package:dept_connect/presentation/screens/faculty/hod/hod_batch_page.dart';
import 'package:dept_connect/presentation/screens/faculty/hod/hod_batch_people_section.dart';
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
        "/hod_batch_announcement_details_page": (context) =>
            HodBatchAnnouncementDetailsPage(),
        "/hod_batch_course_details_page": (context) =>
            HodBatchCourseDetailsPage(),
        "/hod_batch_announcement_page": (context) => HodBatchAnnouncementPage(),
        // "/hod_batch_announcement_page": (context) => AnnouncementInputTile(),
      },
    );
  }
}
