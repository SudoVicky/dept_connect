import 'package:dept_connect/bloc/hod_bloc/announcement_page_blocs/announcement_send_bloc/announcement_bloc.dart';
import 'package:dept_connect/bloc/hod_bloc/announcement_page_blocs/announcement_send_bloc/announcement_state.dart';
import 'package:dept_connect/presentation/screens/faculty/hod/build_announcement_tile.dart';
import 'package:dept_connect/presentation/screens/faculty/hod/checkbox_container.dart';
import 'package:dept_connect/presentation/screens/faculty/hod/file_upload_button.dart';
import 'package:dept_connect/presentation/screens/faculty/hod/floating_action_button.dart';
import 'package:dept_connect/utils/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HodBatchAnnouncementPage extends StatefulWidget {
  final String dept;
  final String batchId;
  const HodBatchAnnouncementPage({
    required this.dept,
    required this.batchId,
    super.key,
  });

  @override
  HodBatchAnnouncementPageState createState() =>
      HodBatchAnnouncementPageState();
}

class HodBatchAnnouncementPageState extends State<HodBatchAnnouncementPage> {
  FloatingActionButtons floatingButton = FloatingActionButtons();
  final TextEditingController _announcementMessage = TextEditingController();
  final TextEditingController _announcementTitleMessage =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Announcement"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocListener<AnnouncementBloc, AnnouncementState>(
        listener: (context, state) {
          if (state is AnnouncementSendLoadingState) {
            LoadingDialog.show(context);
          } else if (state is AnnouncementSendSuccessState) {
            if (state.isDetailsPageEditTriggered) {
              Navigator.pop(context);
              Navigator.pop(context);
              LoadingDialog.hide(context);
            } else {
              Navigator.pop(context);
              LoadingDialog.hide(context);
            }

            if (state.id.isNotEmpty) {
              Fluttertoast.showToast(
                msg: "Message updated successfully!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            } else {
              Fluttertoast.showToast(
                msg: "Message posted successfully!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            }
          } else if (state is AnnouncementSendFailureState) {
            LoadingDialog.hide(context);

            Fluttertoast.showToast(
              msg: "Message sent failed!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            print("Vicky: ${state.errorMessage}");
          }
        },
        child: BlocBuilder<AnnouncementBloc, AnnouncementState>(
          builder: (context, state) {
            if (state is AnnouncementEditInitialState) {
              _announcementTitleMessage.text = state.titleMessage;
              _announcementMessage.text = state.announcementMessage;
            } else if (state is AnnouncementInitialState) {
              _announcementTitleMessage.clear();
              _announcementMessage.clear();
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                      ),
                      padding: const EdgeInsets.all(10),
                      child: CheckBoxContainer().buildCheckBoxes(context),
                    ),
                    const SizedBox(height: 10),
                    BuildAnnouncementInputTile()
                        .buildAnnouncementTitleInputTile(
                            _announcementTitleMessage),
                    BuildAnnouncementInputTile()
                        .buildAnnouncementInputTile(_announcementMessage),
                    const SizedBox(height: 5),
                    FileUploadButton().buildFileUploadButton(context),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: floatingButton.buildFloatingActionButton(
        context,
        widget.dept,
        widget.batchId,
        _announcementMessage,
        _announcementTitleMessage,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
