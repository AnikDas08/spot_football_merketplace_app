import 'package:flutter/material.dart';
import 'package:untitled/features/notifications/presentation/widgets/secondary_appbar.dart';
import 'package:untitled/utils/constants/app_string.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBar(title: AppString.notifications),
    );
  }
}
