import 'package:dept_connect/components/user_button.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UserButton(
              label: "Faculty",
              onPressed: () {
                Navigator.pushNamed(context, "/faculty_page");
              },
            ),
            const SizedBox(height: 20),
            UserButton(label: "Student", onPressed: () {}),
            const SizedBox(height: 20),
            UserButton(label: "Parent", onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
