import 'package:dept_connect/components/snack_bar.dart';
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
    bool loginSuccess = await _authService.facultyLogin(email, password);
    if (loginSuccess) {
      CustomSnackBar(message: "Successfull login").show(context);
    } else {
      CustomSnackBar(message: "Failure login").show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    String id = args['id']!;
    return Scaffold(
      appBar: AppBar(
        title: Text(id),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UserTextField(
              hintText: "Email",
              obscureText: false,
              controller: _emailController,
            ),
            const SizedBox(height: 10),
            //password
            UserTextField(
              hintText: "Password",
              obscureText: true,
              controller: _passwordController,
            ),
            const SizedBox(height: 10),
            UserButton(label: "Login", onPressed: () => _facultyLogin(context)),
          ],
        ),
      ),
    );
  }
}
