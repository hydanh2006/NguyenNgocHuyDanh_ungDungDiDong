import 'package:flutter/material.dart';
import 'package:baitap_tuan8/services/notification_service.dart';

class ScreenNotiEx extends StatelessWidget {
  const ScreenNotiEx({super.key});

  @override
  Widget build(BuildContext context) {
    // Khởi tạo service
    NotificationService notificationService = NotificationService();
    notificationService.init();

    return Scaffold(
      appBar: AppBar(title: const Text("Screen Noti Example")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Nút lệnh gửi thông báo ngay tức thì
            ElevatedButton(
              onPressed: () {
                notificationService.showSimpleNotification();
              },
              child: const Text("Gửi thông báo nhắc học Ngoại ngữ"),
            ),
            const SizedBox(height: 20),

            // Nút lệnh hẹn giờ thông báo uống nước sau 2 phút
            ElevatedButton(
              onPressed: () {
                notificationService.scheduleNotificationAfter(
                  const Duration(minutes: 2),
                  'drink_water_channel',
                  'Uống nước',
                  'Nhắc uống nước đúng giờ',
                );
              },
              child: const Text("Gửi thông báo nhắc uống nước sau 2 phút"),
            ),
            const SizedBox(height: 20),

            // Nút lệnh hẹn giờ học Ngoại ngữ sau 10 phút (Đã bổ sung code)
            ElevatedButton(
              onPressed: () {
                notificationService.scheduleNotificationAfter(
                  const Duration(minutes: 10),
                  'learn_english_channel',
                  'Học Ngoại ngữ',
                  'Đã đến giờ học Ngoại ngữ rồi, vào học thôi!',
                );
              },
              child: const Text(
                "Hẹn giờ gửi thông báo học Ngoại ngữ sau 10 phút",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
