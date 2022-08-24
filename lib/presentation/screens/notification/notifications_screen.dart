import 'package:flutter/material.dart';
import 'package:la_vie/presentation/resources/color_manager.dart';
import 'package:la_vie/presentation/resources/strings_manager.dart';
import 'package:la_vie/presentation/resources/values_manager.dart';
import 'package:la_vie/presentation/screens/notification/widgets/notification_item.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringManager.notifications),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(AppPadding.p16),
        itemCount: 10,
        itemBuilder: (context, index) => const NotificationItem(),
        separatorBuilder: (context, index) => Divider(color: ColorManager.grey7, height: AppSize.s30),
      ),
    );
  }
}