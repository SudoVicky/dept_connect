import 'package:dept_connect/presentation/components/announcement_input_tile.dart';
import 'package:flutter/material.dart';

class BuildAnnouncementInputTile {
  AnnouncementInputTile buildAnnouncementInputTile(
      TextEditingController announcementMessage) {
    return AnnouncementInputTile(
      hintText: "Announce something to your batch",
      controller: announcementMessage,
      type: "notTitle",
    );
  }

  AnnouncementInputTile buildAnnouncementTitleInputTile(
      TextEditingController announcementTitleMessage) {
    return AnnouncementInputTile(
      hintText: "Enter the Announcement title",
      controller: announcementTitleMessage,
      type: "title",
    );
  }
}
