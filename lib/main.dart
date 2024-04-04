import 'package:dept_connect/firebase_options.dart';
import 'package:dept_connect/pages/faculty/faculty_login_page.dart';
import 'package:dept_connect/screens/faculty/faculty_page.dart';
import 'package:dept_connect/screens/main_page.dart';
import 'package:dept_connect/static/components/announcement_input_tile.dart';
import 'package:dept_connect/static/hod_batch_announcement_page.dart';
import 'package:dept_connect/static/hod_batch_announcement_details_page.dart';
import 'package:dept_connect/static/hod_batch_course_details_page.dart';
import 'package:dept_connect/static/hod_batch_page.dart';
import 'package:dept_connect/static/hod_batch_people_section.dart';
import 'package:dept_connect/static/hod_space_page.dart';
import 'package:dept_connect/static/hod_batch_stream_page.dart';
import 'package:dept_connect/static/start.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
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
