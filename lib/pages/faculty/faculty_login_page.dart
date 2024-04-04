import 'package:dept_connect/components/user_button.dart';
import 'package:dept_connect/components/user_text_field.dart';
import 'package:dept_connect/services/auth_service.dart';
import 'package:flutter/material.dart';

class FacultyLoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  FacultyLoginPage({super.key});

  void _facultyLogin(BuildContext context) async {
    final email = _emailController.text.trim();
    final password = _emailController.text.trim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HOD"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text("HOD"),
            // const SizedBox(height: 15),

            //email id
            UserTextField(
              hintText: "Email",
              obscureText: false,
              controller: _emailController,
            ),
            const SizedBox(height: 10),
            //password
            UserTextField(
              hintText: "Passowrd",
              obscureText: true,
              controller: _passwordController,
            ),
            const SizedBox(height: 10),
            UserButton(label: "Login", onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
