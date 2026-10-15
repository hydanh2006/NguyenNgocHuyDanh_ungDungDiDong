import 'package:flutter/material.dart';

import 'dart:math';

import '../models/vocab.dart';
import '../services/vocab_file_service.dart';

class ScreenQuizVocab extends StatefulWidget {
  const ScreenQuizVocab({super.key});

  @override
  State<ScreenQuizVocab> createState() => _ScreenQuizVocabState();
}

class _ScreenQuizVocabState extends State<ScreenQuizVocab> {
  final VocabFileService fileService = VocabFileService();
  List<Vocab> vocabs = [];
  int currentIndex = 0;
  int correctCount = 0;
  int wrongCount = 0;
  bool isLoading = true;

  // Biến lưu trữ đáp án ngẫu nhiên được hiển thị cho người dùng
  String displayedMeaning = "";
  // Biến đánh dấu xem đáp án đang hiển thị có thực sự đúng không
  bool isDisplayedMeaningCorrect = false;

  @override
  void initState() {
    super.initState();
    loadVocabs();
  }

  Future<void> loadVocabs() async {
    final data = await fileService.loadVocabs();
    // Đảo lộn thứ tự danh sách từ vựng để mỗi lần thi một khác
    data.shuffle();
    setState(() {
      vocabs = data;
      isLoading = false;
      if (vocabs.isNotEmpty) {
        generateQuestion();
      }
    });
  }

  // Tạo câu hỏi với đáp án ngẫu nhiên (50% đúng, 50% sai)
  void generateQuestion() {
    Random rand = Random();
    bool shouldDisplayCorrectMeaning = rand
        .nextBool(); // Random true hoặc false

    if (shouldDisplayCorrectMeaning || vocabs.length == 1) {
      // Hiển thị nghĩa đúng
      displayedMeaning = vocabs[currentIndex].meaning;
      isDisplayedMeaningCorrect = true;
    } else {
      // Hiển thị nghĩa sai (lấy nghĩa của một từ ngẫu nhiên khác trong danh sách)
      int randomWrongIndex;
      do {
        randomWrongIndex = rand.nextInt(vocabs.length);
      } while (randomWrongIndex == currentIndex);

      displayedMeaning = vocabs[randomWrongIndex].meaning;
      isDisplayedMeaningCorrect = false;
    }
  }

  // Hàm xử lý khi người dùng bấm nút True hoặc False
  void handleAnswer(bool userChoice) {
    setState(() {
      // Kiểm tra: Nếu người dùng chọn đúng với tính chất của đáp án đang hiển thị
      if (userChoice == isDisplayedMeaningCorrect) {
        correctCount++;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Chính xác!'),
            backgroundColor: Colors.green,
            duration: Duration(milliseconds: 500),
          ),
        );
      } else {
        wrongCount++;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Sai rồi! Nghĩa đúng là: ${vocabs[currentIndex].meaning}',
            ),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 1),
          ),
        );
      }

      // Chuyển câu hoặc kết thúc
      if (currentIndex < vocabs.length - 1) {
        currentIndex++;
        generateQuestion();
      } else {
        showCompletionDialog();
      }
    });
  }

  // Hộp thoại thống kê kết quả bài test
  void showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Hoàn thành bài kiểm tra!"),
        content: Text(
          "Số câu đúng: $correctCount\nSố câu sai: $wrongCount\n\nTỉ lệ đúng: ${((correctCount / vocabs.length) * 100).toStringAsFixed(1)}%",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Đóng dialog
              Navigator.pop(context); // Trở về trang chủ
            },
            child: const Text("Xong"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kiểm Tra Từ"), centerTitle: true),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : vocabs.isEmpty
          ? const Center(child: Text("Cần có ít nhất 2 từ vựng để kiểm tra."))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Hai ô thông báo Đúng/Sai ở trên cùng
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatCard("Câu đúng", correctCount, Colors.green),
                      _buildStatCard("Câu sai", wrongCount, Colors.red),
                    ],
                  ),
                  const Spacer(),

                  // CÂU HỎI
                  Text(
                    "Từ: ${vocabs[currentIndex].word}",
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Có nghĩa là: $displayedMeaning?",
                    style: const TextStyle(fontSize: 22, color: Colors.black87),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Câu ${currentIndex + 1}/${vocabs.length}",
                    style: const TextStyle(color: Colors.grey),
                  ),

                  const Spacer(),

                  // Hai nút True / False
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () => handleAnswer(false),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 15,
                          ),
                        ),
                        child: const Text(
                          "SAI",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => handleAnswer(true),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 15,
                          ),
                        ),
                        child: const Text(
                          "ĐÚNG",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
    );
  }

  Widget _buildStatCard(String title, int count, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 24,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
