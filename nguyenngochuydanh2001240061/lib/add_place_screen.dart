import 'package:flutter/material.dart';

import 'database_helper.dart';
import 'place_model.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _ratingController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  final List<String> _availableImages = [
    '1.jpg',
    '2.jpg',
    '3.jpg',
    '4.jpg',
    '5.jpg',
    '6.jpg',
    '7.jpg',
    '8.jpg',
    '9.jpg',
    '10.jpg',
    '11.jpg',
    '12.jpg',
  ];
  late String _selectedImage;

  @override
  void initState() {
    super.initState();
    _selectedImage = _availableImages.first;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ratingController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _savePlace() async {
    if (_formKey.currentState!.validate()) {
      final place = Place(
        name: _nameController.text.trim(),
        rating: double.parse(_ratingController.text.trim()),
        phone: _phoneController.text.trim(),
        address: _addressController.text.trim(),
        image: _selectedImage,
      );

      await DatabaseHelper.instance.insertPlace(place);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lưu địa điểm thành công!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thêm địa điểm'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Chọn ảnh minh họa địa điểm:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _availableImages.length,
                  itemBuilder: (context, index) {
                    final img = _availableImages[index];
                    final isSelected = img == _selectedImage;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedImage = img;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isSelected
                                ? Colors.indigo
                                : Colors.grey.shade300,
                            width: isSelected ? 3 : 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Stack(
                            children: [
                              Image.asset(
                                'assets/images/$img',
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                      width: 80,
                                      height: 80,
                                      color: Colors.grey.shade200,
                                      child: const Icon(Icons.image),
                                    ),
                              ),
                              if (isSelected)
                                Positioned(
                                  top: 4,
                                  right: 4,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.indigo,
                                    ),
                                    child: const Icon(
                                      Icons.check,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Tên địa điểm',
                  hintText: 'Nhập tên địa điểm',
                  prefixIcon: Icon(Icons.place),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Tên địa điểm không được để trống';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _ratingController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Điểm đánh giá (Rating)',
                  hintText: 'Nhập từ 1.0 đến 5.0 (ví dụ: 4.5)',
                  prefixIcon: Icon(Icons.star),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Điểm đánh giá không được để trống';
                  }
                  final rating = double.tryParse(value.trim());
                  if (rating == null) {
                    return 'Điểm đánh giá phải là số';
                  }
                  if (rating < 1.0 || rating > 5.0) {
                    return 'Điểm đánh giá phải nằm trong khoảng từ 1.0 đến 5.0';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Số điện thoại liên hệ',
                  hintText: 'Nhập số điện thoại (tối thiểu 10 số)',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Số điện thoại không được để trống';
                  }
                  if (value.trim().length < 10) {
                    return 'Số điện thoại không được dưới 10 số';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _addressController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'Địa chỉ',
                  hintText: 'Nhập địa chỉ cụ thể',
                  prefixIcon: Icon(Icons.location_on),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Địa chỉ không được để trống';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              ElevatedButton.icon(
                onPressed: _savePlace,
                icon: const Icon(Icons.save),
                label: const Text(
                  'Lưu địa điểm',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
