import 'package:dept_connect/bloc/hod_batch_people/hod_batch_people_bloc.dart';
import 'package:dept_connect/presentation/components/people_details_heading.dart';
import 'package:dept_connect/presentation/components/people_details_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HodBatchPeopleSection extends StatefulWidget {
  final String dept;
  final String batchId;
  final String section;
  const HodBatchPeopleSection(
      {super.key,
      required this.dept,
      required this.batchId,
      required this.section});

  @override
  State<HodBatchPeopleSection> createState() => _HodBatchPeopleSectionState();
}

class _HodBatchPeopleSectionState extends State<HodBatchPeopleSection> {
  @override
  void initState() {
    super.initState();

    if (widget.section == "1") {
      context
          .read<HodBatchPeopleBloc>()
          .add(FetchPeopleDataSec1(widget.dept, widget.batchId));
    } else if (widget.section == "2") {
      context
          .read<HodBatchPeopleBloc>()
          .add(FetchPeopleDataSec2(widget.dept, widget.batchId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<HodBatchPeopleBloc, HodBatchPeopleState>(
        builder: (context, state) {
          if (state is HodBatchPeopleLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is HodBatchPeopleLoaded) {
            final List<String> studentNames = state.studentNames;
            return CustomScrollView(
              slivers: [
                PeopleDetailsHeading(title: "Tutors"),
                // PeopleDetailsTile(
                //   title: "K Kavitha",
                //   count: 4,
                // ),
                PeopleDetailsHeading(title: "Teachers"),
                // PeopleDetailsTile(
                //   title: "K Priyadharshini",
                //   count: 6,
                // ),
                PeopleDetailsHeading(title: "Students"),
                PeopleDetailsTile(
                  studentNames: studentNames,
                ),
              ],
            );
          } else if (state is HodBatchPeopleError) {
            return Center(child: Text(state.errorMessage));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
