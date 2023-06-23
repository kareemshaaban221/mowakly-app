import 'package:flutter/material.dart';
import 'package:fp/component/complete_widgets/notifications_widget.dart';


class NotificationsPageLawyer extends StatefulWidget {
  const NotificationsPageLawyer({Key? key}) : super(key: key);

  @override
  State<NotificationsPageLawyer> createState() => _NotificationsPageLawyerState();
}

class _NotificationsPageLawyerState extends State<NotificationsPageLawyer> {
  @override
  Widget build(BuildContext context) {
    return NotificationWidget();
  }
}

