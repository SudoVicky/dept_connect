import "package:dept_connect/bloc/hod_batch/hod_batch_bloc.dart";
import "package:dept_connect/data/models/batch_data.dart";
import "package:dept_connect/presentation/components/hod_drawer.dart";
import "package:dept_connect/presentation/components/space_tile.dart";
import "package:dept_connect/utils/utils.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class HodSpacePage extends StatelessWidget {
  const HodSpacePage({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String dept = args['dept'];

    context.read<HodBatchBloc>().add(HodBatchLoadRequested(dept));

    return Scaffold(
      appBar: AppBar(
        title: Text("Space"),
        centerTitle: true,
      ),
      drawer: HodDrawer(),
      body: BlocBuilder<HodBatchBloc, HodBatchState>(
        builder: (context, state) {
          if (state is HodBatchLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is HodBatchLoaded) {
            return CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      BatchData batchData = state.batchData[index];
                      String year = Utils.convertSemesterToRomanYear(
                          batchData.semesterNo);
                      String batchId = batchData.batchId;
                      int semesterNo = batchData.semesterNo;
                      return SpaceTile(
                          title: batchId,
                          subtitle: "$semesterNo sem, $year year",
                          onTap: () {
                            Navigator.pushNamed(context, "/hod_batch_page",
                                arguments: {
                                  'dept': dept,
                                  'batchId': batchId,
                                  'semesterNo': semesterNo,
                                  'year': year
                                });
                          });
                    },
                    childCount: state.batchData.length,
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
            );
          } else if (state is HodBatchError) {
            return Center(child: Text(state.errorMessage));
          }
          return Container();
        },
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
