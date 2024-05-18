import 'package:dept_connect/bloc/authentication/bloc/authentication_bloc.dart';
import 'package:dept_connect/firebase_options.dart';
import 'package:dept_connect/presentation/screens/faculty/faculty_login_page.dart';
import 'package:dept_connect/presentation/screens/faculty/faculty_page.dart';
import 'package:dept_connect/presentation/screens/faculty/hod/hod_space_page.dart';
import 'package:dept_connect/presentation/screens/main_page.dart';
import 'package:dept_connect/static/hod_batch_announcement_page.dart';
import 'package:dept_connect/static/hod_batch_announcement_details_page.dart';
import 'package:dept_connect/static/hod_batch_course_details_page.dart';
import 'package:dept_connect/static/hod_batch_page.dart';
import 'package:dept_connect/static/hod_batch_people_section.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc(),
      child: const MyApp(),
    ),
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

        //static routes
        "/hod_space_page": (context) => HodSpacePage(),
        "/hod_batch_page": (context) => HodBatchPage(),
        "/hod_batch_people_section": (context) => HodBatchPeopleSection(),
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
