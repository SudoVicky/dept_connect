import 'package:dept_connect/presentation/components/user_button.dart';
import 'package:flutter/material.dart';

class FacultyPage extends StatelessWidget {
  const FacultyPage({super.key});

  void facultyLogin(BuildContext context, String id) {
    Navigator.pushNamed(
      context,
      "/faculty_login_page",
      arguments: {'id': id},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Faculty"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UserButton(
              label: "HOD",
              onPressed: () => facultyLogin(context, "HOD"),
            ),
            const SizedBox(height: 20),
            UserButton(
              label: "Senior Tutor",
              onPressed: () => facultyLogin(context, "Senior Tutor"),
            ),
            const SizedBox(height: 20),
            UserButton(
              label: "Tutor",
              onPressed: () => facultyLogin(context, "Tutor"),
            ),
            const SizedBox(height: 20),
            UserButton(
              label: "Teacher",
              onPressed: () => facultyLogin(context, "Teacher"),
            ),
          ],
        ),
      ),
    );
  }
}
