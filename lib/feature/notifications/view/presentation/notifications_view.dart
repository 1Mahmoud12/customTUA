import 'package:flutter/material.dart';
import 'package:tua/core/component/custom_app_bar.dart';
import 'package:tua/feature/notifications/view/presentation/widgets/item_notificatino_widget.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'notifications'),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: const [ItemNotificationWidget(), ItemNotificationWidget(), ItemNotificationWidget()],
      ),
    );
  }
}
