import 'package:dept_connect/presentation/components/hod_drawer.dart';
import 'package:dept_connect/presentation/screens/faculty/hod/hod_batch_course_page.dart';
import 'package:dept_connect/presentation/screens/faculty/hod/hod_batch_people_page.dart';
import 'package:dept_connect/presentation/screens/faculty/hod/hod_batch_stream_page.dart';
import 'package:flutter/material.dart';

class HodBatchPage extends StatefulWidget {
  const HodBatchPage({super.key});

  @override
  State<HodBatchPage> createState() => _HodBatchPageState();
}

class _HodBatchPageState extends State<HodBatchPage> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _hodBatchPages = [
    HodBatchStreamPage(),
    HodBatchCoursePage(),
    HodBatchPeoplePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: HodDrawer(),
      body: _hodBatchPages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        selectedItemColor: Colors.purple,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Stream"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Course"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "People"),
        ],
      ),
    );
  }
}
