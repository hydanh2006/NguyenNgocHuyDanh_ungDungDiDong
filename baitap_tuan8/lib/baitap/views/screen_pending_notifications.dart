import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ScreenPendingNotifications extends StatefulWidget {
  const ScreenPendingNotifications({super.key});

  @override
  State<ScreenPendingNotifications> createState() =>
      _ScreenPendingNotificationsState();
}

class _ScreenPendingNotificationsState
    extends State<ScreenPendingNotifications> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  List<PendingNotificationRequest> pendingNotifications = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadPendingNotifications();
  }

  // Lấy danh sách thông báo chưa chạy
  Future<void> loadPendingNotifications() async {
    final List<PendingNotificationRequest> pendingList =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    setState(() {
      pendingNotifications = pendingList;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lịch nhắc nhở"), centerTitle: true),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : pendingNotifications.isEmpty
          ? const Center(
              child: Text("Hiện tại không có lịch nhắc nào đang chờ."),
            )
          : ListView.builder(
              itemCount: pendingNotifications.length,
              itemBuilder: (context, index) {
                final notification = pendingNotifications[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: const Icon(Icons.alarm, color: Colors.blue),
                    title: Text(
                      notification.title ?? "Không có tiêu đề",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(notification.body ?? "Không có nội dung"),
                    trailing: Text(
                      "ID: ${notification.id}",
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
