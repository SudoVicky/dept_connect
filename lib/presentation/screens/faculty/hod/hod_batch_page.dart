import 'package:dept_connect/presentation/components/hod_drawer.dart';
import 'package:dept_connect/presentation/screens/faculty/hod/hod_batch_course_page.dart';
import 'package:dept_connect/presentation/screens/faculty/hod/hod_batch_people_page.dart';
import 'package:dept_connect/presentation/screens/faculty/hod/hod_batch_stream_page.dart';
import 'package:flutter/material.dart';

class HodBatchPage extends StatefulWidget {
  final String dept;
  final String batchId;
  final int semesterNo;
  final String year;
  const HodBatchPage(
      {super.key,
      required this.batchId,
      required this.semesterNo,
      required this.year,
      required this.dept});

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

  @override
  Widget build(BuildContext context) {
    final List<Widget> hodBatchPages = [
      HodBatchStreamPage(
          dept: widget.dept,
          batchId: widget.batchId,
          semesterNo: widget.semesterNo,
          year: widget.year),
      HodBatchCoursePage(),
      HodBatchPeoplePage(
        dept: widget.dept,
        batchId: widget.batchId,
      ),
    ];

    return Scaffold(
      appBar: AppBar(),
      drawer: HodDrawer(),
      body: hodBatchPages[_selectedIndex],
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
