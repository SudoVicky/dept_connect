import 'package:flutter/material.dart';
import 'package:dept_connect/presentation/components/space_tile.dart';

class HodPage extends StatelessWidget {
  const HodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Space"),
        centerTitle: true,
      ),
      drawer: Drawer(
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
              onTap: () {},
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
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: 100,
              color: Colors.blue,
              child: Center(
                child: Text(
                  'Static Container 1',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 100,
              color: Colors.green,
              child: Center(
                child: Text(
                  'Static Container 2',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return SpaceTile(
                  title: "2021 - 2025",
                  subtitle: "$index year",
                  onTap: () {},
                );
              },
              childCount: 10,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Colors.grey[50],
        elevation: 3,
      ),
    );
  }
}
