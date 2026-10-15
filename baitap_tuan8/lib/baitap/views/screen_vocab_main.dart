import 'package:flutter/material.dart';

import '../models/vocab.dart';
import '../services/vocab_file_service.dart';

import 'package:baitap_tuan8/services/notification_service.dart';
import 'package:baitap_tuan8/baitap/views/screen_learn_vocab.dart';
import 'package:baitap_tuan8/baitap/views/screen_quiz_vocab.dart';
import 'package:baitap_tuan8/baitap/views/screen_pending_notifications.dart';

class ScreenVocabMain extends StatefulWidget {
  const ScreenVocabMain({super.key});

  @override
  State<ScreenVocabMain> createState() => _ScreenVocabMainState();
}

class _ScreenVocabMainState extends State<ScreenVocabMain> {
  final TextEditingController wordController = TextEditingController();
  final TextEditingController meaningController = TextEditingController();

  final VocabFileService fileService = VocabFileService();
  final NotificationService notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    notificationService.init();
  }

  void saveAndSchedule() async {
    if (wordController.text.isEmpty || meaningController.text.isEmpty) return;

    String word = wordController.text;
    String meaning = meaningController.text;

    final newVocab = Vocab(word: word, meaning: meaning);
    await fileService.addVocab(newVocab);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Đã lưu từ "$word" - Hãy ôn tập sau 10 phút nhé!'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
        ),
      );
    }

    await notificationService.showSimpleNotification(
      id: DateTime.now().millisecondsSinceEpoch.remainder(10000),
      title: 'Đã lưu từ vựng',
      body: 'Từ "$word" đã được lưu. Hệ thống sẽ nhắc bạn học sau 10 phút.',
    );

    await notificationService.scheduleNotificationAfter(
      const Duration(minutes: 10),
      'learn_vocab_channel',
      'Đến giờ học từ vựng',
      'Đã 10 phút trôi qua, hãy mở app lên và ôn lại từ "$word" nhé!',
    );

    wordController.clear();
    meaningController.clear();

    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Học Từ Vựng"), centerTitle: true),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                "Menu Học Tập",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.add_box),
              title: const Text("Thêm từ vựng"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.school),
              title: const Text("Học từ"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ScreenLearnVocab(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.quiz),
              title: const Text("Kiểm tra từ"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ScreenQuizVocab(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.access_time),
              title: const Text("Lịch nhắc"),
              onTap: () {
                Navigator.pop(context); // Đóng menu
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ScreenPendingNotifications(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: wordController,
              decoration: const InputDecoration(
                labelText: "Từ vựng (Tiếng Anh)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: meaningController,
              decoration: const InputDecoration(
                labelText: "Nghĩa của từ",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: saveAndSchedule,
                icon: const Icon(Icons.notifications_active),
                label: const Text(
                  "Lưu và Nhắc học sau 10 phút",
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
