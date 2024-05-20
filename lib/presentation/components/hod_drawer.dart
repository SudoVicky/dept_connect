import 'package:dept_connect/bloc/authentication/authentication_bloc.dart';
import 'package:dept_connect/bloc/authentication/authentication_event.dart';
import 'package:dept_connect/bloc/authentication/authentication_state.dart';
import 'package:dept_connect/data/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HodDrawer extends StatelessWidget {
  HodDrawer({super.key});

  void _logout(BuildContext context) async {
    BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationLoggedOut());
    Navigator.pushReplacementNamed(context, '/'); // Navigate to the main page
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.person_rounded,
                  size: 50,
                ),
                Text("Dr.A.Kunthavai"),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.space_dashboard),
            title: Text("Space"),
            splashColor: Colors.grey[150],
            onTap: () {
              final currentRoute = ModalRoute.of(context)?.settings.name;

              if (currentRoute == "/hod_space_page") {
                Navigator.pop(context);
              } else {
                Navigator.popUntil(
                    context, ModalRoute.withName("/hod_space_page"));
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text("Requests"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: () => _logout(context),
          )
        ],
      ),
    );
  }
}
