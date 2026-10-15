import 'package:flutter/material.dart';
import '../models/vocab.dart';
import '../services/vocab_file_service.dart';
import 'package:baitap_tuan8/services/notification_service.dart';

class ScreenLearnVocab extends StatefulWidget {
  const ScreenLearnVocab({super.key});

  @override
  State<ScreenLearnVocab> createState() => _ScreenLearnVocabState();
}

class _ScreenLearnVocabState extends State<ScreenLearnVocab> {
  final VocabFileService fileService = VocabFileService();
  final NotificationService notificationService = NotificationService();
  final TextEditingController answerController = TextEditingController();

  List<Vocab> vocabs = [];
  int currentIndex = 0;
  int correctCount = 0;
  int wrongCount = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    notificationService.init();
    loadVocabs();
  }

  Future<void> loadVocabs() async {
    final data = await fileService.loadVocabs();
    setState(() {
      vocabs = data;
      isLoading = false;
    });
  }

  void checkAnswer() {
    if (answerController.text.isEmpty) return;

    String userAnswer = answerController.text.trim().toLowerCase();
    String correctAnswer = vocabs[currentIndex].meaning.toLowerCase();

    setState(() {
      if (userAnswer == correctAnswer) {
        correctCount++;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Chính xác! 🎉'), backgroundColor: Colors.green, duration: Duration(seconds: 1)),
        );
      } else {
        wrongCount++;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sai rồi! Đáp án đúng là: ${vocabs[currentIndex].meaning}'), backgroundColor: Colors.red, duration: const Duration(seconds: 2)),
        );

        if (wrongCount % 3 == 0) {
          notificationService.showSimpleNotification(
            id: 999,
            title: 'Chú ý học tập!',
            body: 'Bạn đã trả lời sai $wrongCount câu rồi. Hãy tập trung ôn kỹ lại từ vựng nhé!',
          );
        }
      }

      if (currentIndex < vocabs.length - 1) {
        currentIndex++;
        answerController.clear();
      } else {
        showCompletionDialog();
      }
    });
  }

  void showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Hoàn thành bài học!"),
        content: Text("Số câu đúng: $correctCount\nSố câu sai: $wrongCount\n\nTỉ lệ đúng: ${((correctCount / vocabs.length) * 100).toStringAsFixed(1)}%"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text("Trở về trang chủ"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Học Từ"),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : vocabs.isEmpty
              ? const Center(child: Text("Bạn chưa có từ vựng nào. Hãy thêm từ vựng trước nhé!"))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStatCard("Đúng", correctCount, Colors.green),
                          _buildStatCard("Sai", wrongCount, Colors.red),
                        ],
                      ),
                      const SizedBox(height: 40),
                      
                      Text(
                        "Từ vựng: ${vocabs[currentIndex].word}",
                        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                      const SizedBox(height: 20),
                      Text("Câu hỏi ${currentIndex + 1}/${vocabs.length}", style: const TextStyle(color: Colors.grey)),
                      const SizedBox(height: 30),

                      TextField(
                        controller: answerController,
                        decoration: const InputDecoration(
                          labelText: "Nhập nghĩa của từ",
                          border: OutlineInputBorder(),
                        ),
                        onSubmitted: (_) => checkAnswer(),
                      ),
                      const SizedBox(height: 20),
                      
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: checkAnswer,
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
                          child: const Text("Check", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _buildStatCard(String title, int count, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(title, style: TextStyle(fontSize: 16, color: color, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Text(count.toString(), style: TextStyle(fontSize: 24, color: color, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}