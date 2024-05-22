import 'package:dept_connect/bloc/authentication/authentication_bloc.dart';
import 'package:dept_connect/bloc/authentication/authentication_event.dart';
import 'package:dept_connect/bloc/authentication/authentication_state.dart';
import 'package:dept_connect/presentation/components/user_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  void _checkExistingUserData(BuildContext context) {
    BlocProvider.of<AuthenticationBloc>(context)
        .add(AuthenticationLocalLoginRequested());
  }

  @override
  Widget build(BuildContext context) {
    _checkExistingUserData(context);
    return Scaffold(
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationLoading) {
            Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AuthenticationAuthenticated) {
            if (state.user == "HOD") {
              Navigator.pushNamed(context, "/hod_space_page",
                  arguments: {"dept": state.dept});
            } else if (state.user == "Senior Tutor") {}
          }
        },
        child: Center(
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
      ),
    );
  }
}
