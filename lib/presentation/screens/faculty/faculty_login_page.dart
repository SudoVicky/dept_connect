import 'package:dept_connect/bloc/authentication/bloc/authentication_bloc.dart';
import 'package:dept_connect/bloc/authentication/bloc/authentication_event.dart';
import 'package:dept_connect/bloc/authentication/bloc/authentication_state.dart';
import 'package:dept_connect/presentation/components/user_button.dart';
import 'package:dept_connect/presentation/components/user_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FacultyLoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  FacultyLoginPage({Key? key}) : super(key: key);

  void _facultyLogin(BuildContext context, String user) async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter both email and password.')),
      );
      return;
    }
    final authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);

    authenticationBloc.add(AuthenticationLoginRequested(email, password));
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    String user = args['id']!;

    return Scaffold(
      appBar: AppBar(
        title: Text(user),
        centerTitle: true,
      ),
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UserTextField(
                hintText: "Email",
                obscureText: false,
                controller: _emailController,
              ),
              const SizedBox(height: 10),
              UserTextField(
                hintText: "Password",
                obscureText: true,
                controller: _passwordController,
              ),
              const SizedBox(height: 10),
              UserButton(
                label: "Login",
                onPressed: () => _facultyLogin(context, user),
              ),
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  if (state is AuthenticationInitial) {
                    return Text("Initial");
                  } else if (state is AuthenticationLoading) {
                    return CircularProgressIndicator();
                  } else if (state is AuthenticationAuthenticated) {
                    return Text("Authenticated");
                  } else if (state is AuthenticationUnauthenticated) {
                    return Text('Unauthenticated! Show Login Form');
                  } else if (state is AuthenticationFailure) {
                    return Text('Authentication Failed');
                  } else {
                    return Container();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
