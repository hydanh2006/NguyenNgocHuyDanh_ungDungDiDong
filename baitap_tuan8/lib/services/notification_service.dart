import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  // ================= INIT =================
  Future<void> init() async {
    // 1. Init timezone
    tz.initializeTimeZones();
    // FIX cứng timezone VN
    tz.setLocalLocation(tz.getLocation('Asia/Ho_Chi_Minh'));

    // 2. Android settings
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);

    // 3. Init plugin
    await _plugin.initialize(settings: settings);

    // 4. Xin quyền notification
    await _requestPermission();
  }

  // ================= REQUEST PERMISSION =================
  // Yêu cầu cấp quyền
  Future<void> _requestPermission() async {
    var status = await Permission.notification.status;

    if (status.isDenied) {
      await Permission.notification.request();
    }

    if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  // ================= HELPER METHODS =================
  // Xây dựng phương thức tạo notification có thể tái sử dụng nhiều lần
  static AndroidNotificationDetails _createAndroidDetails({
    required String channelId,
    required String channelName,
    String? channelDescription,
  }) {
    return AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      visibility: NotificationVisibility.public,
      playSound: true,
      enableVibration: true,
      showWhen: true,
    );
  }

  // Xây dựng phương thức hẹn lịch hiển thị thông báo
  // Hàm tái sử dụng cho thiết lập thời gian để bật notification bằng zonedSchedule
  Future<void> _scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
    required AndroidNotificationDetails androidDetails,
  }) async {
    await _plugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: tz.TZDateTime.from(scheduledTime, tz.local),
      notificationDetails: NotificationDetails(android: androidDetails),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  // ================= PUBLIC METHODS =================
  /// Hàm gửi thông báo tức thì
  Future<void> showSimpleNotification({
    int id = 0,
    String title = 'Nhắc học từ vựng',
    String body = 'Bạn đã học 5 từ mới hôm nay chưa?',
  }) async {
    final details = _createAndroidDetails(
      channelId: 'learn_english_channel',
      channelName: 'Học Anh Văn',
    );

    await _plugin.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: NotificationDetails(android: details),
    );
  }

  /// Đặt lịch thời gian sau 1 khoảng thời gian delay để hiển thị thông báo
  Future<void> scheduleNotificationAfter(
    Duration delay,
    String channelId,
    String channelName,
    String channelDescription,
  ) async {
    final details = _createAndroidDetails(
      channelId: channelId,
      channelName: channelName,
      channelDescription: channelDescription,
    );

    final scheduledTime = tz.TZDateTime.now(tz.local).add(delay);

    await _scheduleNotification(
      id: 1,
      title: channelName,
      body: channelDescription,
      scheduledTime: scheduledTime,
      androidDetails: details,
    );
  }


  /// Lên lịch thông báo vào một thời điểm cụ thể (truyền thẳng DateTime)
  Future<void> scheduleNotificationAt(
    DateTime scheduledTime,
    String channelId,
    String channelName,
    String channelDescription,
    String taskTitle,
  ) async {
    final details = _createAndroidDetails(
      channelId: channelId,
      channelName: channelName,
      channelDescription: channelDescription,
    );

    // Tính toán thời gian delay
    final delay = scheduledTime.difference(DateTime.now());

    // Nếu thời gian hẹn ở quá khứ, không lên lịch
    if (delay.isNegative) return;

    final targetTime = tz.TZDateTime.now(tz.local).add(delay);

    // Dùng id theo mili giây để tạo thông báo độc lập (không đè lên nhau)
    final int notificationId = DateTime.now().millisecondsSinceEpoch.remainder(
      100000,
    );

    await _scheduleNotification(
      id: notificationId,
      title: 'Nhắc nhở công việc',
      body: 'Đến giờ thực hiện: $taskTitle',
      scheduledTime: targetTime,
      androidDetails: details,
    );
  }
}
