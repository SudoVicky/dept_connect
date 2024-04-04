import 'package:flutter/material.dart';

class HodDrawer extends StatelessWidget {
  const HodDrawer({super.key});

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
            onTap: () {},
          )
        ],
      ),
    );
  }
}
