import "package:dept_connect/static/components/hod_drawer.dart";
import "package:dept_connect/static/components/space_tile.dart";
import "package:flutter/material.dart";

class HodSpacePage extends StatelessWidget {
  const HodSpacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Space"),
        centerTitle: true,
      ),
      drawer: HodDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return SpaceTile(
                    title: "2021 - 2025",
                    subtitle: "$index year",
                    onTap: () {
                      Navigator.pushNamed(context, "/hod_batch_page");
                    });
              },
              childCount: 4,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return SpaceTile(
                  title: "19CS53 Operating System",
                  subtitle: "$index year, 4th Sem",
                  onTap: () {},
                );
              },
              childCount: 6,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.grey[50],
        elevation: 3,
        child: Icon(Icons.add),
      ),
    );
  }
}
