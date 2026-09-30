import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';

class MediaPickerHome extends StatefulWidget {
  @override
  _MediaPickerHomeState createState() => _MediaPickerHomeState();
}

class _MediaPickerHomeState extends State<MediaPickerHome> {
  File? _mediaFile; // Lưu trữ file media (image hoặc video)
  VideoPlayerController? _videoController; // Điều khiển phát video
  final ImagePicker _picker =
      ImagePicker(); // Khởi tạo ImagePicker để chọn ảnh hoặc video

  // Kiểm tra và yêu cầu quyền truy cập
  Future<void> _requestPermission(Permission permission) async {
    if (await permission.isDenied) {
      // Kiểm tra xem quyền cụ thể (ví dụ: quyền truy cập bộ nhớ, camera, v.v.) có bị từ chối hay không.
      await permission.request(); // Nếu quyền bị từ chối, hiển thị hộp thoại yêu cầu người dùng cấp quyền.
    }
  }

  // Chọn ảnh hoặc video từ gallery
  Future<void> _pickMedia(ImageSource source, bool isVideo) async {
    await _requestPermission(
      isVideo ? Permission.storage : Permission.photos,
    ); // Yêu cầu quyền truy cập bộ nhớ hoặc ảnh

    // Thực hiện việc chọn một tệp media (ảnh hoặc video) từ nguồn được chỉ định (source).
    // Sử dụng thư viện image_picker để chọn ảnh hoặc video. Nếu không chọn được ảnh
    // (pickImage trả về null), sẽ thử chọn video bằng phương thức pickVideo.
    final XFile? pickedFile =
        await _picker.pickImage(
          source: source,
          imageQuality: 100, // Nếu bỏ các tham số này thì ảnh được hiển thị theo kích thước gốc
          maxWidth: 1920,
          maxHeight: 1080,
        ) ??
        await _picker.pickVideo(
          source: source,
        ); // Chọn ảnh hoặc video từ nguồn (camera hoặc thư viện)

    if (pickedFile != null) {
      setState(() {
        _mediaFile = File(pickedFile.path); // Lưu trữ file media đã chọn

        if (_mediaFile!.path.endsWith('.mp4')) {
          // Nếu file là video
          _videoController?.dispose(); // Giải phóng bộ nhớ của video controller trước đó (nếu có)

          _videoController = VideoPlayerController.file(
            _mediaFile!,
          ); // Tạo video controller mới
          _videoController!.initialize().then((_) {
            setState(
              () {},
            ); // Cập nhật giao diện sau khi video controller được khởi tạo
            _videoController!.play(); // Phát video
          });
        } else {
          _videoController?.dispose(); // Giải phóng bộ nhớ của video controller trước đó (nếu có)
          _videoController =
              null; // Đặt video controller về null nếu không phải là video
        }
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('No media selected')));
    }
  }

  // Chụp ảnh hoặc quay video từ camera
  Future<void> _captureMedia(bool isVideo) async {
    await _requestPermission(
      Permission.camera,
    ); // Yêu cầu quyền truy cập camera

    if (isVideo) {
      await _requestPermission(
        Permission.microphone,
      ); // Yêu cầu quyền truy cập microphone nếu là video
    }

    final XFile? capturedFile = isVideo
        ? await _picker.pickVideo(
            source: ImageSource.camera,
          ) // Chọn video từ camera
        : await _picker.pickImage(
            source: ImageSource.camera,
          ); // Chọn ảnh từ camera

    if (capturedFile != null) {
      setState(() {
        _mediaFile = File(capturedFile.path); // Lưu trữ file media đã chọn

        if (isVideo) {
          _videoController?.dispose(); // Giải phóng bộ nhớ của video controller trước đó (nếu có)

          _videoController = VideoPlayerController.file(
            _mediaFile!,
          ); // Tạo video controller mới
          _videoController!.initialize().then((_) {
            setState(
              () {},
            ); // Cập nhật giao diện sau khi video controller được khởi tạo
            _videoController!.play(); // Phát video
          });
        } else {
          _videoController?.dispose(); // Giải phóng bộ nhớ của video controller trước đó (nếu có)
          _videoController =
              null; // Đặt video controller về null nếu không phải là video
        }
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('No media captured')));
    }
  }

  @override
  void dispose() {
    _videoController
        ?.dispose(); // Giải phóng bộ nhớ của video controller khi widget bị hủy
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Media Picker App')),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30, width: 30),
            _mediaFile == null
                ? Text('Chưa chọn ảnh hoặc video.')
                : _videoController != null &&
                      _videoController!.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _videoController!.value.aspectRatio,
                    child: VideoPlayer(_videoController!),
                  )
                : Image.file(_mediaFile!, height: 300),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _pickMedia(ImageSource.gallery, false),
              child: Text('Chọn ảnh từ Gallery'),
            ),
            ElevatedButton(
              onPressed: () => _captureMedia(false),
              child: Text('Chụp ảnh từ Camera'),
            ),
            ElevatedButton(
              onPressed: () => _pickMedia(ImageSource.gallery, true),
              child: Text('Chọn video từ Gallery'),
            ),
            ElevatedButton(
              onPressed: () => _captureMedia(true),
              child: Text('Quay video từ Camera'),
            ),
          ],
        ),
      ),
    );
  }
}
